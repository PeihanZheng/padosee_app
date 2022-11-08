import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/database/firebase_collections.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/models/analytics_models/fr.dart';
import 'package:padosee/models/analytics_models/intrusion.dart';
import 'package:padosee/models/analytics_models/loitering.dart';
import 'package:padosee/models/data_models/camera_model.dart';
import 'package:padosee/models/data_models/notifications_model.dart';
import 'package:padosee/models/data_models/user_model.dart';
import 'package:padosee/services/analytics_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/camera_module/controller/camera_controller.dart';

class DashboardController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var isLoading = false.obs;

  var firstName = "".obs;

  LoiteringModel? loiteringModel = LoiteringModel();
  IntrusionModel? intrusionModel = IntrusionModel();
  FRModel? frModel = FRModel();

  List<CameraModel> assignCameras = [];

  var primaryUserName = Rx<String?>(null);
  var isConnected = false.obs;

  Timer? t;
  Timer? t2;

  var alertCount = 0.obs;

  @override
  onInit() {
    alertCount.value = 0;
    cameraLocationsList.value.clear();
    getUserData();
    // isLoiteringDetected.addListener(getResults);
    // isFRDetected.addListener(getFr);
    super.onInit();
  }

  // @override
  // onClose() {
  //   // isLoiteringDetected.removeListener(getResults);
  //   // isFRDetected.removeListener(getFr);
  //   super.onClose();
  // }

  checkForToken() async {
    var newToken = await FirebaseMessaging.instance.getToken();
    if (newToken != userData.value.fcmToken) {
      userDb.doc(userData.value.id).update({"fcm_token": newToken});
    }
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = UserModel.fromJson(json.decode(prefs.getString("userdata")!));
    DocumentSnapshot<Map<String, dynamic>> docdata = await userDb.doc(data.id).get();
    userData.value = UserModel.fromJson(docdata.data()!);
    userRole.value = userData.value.role!;
    var names = userData.value.username!.split(" ");
    firstName.value = names[0];

    getNotifications();
    getRequests();
    checkForToken();
    getCameraLocationsList();
    // userHasAnalytics();
    getConnectedData();
    // Future.delayed(
    //   const Duration(seconds: 1),
    //   () => callAnalyticsApi(),
    // );
  }

  getNotifications() async {
    if (notificationsList.value.isNotEmpty) {
      notificationsList.value.clear();
    }
    QuerySnapshot<Map<String, dynamic>> notiDb = await requestsDb.get();
    var dataList = notiDb.docs.where((element) => element["receiver_id"] == userData.value.id && element["status"] == "requested");
    for (var element in dataList) {
      notificationsList.value.add(NotificationModel.fromJson(element.data()));
    }
    print("notificatuons:::${notificationsList.value.length}");
    if (notificationsList.value.isNotEmpty) {
      alertCount.value += notificationsList.value.length;
    }
  }

  getRequests() async {
    if (requestsList.value.isNotEmpty) {
      requestsList.value.clear();
    }
    QuerySnapshot<Map<String, dynamic>> notiDb = await requestsDb.get();
    var dataList = notiDb.docs.where((element) => element["sender_id"] == userData.value.id);
    for (var element in dataList) {
      requestsList.value.add(NotificationModel.fromJson(element.data()));
    }
    print("Requests:::${requestsList.value.length}");
    if (requestsList.value.isNotEmpty && userRole.value == "secondary") {
      alertCount.value += requestsList.value.length;
    }
  }

  getCameraLocationsList() async {
    // await AuthenticationService().signInMethod(username: "branch", password: "Graymatics1!");
    var dataList = await cameraDb.where("user_id", isEqualTo: userData.value.id).get();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("locationlist")) {
      prefs.remove("locationlist");
      cameraLocationsList.value.clear();
    }
    if (assignCameras.isNotEmpty) {
      assignCameras.clear();
    }
    for (int i = 0; i < dataList.docs.length; i++) {
      assignCameras.add(CameraModel.fromJson(dataList.docs[i].data()));
    }

    // removing location of assigned camera from list
    assignCameras.removeWhere((element) => element.userId != userData.value.id);
    camerasCount.value = assignCameras.length;
    for (var element in assignCameras) {
      cameraLocationsList.value.add(element.camName.toString());
    }
    var encodedList = json.encode(cameraLocationsList.value);
    prefs.setString("locationlist", encodedList);
    print(cameraLocationsList.value);
  }

  // userHasAnalytics() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey("isConnected")) {
  //     prefs.remove("isConnected");
  //   }
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await cameraDb.where("user_id", isEqualTo: userData.value.id).where("other_id", isNull: false).get();
  //   var objectData = CameraModel.fromJson(querySnapshot.docs.first.data());

  //   if (objectData != null) {
  //     if (objectData.analytics!.isNotEmpty) {
  //       isEnabled.value = true;
  //       prefs.setBool("isConnected", true);
  //       getConnectedData();
  //     }
  //   }
  // }

  getConnectedData() async {
    final prefs = await SharedPreferences.getInstance();
    primaryUserName.value = prefs.getString("primaryUserName");
    isConnected.value = prefs.getBool("isConnected")!;
  }

  callAnalyticsApi() async {
    var dataList = await cameraDb.where("user_id", isEqualTo: userData.value.id).get();
    List<LoiteringModel> analyticsResultsList = [];
    if (analyticsResultsList.isNotEmpty) {
      analyticsResultsList.clear();
    }
    for (int i = 0; i < dataList.docs.length; i++) {
      loiteringModel = await Analytics().loiteringResults(
        accessToken: newAccessToken.value,
        camId: "cam_id",
        start: "2019-10-01T03:00:00.000Z",
        end: "2021-11-01T02:59:59.000Z",
        id: dataList.docs[i]["rtsp_link"],
      );
      if (loiteringModel != null) {
        analyticsResultsList.add(loiteringModel!);
      }
      print('-------------$analyticsResultsList--------------');
    }
  }
}
