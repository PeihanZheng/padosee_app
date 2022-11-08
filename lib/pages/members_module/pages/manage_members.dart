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

import 'package:padosee/widgets/alert_info.dart';

import 'package:padosee/widgets/drawer.dart';
import 'package:padosee/widgets/loader.dart';

import '../../chat_module/chat_screen.dart';
import '../controller/members_controller.dart';

class ManageMembers extends StatelessWidget {
  ManageMembers({Key? key}) : super(key: key);

  final con = Get.put(MembersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: con.scaffoldKey1,
        backgroundColor: ThemeManager.BACKGROUND_COLOR,
        drawer: const MyDrawer(isFromDashboard: false),
        bottomNavigationBar: BottomBar(
          currentIndex: 3,
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
              con.scaffoldKey1.currentState?.openDrawer();
            },
            icon: Image.asset(
              MENU_ICON,
              width: 30,
              color: WHITE_COLOR.withOpacity(.9),
            ),
          ),
          title: Text(
            manageMembersTitle,
            style: textStyle1.copyWith(
              fontSize: 16,
              color: WHITE_COLOR.withOpacity(.9),
            ),
          ),
        ),
        body: Stack(
          children: [
            con.obx(
              (state) => SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: usersList.value.isNotEmpty && userRole.value == "primary"
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: usersList.value.length,
                                    itemBuilder: (context, index) {
                                      var userId = usersList.value[index].id;
                                      var memberData = requestsList.value.firstWhere((element) => element.receiverId == userId);
                                      return memberCard(index, status: memberData.status);
                                    },
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.1,
                                  )
                                ],
                              ),
                            )
                          : const AlertDetails(),
                    ),
                  ],
                ),
              ),
              onLoading: const CommonLoader(),
            ),
            if (userRole.value == "primary")
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: addMemberButton(context),
                ),
              ),
          ],
        ));
  }

  Widget memberCard(int index, {String? status}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: WHITE_COLOR,
      shadowColor: primarycolor.withOpacity(.5),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    usersList.value[index].imageUrl ?? DUMMY_IMG,
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
                  Text(
                    "${usersList.value[index].username}",
                    style: textStyle1.copyWith(fontSize: 16, color: ThemeManager.MENU_COLOR),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Phone : ${usersList.value[index].phone ?? "Not Added"}',
                    style: textStyle1.copyWith(fontSize: 11, color: ThemeManager.SUBTITLE_COLOR, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'House/Apartment no. : ${usersList.value[index].houseAprtmentNo ?? "Not Added"}',
                    style: textStyle1.copyWith(fontSize: 11, color: ThemeManager.SUBTITLE_COLOR, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            status == "requested"
                ? Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primarycolor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10)),
                      ),
                      child: Text(
                        "Requested",
                        style: textStyle1.copyWith(fontSize: 10, color: WHITE_COLOR),
                      ),
                    ),
                  )
                : popupMenuwidget(index),
          ],
        ),
      ),
    );
  }

  Widget popupMenuwidget(int index) {
    UserModel memberData = usersList.value[index];
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: ThemeManager.APP_TEXT_COLOR,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 10,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            dense: true,
            title: Text(
              edit,
              style: textStyle1.copyWith(fontSize: 15, color: TEXT_COLOR, fontWeight: FontWeight.normal),
            ),
            visualDensity: VisualDensity.compact,
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            dense: true,
            title: Text(
              chat,
              style: textStyle1.copyWith(fontSize: 15, color: TEXT_COLOR, fontWeight: FontWeight.normal),
            ),
            onTap: () {
              Get.back();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    memberData,
                  ),
                ),
              );
            },
            visualDensity: VisualDensity.compact,
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            dense: true,
            title: Text(
              activeOrinactive,
              style: textStyle1.copyWith(fontSize: 15, color: TEXT_COLOR, fontWeight: FontWeight.normal),
            ),
            visualDensity: VisualDensity.compact,
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            dense: true,
            title: Text(
              assignAnalytics,
              style: textStyle1.copyWith(fontSize: 15, color: TEXT_COLOR, fontWeight: FontWeight.normal),
            ),
            visualDensity: VisualDensity.compact,
            onTap: () {
              Get.back();
              Get.toNamed(
                '/assign-analytics',
                arguments: memberData,
              );
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            dense: true,
            title: Text(
              close,
              style: textStyle1.copyWith(fontSize: 15, color: TEXT_COLOR, fontWeight: FontWeight.normal),
            ),
            visualDensity: VisualDensity.compact,
            onTap: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }

  Widget addMemberButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(
          "/add-member",
        )?.then(
          (value) => con.onInit(),
        );
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(primarycolor),
        fixedSize: MaterialStateProperty.all(const Size.fromHeight(50)),
      ),
      child: Text(
        addmember,
        style: textStyle1.copyWith(color: WHITE_COLOR, fontSize: 16),
      ),
    );
  }
}

class AlertDetails extends StatelessWidget {
  const AlertDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height - 65,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: userRole.value == "primary"
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ALERT_INFO_ICON,
                      width: 85,
                      color: PRIMARY_COLOR,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "First Add members, then you can manage members",
                      textAlign: TextAlign.center,
                      style: textStyle1.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
                    ),
                  ],
                )
              : const AlertInfo(),
        ),
      ),
    );
  }
}
