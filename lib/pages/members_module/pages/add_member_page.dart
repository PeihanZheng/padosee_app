import 'dart:async';

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

import '../controller/add_members_controller.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({Key? key}) : super(key: key);

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  final con = Get.put(AddMemberController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        key: con.scaffoldKey,
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
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 35,
              color: WHITE_COLOR.withOpacity(.9),
            ),
          ),
          title: Text(
            addmember,
            style: textStyle1.copyWith(fontSize: 20, color: WHITE_COLOR.withOpacity(.9)),
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                      color: primarycolor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10, top: 30, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          inputLabel(labelText: userOrEmail),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: Get.width,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: customTextFormField(
                                    hintText: usernameHT,
                                    controller: con.nameOrEmailController,
                                    inputType: TextInputType.name,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {
                                    con.searchMember(con.nameOrEmailController.text);
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    size: 28,
                                    color: WHITE_COLOR,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ValueListenableBuilder(
                    valueListenable: searchedList,
                    builder: (context, List<UserModel> value, _) {
                      if (value.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Searched Members\' :",
                                style: textStyle1.copyWith(
                                  fontSize: 16,
                                  color: ThemeManager.APP_TEXT_COLOR,
                                ),
                              ),
                              const SizedBox(height: 15),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  bool isRequested = usersList.value.any((element) => element.id == value[index].id);
                                  if (value.isNotEmpty) {
                                    FirebaseFirestore.instance
                                        .collection("requests")
                                        .where("receiver_id", isEqualTo: value[index].id)
                                        .get()
                                        .then((element) {
                                      var doc = element.docs.first;
                                      con.memberStatus.value = doc["status"];
                                      print("status:::::${con.memberStatus}");
                                    });
                                  }
                                  return memberCard(index, value[index]);
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget memberCard(int index, UserModel userData) {
    return Obx(
      () => Card(
        elevation: 2,
        color: WHITE_COLOR,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      userData.imageUrl ?? DUMMY_IMG,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  userData.username ?? "",
                  style: textStyle1.copyWith(fontSize: 14),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (con.memberStatus.value == "requested" || con.memberStatus.value == "added") {
                  } else {
                    con.onAddMember(context, memberData: searchedList.value[index]);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      con.isAdded.value || con.memberStatus.value == "requested" || con.memberStatus.value == "added"
                          ? primarycolor
                          : primarycolor.withOpacity(.1)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 5)),
                ),
                child: Text(
                  con.isAdded.value || con.memberStatus.value == "requested"
                      ? "Requested"
                      : con.memberStatus.value == "added"
                          ? "Added"
                          : "+ Add  ",
                  style: textStyle1.copyWith(
                      fontSize: 13,
                      color: con.isAdded.value || con.memberStatus.value == "requested" || con.memberStatus.value == "added"
                          ? WHITE_COLOR
                          : PRIMARY_COLOR),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextFormField({String? hintText, TextEditingController? controller, TextInputType? inputType}) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 3),
            color: Colors.black12,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        onChanged: (value) {
          if (value.isEmpty) {
            searchedList.value.clear();
          }
          setState(() {});
        },
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          hintText: hintText,
          hintStyle: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_HINT_TEXT_COLOR),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
        cursorColor: Colors.black,
        style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
      ),
    );
  }

  Widget inputLabel({String? labelText}) {
    return Text(
      labelText!,
      style: textStyle1.copyWith(fontSize: 14, letterSpacing: 0.5, color: WHITE_COLOR.withOpacity(.6)),
    );
  }
}
