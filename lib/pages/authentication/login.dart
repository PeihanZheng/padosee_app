import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';

import 'package:padosee/pages/authentication/controller/authController.dart';

import 'package:padosee/services/authentication_service.dart';

import 'package:padosee/widgets/loader.dart';

import '../../common/methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final con = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    con.nameController.dispose();
    con.password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height * 0.075),
                    Text(
                      login,
                      style: textStyle1.copyWith(fontSize: 35, color: WHITE_COLOR.withOpacity(.9)),
                    ),
                    SizedBox(height: Get.height * .05),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(left: 23, right: 23, bottom: 10, top: 30),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: ThemeManager.BACKGROUND_COLOR,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          inputLabel(labelText: username),
                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: ThemeManager.INPUT_FILLED_COLOR,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              controller: con.nameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              style: textStyle1.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: ThemeManager.MENU_COLOR),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintText: 'Enter your Username',
                                hintStyle: textStyle1.copyWith(fontSize: 14, color: ThemeManager.APP_HINT_TEXT_COLOR, fontWeight: FontWeight.w400),
                                prefixIcon: Icon(
                                  Icons.person_rounded,
                                  size: 25,
                                  color: ThemeManager.MENU_COLOR,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          inputLabel(labelText: password),
                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: ThemeManager.INPUT_FILLED_COLOR,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              obscureText: con.obsecureText.value,
                              controller: con.password2Controller,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.name,
                              style: textStyle1.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: ThemeManager.MENU_COLOR),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintText: 'Enter your Password',
                                hintStyle: textStyle1.copyWith(fontSize: 14, color: ThemeManager.APP_HINT_TEXT_COLOR, fontWeight: FontWeight.w400),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: 25,
                                  color: ThemeManager.MENU_COLOR,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: con.toggle,
                                  child: Icon(
                                    con.obsecureText.value ? Icons.visibility_off : Icons.visibility,
                                    color: ThemeManager.MENU_COLOR,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          loginButton(context),
                          const SizedBox(height: 10),
                          // Or text and biometric login inside widget
                          if (con.supportState.value == SupportState.supported) biometricLoginButton(),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    dontHaveAccount(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              if (con.isLoading.value) const CommonLoader(),
            ],
          ),
        ),
      ),
    );
  }

  Column biometricLoginButton() {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: Get.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: Divider(thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Or',
                  style: textStyle1.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: ThemeManager.APP_TEXT_COLOR),
                ),
              ),
              const Expanded(child: Divider(thickness: 1)),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Center(
          child: TextButton(
            onPressed: () {
              // authenticationWithBiometrics();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primarycolor.withOpacity(0.1)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(51))),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
            ),
            child: Text(
              'Biometric Login',
              style: textStyle1.copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: ThemeManager.MENU_COLOR),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget loginButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          Future.delayed(const Duration(seconds: 2), () {});
          if (con.nameController.text.isEmpty ||
              con.password2Controller.text.isEmpty ||
              con.password2Controller.text.isEmpty && con.nameController.text.isEmpty) {
            customSnackbar(message: 'Please fill all details', isSuccess: false);
          } else if (con.password2Controller.text.length < 6) {
            customSnackbar(message: 'Enter a password with length at least 6', isSuccess: false);
          } else {
            con.isLoading.value = true;
            AuthenticationService()
                .signIn(
              context,
              con.nameController.text.trim(),
              con.password2Controller.text.trim(),
            )
                .then((value) {
              con.isLoading.value = false;
            });

            // AuthenticationService()
            //     .signInMethod(
            //   username: nameController.text.trim(),
            //   password: passwordController.text.trim(),
            // )
            //     .then((value) async {
            //   SharedPreferences prefs = await SharedPreferences.getInstance();
            //   if (prefs.containsKey('isFirst')) {
            //     print('user logged in');
            //   } else {
            //     prefs.setBool('isFirst', false);
            //   }
            //   setState(() {
            //     isLoading = false;
            //   });
            // });
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

  Widget dontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Don\'t have an account yet?',
          style: textStyle1.copyWith(fontSize: 14, color: WHITE_COLOR.withOpacity(.8)),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            Get.offNamed("/signup");
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
            signUp,
            style: textStyle1.copyWith(fontSize: 14, color: ThemeManager.MENU_COLOR),
          ),
        ),
      ],
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
