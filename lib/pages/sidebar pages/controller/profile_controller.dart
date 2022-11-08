import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/models/data_models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../camera_module/controller/camera_controller.dart';

class ProfileController extends GetxController with StateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var isLoading = false.obs;
  var genderGroup = 'Male'.obs;
  var pickedFile = File("").obs;
  var imageUrl = DUMMY_IMG.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final houseController = TextEditingController();
  final addressController = TextEditingController();

  @override
  onInit() {
    errorText.value = "";
    change('', status: RxStatus.success());
    getUserProfileData();
    super.onInit();
  }

  changeGenderValue(String newValue) {
    genderGroup.value = newValue;
  }

  pickImage() {
    Get.dialog(
      AlertDialog(
        content: Text("Choose Image Source", style: textStyle1.copyWith(color: TEXT_COLOR, fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: ImageSource.camera),
            child: Text("Camera", style: textStyle1.copyWith(color: PRIMARY_COLOR, fontSize: 15)),
          ),
          TextButton(
            onPressed: () => Get.back(result: ImageSource.gallery),
            child: Text("Gallery", style: textStyle1.copyWith(color: PRIMARY_COLOR, fontSize: 15)),
          ),
        ],
      ),
    ).then((source) async {
      if (source != null) {
        final firebaseStorage = FirebaseStorage.instance;
        final pickedImage = await ImagePicker().pickImage(source: source);
        pickedFile.value = File(pickedImage!.path);
        change('', status: RxStatus.loading());
        Future.delayed(const Duration(seconds: 2));
        try {
          TaskSnapshot uploadTask =
              await firebaseStorage.ref().child('images/').child(pickedFile.value.path.split("/").last).putFile(pickedFile.value);
          imageUrl.value = await uploadTask.ref.getDownloadURL();
        } on FirebaseException catch (e) {
          print(e.message);
        }
        change('', status: RxStatus.success());
      }
    });
  }

  getUserProfileData() async {
    change('', status: RxStatus.loading());
    nameController.text = userData.value.username ?? "";
    emailController.text = userData.value.emailAddress ?? "";
    imageUrl.value = userData.value.imageUrl ?? DUMMY_IMG;
    phoneController.text = userData.value.phone ?? "";
    genderGroup.value = userData.value.gender ?? genderGroup.value;
    houseController.text = userData.value.houseAprtmentNo ?? "";
    addressController.text = userData.value.address ?? "";
    change('', status: RxStatus.success());
  }

  saveOrUpdateProfile() async {
    if (nameController.text.isEmpty) {
      errorText.value = "Please Enter Username";
    } else if (emailController.text.isEmpty) {
      errorText.value = "Please Enter Email Address";
    } else if (phoneController.text.isEmpty) {
      errorText.value = "Please Enter Phone Number";
    } else if (houseController.text.isEmpty) {
      errorText.value = "Please Enter House/Aprtment Number";
    } else if (addressController.text.isEmpty) {
      errorText.value = "Please Enter The Address";
    } else {
      change('', status: RxStatus.loading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Future.delayed(const Duration(seconds: 2));
      UserModel data = UserModel(
        id: userData.value.id,
        imageUrl: imageUrl.value,
        username: nameController.text.trim(),
        emailAddress: emailController.text.trim(),
        phone: phoneController.text.trim(),
        gender: genderGroup.value,
        houseAprtmentNo: houseController.text.trim(),
        address: addressController.text.trim(),
        fcmToken: userData.value.fcmToken,
        role: userRole.value,
      );

      errorText.value = "";
      userDb.doc(userData.value.id).update(data.toJson()).whenComplete(() {
        userData.value = data;
        prefs.setString("userdata", json.encode(data));
        change('', status: RxStatus.success());
      });
    }
  }
}
