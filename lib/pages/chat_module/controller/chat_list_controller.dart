import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/models/data_models/user_model.dart';

class ChatListController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var msgCount = 0.obs;

  getUnreadMsgCount({String? chatroomid, String? memberId}) async {
    QuerySnapshot<Map<String, dynamic>> otherQuerySnapshot = await FirebaseFirestore.instance
        .collection("Chatrooms")
        .doc(chatroomid)
        .collection("messages")
        .where("sender", isEqualTo: memberId)
        .where("seen", isEqualTo: false)
        .get();

    msgCount.value = otherQuerySnapshot.docs.length;
  }

  Future<UserModel?> getUserModelById(String uid) async {
    UserModel? userModel;

    DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection("usersData").doc(uid).get();

    if (docSnap.data() != null) {
      userModel = UserModel.fromJson(docSnap.data() as Map<String, dynamic>);
    }
    return userModel;
  }
}
