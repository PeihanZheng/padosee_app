import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';

import 'package:padosee/models/data_models/user_model.dart';

import 'package:padosee/pages/authentication/controller/authController.dart';

import 'package:padosee/services/authentication_service.dart';

import 'package:padosee/widgets/email_checker.dart';
import 'package:padosee/widgets/loader.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final con = Get.put(AuthController());

  @override
  void dispose() {
    con.firstnameController.dispose();
    con.lastnameController.dispose();
    con.emailController.dispose();
    con.password1Controller.dispose();
    con.confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height * 0.05),
                      Text(
                        signUp,
                        style: textStyle1.copyWith(fontSize: 35, color: WHITE_COLOR.withOpacity(.9)),
                      ),
                      ValueListenableBuilder(
                        valueListenable: errorText,
                        builder: (context, value, _) {
                          if (value != "") {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    value.toString(),
                                    textAlign: TextAlign.center,
                                    style: textStyle1.copyWith(fontSize: 14, color: Colors.red, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            );
                          }
                          return SizedBox(height: Get.height * .03);
                        },
                      ),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.only(left: 23, right: 23, bottom: 15, top: 30),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: ThemeManager.BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            inputLabel(labelText: 'First Name'),
                            const SizedBox(height: 5),
                            customTextfield(
                              hinttext: 'Enter your first name',
                              controller: con.firstnameController,
                              icon: Icons.person_rounded,
                              action: TextInputAction.next,
                            ),
                            const SizedBox(height: 15),
                            inputLabel(labelText: 'Last Name'),
                            const SizedBox(height: 5),
                            customTextfield(
                              hinttext: 'Enter your last name',
                              controller: con.lastnameController,
                              icon: Icons.person_rounded,
                              action: TextInputAction.next,
                            ),
                            const SizedBox(height: 15),
                            inputLabel(labelText: emailAddress),
                            const SizedBox(height: 5),
                            customTextfield(
                              hinttext: "Enter your email address",
                              controller: con.emailController,
                              icon: Icons.mail,
                              action: TextInputAction.next,
                            ),
                            const SizedBox(height: 15),
                            inputLabel(labelText: password),
                            const SizedBox(height: 5),
                            passwordTextfield(
                              obsecuretext: con.obsecureText1.value,
                              controller: con.password1Controller,
                              hinttext: 'Enter your password',
                              ontap: con.toggle1,
                              action: TextInputAction.next,
                            ),
                            const SizedBox(height: 15),
                            inputLabel(labelText: confirmPassword),
                            const SizedBox(height: 5),
                            passwordTextfield(
                              obsecuretext: con.obsecureText2.value,
                              controller: con.confirmPassController,
                              hinttext: 'Enter your confirm password',
                              ontap: con.toggle2,
                              action: TextInputAction.done,
                            ),
                            const SizedBox(height: 25),
                            submitButton(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      alreadyAccountButton(),
                    ],
                  ),
                ),
              ),
              if (con.isLoading.value) const CommonLoader(),
            ],
          ),
        ),
      ),
    );
  }

  Widget alreadyAccountButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Already have an account?',
          style: textStyle1.copyWith(fontSize: 12, color: WHITE_COLOR.withOpacity(.8)),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            Get.offNamed("/login");
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(WHITE_COLOR),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25, vertical: 10)),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
            ),
          ),
          child: Text(
            login,
            style: textStyle1.copyWith(fontSize: 14, color: ThemeManager.MENU_COLOR),
          ),
        ),
      ],
    );
  }

  Widget submitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          String username = "${con.firstnameController.text.trim()} ${con.lastnameController.text.trim()}";
          String emailAd = con.emailController.text.trim();
          String passwordD = con.password1Controller.text.trim();
          String confirmPass = con.confirmPassController.text.trim();

          if (con.firstnameController.text.isEmpty) {
            errorText.value = "Please Enter Your First Name";
          } else if (con.lastnameController.text.isEmpty) {
            errorText.value = "Please Enter Your Last Name";
          } else if (emailAd.isEmpty) {
            errorText.value = "Please Enter Your Email Address";
          } else if (EmailChecker.isNotValid(emailAd)) {
            errorText.value = "Please Enter Valid Email Address";
          } else if (passwordD.isEmpty) {
            errorText.value = "Please Enter Your Password";
          } else if (passwordD.length < 8) {
            errorText.value = "Password should be 8 characters long";
          } else if (confirmPass.isEmpty) {
            errorText.value = "Please Enter Your Confirm Password";
          } else if (passwordD != confirmPass) {
            errorText.value = "Password Does Not Match";
          } else {
            con.isLoading.value = true;

            UserModel userModel = UserModel(
              username: username,
              emailAddress: emailAd,
              role: "secondary",
            );
            Future.delayed(const Duration(seconds: 2), () {
              AuthenticationService().signUp(context, userModel, passwordD).then((value) {
                con.isLoading.value = false;
              });
            });
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primarycolor),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30, vertical: 8)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
        ),
        child: Text(
          'Submit',
          style: textStyle1.copyWith(color: WHITE_COLOR, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget passwordTextfield({bool? obsecuretext, TextEditingController? controller, String? hinttext, Function? ontap, TextInputAction? action}) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeManager.INPUT_FILLED_COLOR,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        obscureText: obsecuretext!,
        controller: controller,
        textInputAction: action,
        keyboardType: TextInputType.name,
        style: textStyle1.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: ThemeManager.MENU_COLOR),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          hintText: hinttext,
          hintStyle: textStyle1.copyWith(fontSize: 14, color: ThemeManager.APP_HINT_TEXT_COLOR, fontWeight: FontWeight.w400),
          prefixIcon: Icon(
            Icons.lock,
            size: 25,
            color: ThemeManager.MENU_COLOR,
          ),
          suffixIcon: GestureDetector(
            onTap: ontap as void Function(),
            child: Icon(
              obsecuretext ? Icons.visibility_off : Icons.visibility,
              color: ThemeManager.MENU_COLOR,
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextfield({String? hinttext, TextEditingController? controller, IconData? icon, TextInputAction? action}) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeManager.INPUT_FILLED_COLOR,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        textInputAction: action,
        keyboardType: TextInputType.name,
        style: textStyle1.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: ThemeManager.MENU_COLOR),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          hintText: hinttext,
          hintStyle: textStyle1.copyWith(fontSize: 14, color: ThemeManager.APP_HINT_TEXT_COLOR, fontWeight: FontWeight.w400),
          prefixIcon: Icon(
            icon,
            size: 25,
            color: ThemeManager.MENU_COLOR,
          ),
        ),
      ),
    );
  }

  Widget inputLabel({String? labelText}) {
    return Text(
      labelText!,
      style: textStyle1.copyWith(
        fontSize: 15,
        color: ThemeManager.APP_TEXT_COLOR,
        fontWeight: FontWeight.w600,
        letterSpacing: .5,
      ),
    );
  }
}
