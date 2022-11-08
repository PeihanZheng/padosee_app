import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/pages/sidebar%20pages/controller/profile_controller.dart';

import 'package:padosee/widgets/drawer.dart';
import 'package:padosee/widgets/loader.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final con = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      backgroundColor: ThemeManager.BACKGROUND_COLOR,
      drawer: const MyDrawer(isFromDashboard: false),
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
          myprofile,
          style: textStyle1.copyWith(
            color: WHITE_COLOR.withOpacity(.9),
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                size: 33,
                color: WHITE_COLOR.withOpacity(.9),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: con.obx(
          (state) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: Get.height * 0.02, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profilePicWidget(),
                        const SizedBox(height: 15),
                        inputLabel(labelText: username),
                        const SizedBox(height: 5),
                        customTextFormField(
                          hintText: usernameHT,
                          controller: con.nameController,
                          textType: TextInputType.name,
                        ),
                        const SizedBox(height: 20),
                        inputLabel(labelText: emailAddress),
                        const SizedBox(height: 5),
                        customTextFormField(
                          hintText: emailAddressHT,
                          controller: con.emailController,
                          textType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        inputLabel(labelText: phoneNo),
                        const SizedBox(height: 5),
                        customTextFormField(
                          hintText: phoneNoHT,
                          controller: con.phoneController,
                          textType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        inputLabel(labelText: gender),
                        const SizedBox(height: 5),
                        genderSelection(),
                        const SizedBox(height: 20),
                        inputLabel(labelText: houseOrApartmentNo),
                        const SizedBox(height: 5),
                        customTextFormField(
                          hintText: houseorApartmentNoHT,
                          controller: con.houseController,
                          textType: TextInputType.text,
                        ),
                        const SizedBox(height: 20),
                        inputLabel(labelText: address),
                        const SizedBox(height: 5),
                        addressTextfield(),
                        const SizedBox(height: 40),
                        saveProfileButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          onLoading: const CommonLoader(),
        ),
      ),
    );
  }

  Widget saveProfileButton() {
    return ElevatedButton(
      onPressed: () {
        con.saveOrUpdateProfile();
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(primarycolor),
        fixedSize: MaterialStateProperty.all(Size(Get.width, 50)),
      ),
      child: Text(
        saveProfile,
        style: textStyle1.copyWith(color: WHITE_COLOR, fontSize: 16),
      ),
    );
  }

  Widget genderSelection() {
    return Obx(
      () => SizedBox(
        width: Get.width,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                      visualDensity: VisualDensity.compact,
                      value: 'Male',
                      groupValue: con.genderGroup.value,
                      onChanged: (value) {
                        con.changeGenderValue(value.toString());
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      male,
                      style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                      visualDensity: VisualDensity.compact,
                      value: 'Female',
                      groupValue: con.genderGroup.value,
                      onChanged: (value) {
                        con.changeGenderValue(value.toString());
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      female,
                      style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addressTextfield() {
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
        maxLines: 4,
        controller: con.addressController,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          fillColor: WHITE_COLOR,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          hintText: addressHT,
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

  Widget customTextFormField({String? hintText, TextEditingController? controller, TextInputType? textType}) {
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
        keyboardType: textType,
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

  Widget profilePicWidget() {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: Get.width * .32,
              height: Get.width * .32,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: ThemeManager.BLUE_BORDER_COLOR,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 3,
                    color: primarycolor.withOpacity(.25),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    con.imageUrl.value,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: GestureDetector(
              onTap: () {
                con.pickImage();
              },
              child: Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: ThemeManager.BLUE_BORDER_COLOR,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                      spreadRadius: 3,
                      color: ThemeManager.CAMERA_SHOW_COLOR,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      EDIT_PROFILE_CAMERA_ICON,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputLabel({String? labelText}) {
    return Text(
      labelText!,
      style: textStyle1.copyWith(fontSize: 16, letterSpacing: 0.5, color: ThemeManager.APP_TEXT_COLOR2),
    );
  }
}
