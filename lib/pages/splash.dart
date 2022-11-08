import 'dart:async';
import 'package:flutter/material.dart';
import 'package:padosee/constants/theme/colors.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      routeHandler();
    });
    super.initState();
  }

  void routeHandler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userdata')) {
      Get.offNamed("/dashboard");
    } else {
      Get.offNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                APP_LOGO,
                width: Get.width / 2,
                color: WHITE_COLOR.withOpacity(.9),
              ),
              Text(
                padoSee,
                style: textStyle1.copyWith(fontSize: 32, fontWeight: FontWeight.bold, color: WHITE_COLOR.withOpacity(.9)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
