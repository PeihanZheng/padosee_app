import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';

import 'package:padosee/widgets/drawer.dart';

import '../../constants/theme/assets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obsecureText1 = true;
  bool _obsecureText2 = true;
  bool _obsecureText3 = true;

  void _toggle1() {
    setState(() {
      _obsecureText1 = !_obsecureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obsecureText2 = !_obsecureText2;
    });
  }

  void _toggle3() {
    setState(() {
      _obsecureText3 = !_obsecureText3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ThemeManager.BACKGROUND_COLOR,
      drawer: const MyDrawer(isFromDashboard: false),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: primarycolor,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Image.asset(
            MENU_ICON,
            width: 30,
            color: WHITE_COLOR.withOpacity(.9),
          ),
        ),
        title: Text(
          changePassword,
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
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: Get.height * 0.02, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inputLabel(labelText: 'Old Password'),
                    const SizedBox(height: 5),
                    customtextFromField(obsecureText: _obsecureText1, hintText: 'e.g. abc@123#', onTap: _toggle1),
                    const SizedBox(height: 20),
                    inputLabel(labelText: 'New Password'),
                    const SizedBox(height: 5),
                    customtextFromField(obsecureText: _obsecureText2, hintText: 'e.g. 123@abCd', onTap: _toggle2),
                    const SizedBox(height: 20),
                    inputLabel(labelText: 'Confirm Password'),
                    const SizedBox(height: 5),
                    customtextFromField(obsecureText: _obsecureText3, hintText: 'e.g. 123@abCd', onTap: _toggle3),
                    const Expanded(child: SizedBox()),
                    resetPasswordButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget resetPasswordButton() {
    return ElevatedButton(
      onPressed: () {},
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
        'Reset Password',
        style: textStyle1.copyWith(color: WHITE_COLOR, fontSize: 16),
      ),
    );
  }

  Widget customtextFromField({bool? obsecureText, String? hintText, Function? onTap}) {
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
        obscureText: obsecureText!,
        decoration: InputDecoration(
          fillColor: WHITE_COLOR,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          hintText: hintText,
          hintStyle: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_HINT_TEXT_COLOR),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: onTap as void Function(),
            child: Icon(
              obsecureText ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
        cursorColor: textcolor,
        style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
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
