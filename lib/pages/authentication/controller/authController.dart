import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

import 'package:padosee/models/data_models/user_model.dart';

import 'package:padosee/pages/authentication/signup.dart';
import 'package:padosee/pages/dashboard.dart';

import 'package:padosee/services/authentication_service.dart';

enum SupportState {
  unknown,
  supported,
  unsupported,
}

class AuthController extends GetxController {
  var isLoading = false.obs;

  var obsecureText = true.obs;
  var obsecureText1 = true.obs;
  var obsecureText2 = true.obs;

  var isFirstTime = true.obs;

  var genderGroup = 'Male'.obs;

  final auth = LocalAuthentication();

  var supportState = SupportState.unknown.obs;
  bool? canCheckBiometrics;
  List<BiometricType>? availableBiometrics;
  String authorized = 'Not Authorized';

  var isAuthenticating = false.obs;

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final password1Controller = TextEditingController();
  final confirmPassController = TextEditingController();

  final nameController = TextEditingController();
  final password2Controller = TextEditingController();

  UserModel userData = UserModel();

  @override
  void onInit() {
    checkIfFirst();
    isDeviceSupported();
    checkBiometrics();
    getAvailableBiometrics();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  toggle() {
    obsecureText.value = !obsecureText.value;
  }

  toggle1() {
    obsecureText1.value = !obsecureText1.value;
  }

  toggle2() {
    obsecureText2.value = !obsecureText2.value;
  }

  void checkIfFirst() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isFirst')) {
      isFirstTime.value = false;
    } else {
      isFirstTime.value = true;
    }
    update();
  }

  isDeviceSupported() {
    auth.isDeviceSupported().then((bool isSupported) {
      supportState.value = isSupported ? SupportState.supported : SupportState.unsupported;
    });
  }

  Future<void> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    // if (!mounted) {
    //   return;
    // }

    canCheckBiometrics = canCheckBiometrics;
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      print(availableBiometrics);
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    // if (!mounted) {
    //   return;
    // }

    availableBiometrics = availableBiometrics;
  }

  Future<bool> authenticationWithBiometrics() async {
    bool isAuthenticated = false;
    if (supportState.value == SupportState.supported && canCheckBiometrics!) {
      try {
        isLoading.value = true;
        var userUid = getUserId();
        if (userUid != null) {
          isAuthenticated = await auth.authenticate(
            localizedReason: 'Scan your fingerprint to authenticate',
            options: const AuthenticationOptions(
              biometricOnly: true,
            ),
          );
          if (isAuthenticated) {
            Get.off(const Dashboard());
          }

          isLoading.value = false;
        } else {
          Get.off(const SignupScreen());

          isLoading.value = false;
        }
      } on PlatformException catch (e) {
        print(e);
      }
    }
    return isAuthenticated;
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    isAuthenticating.value = false;
  }
}
