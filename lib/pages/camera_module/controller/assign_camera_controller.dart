import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/controller/dashboard_controller.dart';
import 'package:padosee/models/data_models/camera_model.dart';

import '../../../common/methods.dart';
import 'camera_controller.dart';

class AssignCameraController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final cameraNameController = TextEditingController();
  final cameraLinkController = TextEditingController();

  var dropDownValue = Rx<String?>(null);

  var isLoading = false.obs;

  List<String> locationList = [
    "Home",
    "Apartment",
    "Neighbourhood",
  ];

  @override
  void onInit() {
    errorText.value = "";
    dropDownValue.value = null;
    isLoading.value = false;
    super.onInit();
  }

  onchangeValue(var newValue) {
    dropDownValue.value = newValue;
  }

  assignCameraMethod(BuildContext context) async {
    isLoading.value = true;
    QuerySnapshot<Map<String, dynamic>> cameraListlength = await cameraDb.orderBy("cam_id", descending: false).get();
    final int camId;
    if (cameraListlength.docs.isNotEmpty) {
      QueryDocumentSnapshot<Map<String, dynamic>> lastObject = cameraListlength.docs.last;
      camId = lastObject["cam_id"] + 1;
    } else {
      camId = 1;
    }

    final data = CameraModel(
      camId: camId,
      camName: cameraNameController.text.trim(),
      userId: userData.value.id,
      rtspLink: cameraLinkController.text.trim(),
      camLocation: dropDownValue.value,
    );

    try {
      cameraDb.doc().set(data.toJson()).whenComplete(() {
        if (userRole.value == "secondary") {
          userRole.value = "primary";
          userDb.doc(userData.value.id).update({"user_type": "primary"});
        }
        cameraNameController.clear();
        cameraLinkController.clear();
        dropDownValue.value = null;
        errorText.value = "";
        isLoading.value = false;
      }).then((value) {
        customSnackbar(message: "Camera Added Successfully", isSuccess: true);
      });
    } on FirebaseException {
      customSnackbar(message: "Something went wrong.", isSuccess: false);
    }
  }
}
