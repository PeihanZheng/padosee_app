import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/theme/theme_manager.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black45,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: ThemeManager.CARD_COLOR2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(ThemeManager.MENU_COLOR),
          ),
        ),
      ),
    );
  }
}
