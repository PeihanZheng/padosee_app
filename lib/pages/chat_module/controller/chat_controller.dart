import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:open_file/open_file.dart';

import 'package:padosee/constants/value_notifiers.dart';

import 'package:padosee/main.dart';

import 'package:padosee/models/data_models/user_model.dart';

import '../model/chatroom_model.dart';
import '../model/message.dart';

class ChatController extends GetxController with StateMixin {
  var imageUrl = "".obs;
  var imageFile = File("").obs;
  var isLoading = false.obs;

  var memberData = UserModel().obs;

  var chatRoomData = ChatRoomModel().obs;

  final messageController = TextEditingController();

  @override
  void onInit() {
    change('', status: RxStatus.success());
    super.onInit();
  }

  // it will open app chat storage file
  Future openFile({required String url, required String? fileName}) async {
    final file = File("${await createFolder()}/$fileName");
    OpenFile.open(file.path);
    log("Path: ${file.path}");
  }

  // it creates folder inside location of app on internal storage
  Future<String> createFolder() async {
    const folderName = "PadoSee_chat";
    var expath = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    final path = Directory("$expath/$folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }

  // for downloading media files
  Future<File?> downLoadFile(String url, String name) async {
    // UIHelper.showLoadingDialog(context, "File Downloading...");

    final file = File("${await createFolder()}/$name");
    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );
      file.writeAsBytes(response.data);
      Get.back();
      // Navigator.pop(context, (route) => route.isFirst);

      return file;
    } catch (e) {
      return null;
    }
  }

  // function that collect data for message and send it
  void sendMessage({UserModel? memberData, String? mediaFilePath, ChatRoomModel? chatRoomdata}) async {
    String msg = messageController.text.trim();
    messageController.clear();

    MessageModel newMessage = MessageModel(
      messageId: uuid.v1(),
      sender: userData.value.id,
      createdon: DateTime.now(),
      text: msg,
      seen: false,
      type: "text",
      mediaFilePath: mediaFilePath,
    );

    FirebaseFirestore.instance
        .collection("Chatrooms")
        .doc(chatRoomdata!.chatroomid)
        .collection("messages")
        .doc(newMessage.messageId)
        .set(newMessage.toMap());

    chatRoomdata.lastMessage = msg;
    FirebaseFirestore.instance.collection("Chatrooms").doc(chatRoomdata.chatroomid).set(chatRoomdata.toMap());

    DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance.collection('usersData').doc(memberData!.id).get();

    final targetObject = data.data();
    final token = targetObject!['fcm_token'];

    sendNotification(token: token, username: userData.value.username, message: msg);
  }

  // fcm push notification triggers fron here
  Future<void> sendNotification({String? token, String? username, String? message}) async {
    final data = {
      "to": token,
      "notification": {
        "body": message,
        "title": username,
        "sound": "default",
      },
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "screen": "messages",
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

  // checks that chat of user is available or not
  Future<void> getChatroomModel(UserModel targetUser) async {
    change('', status: RxStatus.loading());

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Chatrooms")
        .where("participants.${userData.value.id}", isEqualTo: true)
        .where("participants.${targetUser.id}", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var docData = snapshot.docs[0].data();
      log(docData.toString());
      ChatRoomModel existingChatroom = ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoomData.value = existingChatroom;
    } else {
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        updatedTime: "",
        participants: {
          userData.value.id.toString(): true,
          targetUser.id.toString(): true,
        },
      );

      await FirebaseFirestore.instance.collection("Chatrooms").doc(newChatroom.chatroomid).set(newChatroom.toMap());

      chatRoomData.value = newChatroom;

      log("New Chatroom Created!");
    }
    change('', status: RxStatus.success());
  }

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      imageFile.value = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  Future uploadImage() async {
    isLoading.value = true;
    final firebaseStorage = FirebaseStorage.instance;
    String filename = const Uuid().v1();

    TaskSnapshot uploadTask =
        await firebaseStorage.ref().child('images/').child('$filename.${imageFile.value.path.split(".").last}').putFile(imageFile.value);
    imageUrl.value = await uploadTask.ref.getDownloadURL();

    log(imageUrl.value);
    sendMessage(mediaFilePath: imageUrl.value);
    isLoading.value = false;
  }

  seenAllMessages({String? chatroomid, String? memberId}) async {
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection("Chatrooms")
        .doc(chatroomid)
        .collection("messages")
        .where("sender", isEqualTo: memberId)
        .where("seen", isEqualTo: false)
        .get();

    for (var element in query.docs) {
      element.reference.update({"seen": true});
    }
  }
}
