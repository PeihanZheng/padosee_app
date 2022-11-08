import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/bottomBar.dart';
import 'package:padosee/common/methods.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/pages/camera_module/controller/assign_camera_controller.dart';

import 'package:padosee/widgets/drawer.dart';
import 'package:padosee/widgets/loader.dart';

class AssignCameraPage extends StatelessWidget {
  final con = Get.put(AssignCameraController());

  AssignCameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        key: con.scaffoldKey,
        backgroundColor: ThemeManager.BACKGROUND_COLOR,
        drawer: const MyDrawer(isFromDashboard: false),
        bottomNavigationBar: BottomBar(
          currentIndex: 2,
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
            addCamera,
            style: textStyle1.copyWith(
              fontSize: 18,
              color: WHITE_COLOR.withOpacity(.9),
            ),
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
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              inputLabel(labelText: "Camera Name"),
                              const SizedBox(height: 8),
                              customTextFormField(context, hintText: "A", controller: con.cameraNameController, action: TextInputAction.next),
                              const SizedBox(height: 20),
                              inputLabel(labelText: "RSTP link"),
                              const SizedBox(height: 8),
                              customTextFormField(context,
                                  hintText: "e.g. rtsp://admin:********", controller: con.cameraLinkController, action: TextInputAction.done),
                              const SizedBox(height: 20),
                              inputLabel(labelText: "Location"),
                              const SizedBox(height: 8),
                              // customTextFormField(hintText: emailAddressHT),
                              Container(
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
                                child: DropdownButtonFormField<String>(
                                  value: con.dropDownValue.value,
                                  dropdownColor: WHITE_COLOR,
                                  borderRadius: BorderRadius.circular(15),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                    hintText: "Select location",
                                    hintStyle: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_HINT_TEXT_COLOR),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                  ),
                                  items: con.locationList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: addCameraButton(context),
                ),
              ),
              if (con.isLoading.value) const CommonLoader(),
            ],
          ),
        ),
      ),
    );
  }

  Widget addCameraButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        var cName = con.cameraNameController.text.trim();
        var cLink = con.cameraLinkController.text.trim();
        var locationV = con.dropDownValue.value;
        if (cName.isEmpty && cLink.isEmpty && locationV == null) {
          customSnackbar(message: "Please Fill All The Details.", isSuccess: false);
        } else if (cName.isEmpty) {
          customSnackbar(message: "Please Enter Camera Name.", isSuccess: false);
        } else if (cLink.isEmpty) {
          customSnackbar(message: "Please Enter Camera RSTP Link.", isSuccess: false);
        } else if (locationV == null) {
          customSnackbar(message: "Please Select Location", isSuccess: false);
        } else {
          con.assignCameraMethod(context);
        }
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
        "Add Camera",
        style: textStyle1.copyWith(color: WHITE_COLOR, fontSize: 16),
      ),
    );
  }

  Widget customTextFormField(BuildContext context, {String? hintText, TextEditingController? controller, TextInputAction? action}) {
    return Container(
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
        textInputAction: action,
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          fillColor: WHITE_COLOR,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          hintText: hintText,
          hintStyle: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_HINT_TEXT_COLOR),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
        cursorColor: textcolor,
        style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
      ),
    );
  }

  Widget inputLabel({String? labelText}) {
    return Text(
      labelText!,
      style: textStyle1.copyWith(fontSize: 14, letterSpacing: 0.5, color: ThemeManager.APP_TEXT_COLOR2),
    );
  }
}
