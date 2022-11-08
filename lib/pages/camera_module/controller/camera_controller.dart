import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/controller/dashboard_controller.dart';
import 'package:padosee/models/data_models/camera_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/methods.dart';

final userDb = FirebaseFirestore.instance.collection("usersData");

final cameraDb = FirebaseFirestore.instance.collection("camera_list");

class CameraController extends GetxController with StateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<CameraModel> assignCameras = [];

  List<VlcPlayerController>? controllers;

  var isLoading = false.obs;

  @override
  void onInit() {
    change('', status: RxStatus.success());
    getCameraList();
    super.onInit();
  }

  getCameraList() async {
    change('', status: RxStatus.loading());
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("locationlist")) {
      prefs.remove("locationlist");
      cameraLocationsList.value.clear();
    }
    var dataList = await cameraDb.where("user_id", isEqualTo: userData.value.id).get();
    if (assignCameras.isNotEmpty) {
      assignCameras.clear();
    }
    for (int i = 0; i < dataList.docs.length; i++) {
      assignCameras.add(CameraModel.fromJson(dataList.docs[i].data()));
    }
    for (var element in assignCameras) {
      cameraLocationsList.value.add(element.camLocation.toString());
    }
    var encodedList = json.encode(cameraLocationsList.value);
    prefs.setString("locationlist", encodedList);
    print(cameraLocationsList.value);
    change('', status: RxStatus.success());
    // await getControllers();
    print(assignCameras.length.toString());
  }

  onRemoveCamera(BuildContext context, num cameraId) async {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          "Are you sure?",
          style: textStyle1.copyWith(
            color: textcolor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: .5,
          ),
        ),
        content: Text(
          "Are you sure that you want to remove this Camera?",
          style: textStyle1.copyWith(
            color: ThemeManager.APP_HINT_TEXT_COLOR,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Cancel",
              style: textStyle1.copyWith(
                fontSize: 16,
                color: TEXT_COLOR,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              var collectionRef = cameraDb.where("cam_id", isEqualTo: cameraId).get();
              collectionRef.then((value) {
                value.docs.forEach((element) {
                  element.reference.delete();
                });
              }).then((value) {
                customSnackbar(message: "Camera Removed Successfully", isSuccess: true);
              });
            },
            child: Text(
              "Confirm",
              style: textStyle1.copyWith(
                fontSize: 16,
                color: Colors.red[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
