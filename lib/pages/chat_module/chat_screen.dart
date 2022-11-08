// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/models/data_models/user_model.dart';

import 'controller/chat_controller.dart';
import 'model/message.dart';

class ChatScreen extends StatefulWidget {
  final UserModel member;
  const ChatScreen(this.member);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final con = Get.put(ChatController());

  @override
  void initState() {
    con.getChatroomModel(widget.member);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat("hh:mm a").format(DateTime.now()).toLowerCase();
    return Scaffold(
      backgroundColor: ThemeManager.BACKGROUND_COLOR,
      appBar: AppBar(
        toolbarHeight: 65,
        titleSpacing: 0,
        backgroundColor: primarycolor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    widget.member.imageUrl ?? DUMMY_IMG,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.member.username ?? "User",
              style: textStyle1.copyWith(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          con.obx(
            (state) => SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: StreamBuilder(
                        key: UniqueKey(),
                        stream: FirebaseFirestore.instance
                            .collection("Chatrooms")
                            .doc(con.chatRoomData.value.chatroomid)
                            .collection("messages")
                            .orderBy("createdon", descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.active) {
                            if (snapshot.hasData) {
                              QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
                              return ListView.builder(
                                reverse: true,
                                itemCount: dataSnapshot.docs.length,
                                itemBuilder: (context, index) {
                                  // seen true for all pending messages
                                  con.seenAllMessages(chatroomid: con.chatRoomData.value.chatroomid, memberId: widget.member.id);

                                  MessageModel currentMessage = MessageModel.forMap(dataSnapshot.docs[index].data() as Map<String, dynamic>);
                                  final time = DateFormat("hh:mm a").format(currentMessage.createdon!).toLowerCase();
                                  return Row(
                                    mainAxisAlignment: (currentMessage.sender == userData.value.id) ? MainAxisAlignment.end : MainAxisAlignment.start,
                                    children: [
                                      msgbubbleWidget(currentMessage, time),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: Get.width,
                    color: primarycolor,
                    child: Row(
                      children: [
                        msgInputWidget(),
                        const SizedBox(width: 10),
                        msgSendButtonWidget(time),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // onLoading: const CommonLoader(),
          ),
        ],
      ),
    );
  }

  Widget msgbubbleWidget(MessageModel currentMessage, String time) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: (currentMessage.sender == userData.value.id) ? Colors.blue.shade800.withOpacity(0.5) : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
          bottomLeft: (currentMessage.sender == userData.value.id) ? const Radius.circular(10) : const Radius.circular(0),
          bottomRight: (currentMessage.sender == userData.value.id) ? const Radius.circular(0) : const Radius.circular(10),
        ),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.6,
        ),
        child: Column(
          crossAxisAlignment: (currentMessage.sender == userData.value.id) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentMessage.text.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  transform: Matrix4.translationValues(0, 5, 0),
                  padding: const EdgeInsets.only(top: 0),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                      if (currentMessage.sender == userData.value.id)
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Image.asset(
                            READ_ICON,
                            width: 17,
                            color: currentMessage.seen ? TEXT_COLOR : Colors.grey.shade300,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget msgInputWidget() {
    return Expanded(
      child: Container(
        width: Get.width,
        height: 50,
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: con.messageController,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: enterMessage,
            hintStyle: textStyle1.copyWith(
              fontSize: 16,
              color: WHITE_COLOR.withOpacity(.7),
              fontWeight: FontWeight.normal,
            ),
          ),
          style: textStyle1.copyWith(
            fontSize: 16,
            color: WHITE_COLOR.withOpacity(.9),
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget msgSendButtonWidget(String time) {
    return SizedBox(
      width: 50,
      height: 50,
      child: FittedBox(
        child: IconButton(
          onPressed: () {
            if (con.messageController.text.isEmpty) {
            } else {
              con.sendMessage(
                memberData: widget.member,
                chatRoomdata: con.chatRoomData.value..updatedTime = time,
              );
            }
          },
          icon: Icon(
            Icons.send_rounded,
            size: 30,
            color: WHITE_COLOR.withOpacity(.9),
          ),
        ),
      ),
    );
  }
}
