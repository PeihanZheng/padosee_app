import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/bottomBar.dart';
import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/models/data_models/user_model.dart';
import 'package:padosee/widgets/drawer.dart';
import 'package:padosee/widgets/loader.dart';

import '../controller/assign_analytics_controller.dart';

class AssignAnalytics extends StatefulWidget {
  const AssignAnalytics({Key? key}) : super(key: key);

  @override
  State<AssignAnalytics> createState() => _AssignAnalyticsState();
}

class _AssignAnalyticsState extends State<AssignAnalytics> {
  final con = Get.put(AssignAnalyticsController());

  UserModel memberData = UserModel();

  @override
  Widget build(BuildContext context) {
    memberData = Get.arguments;
    con.memberNameController.text = memberData.username.toString();
    return Scaffold(
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
        backgroundColor: ThemeManager.BACKGROUND_COLOR,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 35,
            color: ThemeManager.MENU_COLOR,
          ),
        ),
        title: Text(
          assignAnalytics,
          style: textStyle1.copyWith(color: ThemeManager.TITLE_COLOR),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 25, right: 25, top: Get.height * 0.02, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            inputLabel(labelText: "Member Name"),
                            const SizedBox(height: 5),
                            customTextFormField(context, hintText: "e.g. rocco morrio"),
                            const SizedBox(height: 20),
                            inputLabel(labelText: "Camera Name"),
                            const SizedBox(height: 5),
                            DropdownButtonFormField<String>(
                              value: con.dropDownValue.value,
                              dropdownColor: ThemeManager.CARD_COLOR,
                              decoration: InputDecoration(
                                isDense: true,
                                isCollapsed: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                                hintText: "Select Camera",
                                hintStyle: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_HINT_TEXT_COLOR),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                                errorBorder: InputBorder.none,
                              ),
                              items: con.locationList.value.map<DropdownMenuItem<String>>((dynamic value) {
                                return DropdownMenuItem<String>(
                                  value: value as String,
                                  child: Text(
                                    value,
                                    style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                con.onchangeValue(newValue);
                              },
                            ),
                            const SizedBox(height: 20),
                            inputLabel(labelText: "Select Analytics"),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  activeColor: primarycolor,
                                  value: con.check1.value,
                                  onChanged: (value) {
                                    con.changeValue1(value);
                                  },
                                ),
                                Text(
                                  "Loitering",
                                  style: textStyle1.copyWith(
                                    fontSize: 16,
                                    color: ThemeManager.APP_TEXT_COLOR,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  activeColor: primarycolor,
                                  value: con.check2.value,
                                  onChanged: (value) {
                                    con.changeValue2(value);
                                  },
                                ),
                                Text(
                                  "Intrusion",
                                  style: textStyle1.copyWith(
                                    fontSize: 16,
                                    color: ThemeManager.APP_TEXT_COLOR,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  activeColor: primarycolor,
                                  value: con.check3.value,
                                  onChanged: (value) {
                                    con.changeValue3(value);
                                  },
                                ),
                                Text(
                                  "Facial Recognition",
                                  style: textStyle1.copyWith(
                                    fontSize: 16,
                                    color: ThemeManager.APP_TEXT_COLOR,
                                  ),
                                ),
                              ],
                            ),
                            ValueListenableBuilder(
                              valueListenable: errorText,
                              builder: (context, value, _) {
                                if (value != "") {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          value.toString(),
                                          textAlign: TextAlign.center,
                                          style: textStyle1.copyWith(fontSize: 14, color: Colors.red, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  );
                                }
                                return const SizedBox(height: 20);
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                if (con.memberNameController.text.isEmpty) {
                                  errorText.value = "Please Enter The Member Name";
                                } else if (con.dropDownValue.value == null) {
                                  errorText.value = "Please Select Location";
                                } else if (!con.check1.value && !con.check2.value && !con.check3.value) {
                                  errorText.value = "Please Select Atleast One Analytics";
                                } else {
                                  con.assignAnalytics(context, memberData: memberData);
                                  // String rstpLink = con.cameraLinkController.text.trim();
                                  // print(rstpLink);
                                  // print(con.dropDownValue.value);
                                  // Future.delayed(const Duration(seconds: 0), () {
                                  //   con.assignCameraMethod();
                                  // });
                                }
                              },
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size(Get.width, 50)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                side: MaterialStateProperty.all(const BorderSide(
                                  width: 2,
                                  color: primarycolor,
                                  style: BorderStyle.solid,
                                )),
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: Text(
                                "Assign",
                                style: textStyle1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (con.isLoading.value) const CommonLoader(),
          ],
        ),
      ),
    );
  }

  Widget customTextFormField(BuildContext context, {String? hintText}) {
    return TextFormField(
      controller: con.memberNameController,
      decoration: InputDecoration(
        isDense: true,
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        hintText: hintText,
        hintStyle: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_HINT_TEXT_COLOR),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: primarycolor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        errorBorder: InputBorder.none,
      ),
      cursorColor: primarycolor,
      style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
    );
  }

  Widget inputLabel({String? labelText}) {
    return Text(
      labelText!,
      style: textStyle1.copyWith(fontSize: 16, letterSpacing: 0.5, color: ThemeManager.APP_TEXT_COLOR2),
    );
  }
}
