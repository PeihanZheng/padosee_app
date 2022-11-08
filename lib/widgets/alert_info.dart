import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';

import '../pages/camera_module/pages/assign_camera.dart';

class AlertInfo extends StatelessWidget {
  const AlertInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      // height: Get.height - 65,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ALERT_INFO_ICON,
                width: 85,
                color: primarycolor,
              ),
              const SizedBox(height: 15),
              Text(
                "Please Assign at least One Camera to Use this feature",
                textAlign: TextAlign.center,
                style: textStyle1.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Get.off(AssignCameraPage());
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(primarycolor),
                    fixedSize: MaterialStateProperty.all(const Size.fromHeight(46))),
                child: Text(
                  "+ Add Camera",
                  style: textStyle1.copyWith(color: WHITE_COLOR),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
