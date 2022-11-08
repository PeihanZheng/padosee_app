import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/database/firebase_collections.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/models/data_models/notifications_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondaryController extends GetxController {
  final scaffoldKey1 = GlobalKey<ScaffoldState>();

  var isLoading = false.obs;

  @override
  onInit() {
    // getNotifications();
    getData();
    super.onInit();
  }

  getData() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    update();
  }

  onAccepted(int index, {NotificationModel? data}) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    QuerySnapshot<Map<String, dynamic>> database = await requestsDb.get();

    var docId = database.docs.firstWhere(
        (element) => element["receiver_id"] == userData.value.id && element["sender_id"] == data!.senderId && element["status"] == "requested");
    requestsDb.doc(docId.id).update({"status": "added"});
    notificationsList.value.removeAt(index);
    prefs.setString("primaryUserName", data!.title.toString());
    update();
    isLoading.value = false;
  }

  onDeclined(int index, {NotificationModel? data}) async {
    QuerySnapshot<Map<String, dynamic>> database = await requestsDb.get();
    var docId = database.docs.firstWhere(
        (element) => element["receiver_id"] == userData.value.id && element["sender_id"] == data!.senderId && element["status"] == "requested");
    requestsDb.doc(docId.id).update({"status": "declined"});
    notificationsList.value.removeAt(index);
    update();
  }

  onArchived(int index, {NotificationModel? data}) async {
    QuerySnapshot<Map<String, dynamic>> database = await requestsDb.get();
    var docId = database.docs.firstWhere(
        (element) => element["receiver_id"] == userData.value.id && element["sender_id"] == data!.senderId && element["status"] == "requested");
    requestsDb.doc(docId.id).update({"status": "archived"});
    notificationsList.value.removeAt(index);
    update();
  }
}
