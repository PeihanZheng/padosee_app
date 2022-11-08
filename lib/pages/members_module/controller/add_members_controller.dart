import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/controller/dashboard_controller.dart';
import 'package:padosee/main.dart';
import 'package:padosee/models/data_models/notifications_model.dart';

import 'package:padosee/constants/database/firebase_collections.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/models/data_models/user_model.dart';
import 'package:padosee/widgets/email_checker.dart';

import '../../../common/methods.dart';
import '../../camera_module/controller/camera_controller.dart';

class AddMemberController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var isLoading = false.obs;
  var isAdded = false.obs;
  var memberStatus = "".obs;

  final nameOrEmailController = TextEditingController();

  Timer? t1;

  @override
  void onInit() {
    isLoading.value = false;
    errorText.value = "";
    super.onInit();
  }

  @override
  onClose() {
    nameOrEmailController.dispose();
    if (searchedList.value.isNotEmpty) {
      searchedList.value.clear();
    }
    super.onClose();
  }

  searchMember(String value) async {
    if (value.isEmpty) {
      errorText.value = "Please Enter The Usename/Email Address";
    } else {
      isLoading.value = true;

      Future.delayed(const Duration(seconds: 1));
      QuerySnapshot<Map<String, dynamic>> result;
      if (EmailChecker.isNotValid(value.trim())) {
        result = await userDb.where("username", isEqualTo: value.trim()).get();
      } else {
        result = await userDb.where("email_address", isEqualTo: value.trim()).get();
      }

      if (result.docs.isEmpty) {
        customSnackbar(message: "Member Not Found", isSuccess: false);
        isLoading.value = false;
      } else {
        String memberId = result.docs.first.id;
        for (int i = 0; i < result.docs.length; i++) {
          if (searchedList.value.any((element) => element.id == result.docs[i].id)) {
            result.docs.removeWhere((element) => element.id == result.docs[i].id);
            // searchedList.value.removeWhere((element) => element.id == result.docs[i].id);
          } else {
            searchedList.value.add(UserModel.fromJson(result.docs[i].data()));
          }
        }
        searchedList.value.removeWhere((element) => element.id == userData.value.id);
        errorText.value = "";
        isLoading.value = false;
      }
    }
  }

  onAddMember(BuildContext context, {UserModel? memberData}) async {
    isAdded.value = !isAdded.value;
    // if (usersList.value.any((element) => element.id == memberData!.id)) {
    //   usersList.value.removeWhere((element) => element.id == memberData!.id);
    // }
    if (isAdded.value) {
      final notificationData = NotificationModel(
        type: "request",
        senderId: userData.value.id,
        receiverId: memberData!.id,
        title: userData.value.username,
        subtitle: "wants you to add as a member",
        profileImage: userData.value.imageUrl,
        status: "requested",
      );
      requestsDb.doc().set(notificationData.toJson());

      DocumentSnapshot<Map<String, dynamic>> memberDoc = await userDb.doc(memberData.id).get();
      usersList.value.add(UserModel.fromJson(memberDoc.data()!));

      sendNotification(memberData.fcmToken!, notificationData);
      customSnackbar(message: "Request Sent", isSuccess: true);
    } else {
      QuerySnapshot<Map<String, dynamic>> datbase = await requestsDb.get();
      if (datbase.docs.any((element) => element["receiver_id"] == memberData!.id)) {
        datbase.docs.removeWhere((element) => element["receiver_id"] == memberData!.id);
        if (usersList.value.any((element) => element.id == memberData!.id)) {
          usersList.value.removeWhere((element) => element.id == memberData!.id);
        }
      }
    }
  }

  Future<void> sendNotification(String token, NotificationModel messageData) async {
    final data = {
      "to": token,
      "notification": {
        "body": messageData.subtitle,
        "title": messageData.title,
        "sound": "default",
      },
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "screen": "alerts_page",
      },
      "priority": "high",
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAActgQi3s:APA91bF4DPcyQfTwSIML4V04B5QoG1yI4wwH6AOgaI29ng7-kKDhwNVIamXaPVe9L-R72u_6H6_ypqvEq4_26zty-fnar4XMTC4gP3OMXVShVPKtydjsHZxtLrFmjpMrWpiT3aqGX617',
    };

    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );

    try {
      final response = await Dio(options).post(
        'https://fcm.googleapis.com/fcm/send',
        data: json.encode(data),
      );

      if (response.statusCode == 200) {
        log('notification sent');
        print(response.data);
      } else {
        print('error occured');
      }
    } catch (error) {
      print(error);
    }
    return;
  }
}
