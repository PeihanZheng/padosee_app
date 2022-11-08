import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/bottomBar.dart';
import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/models/data_models/user_model.dart';

import 'package:padosee/widgets/drawer.dart';

import 'chat_screen.dart';
import 'controller/chat_list_controller.dart';
import 'model/chatroom_model.dart';

class MembersChatScreen extends StatefulWidget {
  const MembersChatScreen({Key? key}) : super(key: key);

  @override
  State<MembersChatScreen> createState() => _MembersChatScreenState();
}

class _MembersChatScreenState extends State<MembersChatScreen> {
  final con = Get.put(ChatListController());

  @override
  void initState() {
    updateData();
    super.initState();
  }

  updateData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      backgroundColor: ThemeManager.BACKGROUND_COLOR,
      drawer: const MyDrawer(isFromDashboard: false),
      bottomNavigationBar: BottomBar(
        currentIndex: 4,
        onTapFunc: (val) {
          changeNav(context, val);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: primarycolor,
        leading: IconButton(
          onPressed: () {
            con.scaffoldKey.currentState?.openDrawer();
          },
          icon: Image.asset(
            MENU_ICON,
            width: 30,
            color: WHITE_COLOR.withOpacity(.9),
          ),
        ),
        title: Text(
          messages,
          style: textStyle1.copyWith(
            fontSize: 18,
            color: WHITE_COLOR.withOpacity(.9),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Column(
                    children: [
                      StreamBuilder(
                        key: UniqueKey(),
                        stream: FirebaseFirestore.instance
                            .collection("Chatrooms")
                            .where("participants.${userData.value.id}", isEqualTo: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          // if (snapshot.connectionState == ConnectionState.active) {
                          if (snapshot.hasData) {
                            QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;
                            if (chatRoomSnapshot.docs.isNotEmpty) {
                              return ListView.separated(
                                separatorBuilder: ((context, index) {
                                  return const Divider(
                                    thickness: 1,
                                  );
                                }),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: chatRoomSnapshot.docs.length,
                                itemBuilder: (context, index) {
                                  ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(chatRoomSnapshot.docs[index].data() as Map<String, dynamic>);

                                  Map<String, dynamic> participants = chatRoomModel.participants!;

                                  List<String> participantKeys = participants.keys.toList();

                                  participantKeys.remove(userData.value.id);

                                  con.getUnreadMsgCount(chatroomid: chatRoomModel.chatroomid, memberId: participantKeys[0]);

                                  return FutureBuilder(
                                    future: con.getUserModelById(participantKeys[0]),
                                    builder: (context, userData) {
                                      if (userData.connectionState == ConnectionState.done) {
                                        if (userData.data != null) {
                                          UserModel targetUser = userData.data as UserModel;
                                          return memberChatCard(chatroomData: chatRoomModel, memberData: targetUser, msgCount: con.msgCount.value);
                                        } else {
                                          return const SizedBox();
                                        }
                                      } else {
                                        return SizedBox(
                                          height: Get.height - 65,
                                          width: Get.width,
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              );
                            } else {
                              return SizedBox(
                                height: Get.height - 65,
                                width: Get.width,
                                child: Center(
                                  child: Text(
                                    "No Messages",
                                    style: textStyle1.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
                                  ),
                                ),
                              );
                            }
                          }
                          // else {
                          //   return const SizedBox();
                          // }
                          // }
                          return const SizedBox();
                        },
                      ),
                      const Divider(
                        thickness: 1,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget memberChatCard({ChatRoomModel? chatroomData, UserModel? memberData, var msgCount}) {
    // final time = DateFormat("hh:mm a").format(chatroomData.).toLowerCase();
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(memberData!),
          ),
        );
      },
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 13, right: 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: ThemeManager.CARD_COLOR,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    memberData?.imageUrl ?? DUMMY_IMG,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            memberData?.username ?? "User",
                            style: textStyle1.copyWith(
                              fontSize: 16,
                              color: ThemeManager.APP_TEXT_COLOR2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            chatroomData?.lastMessage ?? "Send Message",
                            style: textStyle1.copyWith(
                              color: ThemeManager.SUBTITLE_COLOR,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            chatroomData?.updatedTime ?? "",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontFamily: poppins,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (msgCount > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                              decoration: BoxDecoration(
                                color: PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                msgCount.toString(),
                                style: const TextStyle(
                                  fontFamily: poppins,
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
