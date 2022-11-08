import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/database/firebase_collections.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/models/data_models/notifications_model.dart';

import 'package:padosee/models/data_models/user_model.dart';

import '../../camera_module/controller/camera_controller.dart';

class MembersController extends GetxController with StateMixin {
  final scaffoldKey1 = GlobalKey<ScaffoldState>();

  var isLoading = false.obs;

  var isConfirmed = false.obs;

  @override
  onInit() {
    errorText.value = "";
    change('', status: RxStatus.success());
    getRequests();
    getMembers();
    super.onInit();
    // Future.delayed(const Duration(seconds: 5), () {
    //   onInit();
    // });
  }

  getMembers() async {
    change('', status: RxStatus.loading());
    QuerySnapshot<Map<String, dynamic>> notiDb = await requestsDb.get();
    if (notiDb.docs.isEmpty) {
      usersList.value = [];
      change('', status: RxStatus.success());
    } else {
      if (usersList.value.isNotEmpty) {
        usersList.value.clear();
      }
      var dataList = notiDb.docs.where((element) => element["sender_id"] == userData.value.id);
      for (var element in dataList) {
        DocumentSnapshot<Map<String, dynamic>> docData = await userDb.doc(element["receiver_id"]).get();
        usersList.value.add(UserModel.fromJson(docData.data()!));
      }
      print("Users:::${usersList.value.length}");
    }
    change('', status: RxStatus.success());
  }

  getRequests() async {
    isLoading.value = true;
    if (requestsList.value.isNotEmpty) {
      requestsList.value.clear();
    }
    QuerySnapshot<Map<String, dynamic>> notiDb = await requestsDb.get();
    var dataList = notiDb.docs.where((element) => element["sender_id"] == userData.value.id);
    for (var element in dataList) {
      requestsList.value.add(NotificationModel.fromJson(element.data()));
    }
    print("Requests:::${requestsList.value.length}");
    isLoading.value = false;
  }

  // getRequests() async {
  //   isLoading.value = true;
  //   Future.delayed(const Duration(seconds: 1));
  //   QuerySnapshot<Map<String, dynamic>> notiDb = await requestsDb.get();
  //   var dataList = notiDb.docs.where((element) => element["sender_id"] == userData.value.id);
  //   for (var element in dataList) {
  //     requestsList.value.add(NotificationModel.fromJson(element.data()));
  //   }
  //   print("Requests:::${requestsList.value.length}");
  //   isLoading.value = false;
  // }

  // getMembers() async {
  //   isLoading.value = true;
  //   Future.delayed(const Duration(seconds: 2));
  //   var dataList = await membersDb.get();
  //   for (int i = 0; i < dataList.docs.length; i++) {
  //     membersList.add(MemberModel.fromJson(dataList.docs[i].data()));
  //   }
  //   print(membersList.length);
  //   isLoading.value = false;
  // }

}
