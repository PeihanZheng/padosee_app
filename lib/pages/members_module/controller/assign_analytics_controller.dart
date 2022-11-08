import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/controller/dashboard_controller.dart';
import 'package:padosee/main.dart';
import 'package:padosee/models/data_models/camera_model.dart';
import 'package:padosee/models/data_models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/methods.dart';
import '../../camera_module/controller/camera_controller.dart';

class AssignAnalyticsController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final memberNameController = TextEditingController();

  var isLoading = false.obs;

  var dropDownValue = Rx<String?>(null);

  var analyticsList = <num>[];

  var check1 = false.obs;

  @override
  onInit() {
    errorText.value = "";
    analyticsList.clear();
    getLocationsList();
    super.onInit();
  }

  changeValue1(var newValue) {
    check1.value = newValue;
    // if (check1.value) {
    //   // id 2 for loitering
    //   analyticsList.add(2);
    // } else {
    //   analyticsList.remove(2);
    // }
    print(analyticsList.toString());
  }

  var check2 = false.obs;

  changeValue2(var newValue) {
    check2.value = newValue;
    // if (check2.value) {
    //   // id 17 for intrusion
    //   analyticsList.add(17);
    // } else {
    //   analyticsList.remove(17);
    // }
    print(analyticsList.toString());
  }

  var check3 = false.obs;

  changeValue3(var newValue) {
    check3.value = newValue;
    // if (check3.value) {
    //   // id 0 for intrusion
    //   analyticsList.add(0);
    // } else {
    //   analyticsList.remove(0);
    // }
    print(analyticsList.toString());
  }

  var locationList = [].obs;

  getLocationsList() async {
    final prefs = await SharedPreferences.getInstance();
    locationList.value = json.decode(prefs.getString("locationlist").toString());
    print(locationList.toString());
  }

  onchangeValue(var newValue) {
    dropDownValue.value = newValue;
  }

  assignAnalytics(BuildContext context, {UserModel? memberData}) async {
    isLoading.value = true;
    if (memberNameController.text.isEmpty) {
      errorText.value = "Please Enter The Member Name";
    } else if (dropDownValue.value == "") {
      errorText.value = "Please Select Camera Name";
    } else if (!check1.value && !check2.value && !check3.value) {
      errorText.value = "Please Select Atleast One Analytics";
    } else {
      try {
        DocumentSnapshot docSnapshot = await userDb.doc(memberData!.id).get();
        // QuerySnapshot<Map<String, dynamic>> cameraDatabase = await cameraDb.orderBy("cam_id", descending: false).get();
        // var dataList =
        //     cameraDatabase.docs.where(((element) => element["user_id"] == userData.value.id && element["cam_name"] == dropDownValue.value));
        // var cameradata = CameraModel.fromJson(dataList.first.data());
        // final int camId;
        // if (cameraDatabase.docs.isNotEmpty) {
        //   QueryDocumentSnapshot<Map<String, dynamic>> lastObject = cameraDatabase.docs.last;
        //   camId = lastObject["cam_id"] + 1;
        // } else {
        //   camId = 1;
        // }

        // final data = CameraModel(
        //   userId: memberData!.id,
        //   otherId: userData.value.id,
        //   camId: camId,
        //   camName: dropDownValue.value,
        //   camLocation: cameradata.camLocation,
        //   rtspLink: cameradata.rtspLink,
        //   analytics: [2],
        //   isAssigned: true,
        // );

        // cameraDb.doc().set(data.toJson()).whenComplete(() {
        errorText.value = "";
        dropDownValue.value = null;
        check1.value = false;
        check2.value = false;
        check3.value = false;
        // });
        customSnackbar(message: "Camera Assigned Successfully", isSuccess: true);
      } on FirebaseException {
        customSnackbar(message: "Something went wrong.", isSuccess: false);
      }
    }
    isLoading.value = false;
  }
}
