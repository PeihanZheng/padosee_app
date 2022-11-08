import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';

class AnalyticsCard extends StatelessWidget {
  final String name;
  const AnalyticsCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: ThemeManager.CARD_COLOR,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: ThemeManager.BOX_SHADOW_COLOR,
            offset: const Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            textAlign: TextAlign.end,
            style: textStyle1.copyWith(color: ThemeManager.APP_TEXT_COLOR),
          ),
          CupertinoSwitch(
            onChanged: (val) {},
            value: false,
          ),
        ],
      ),
    );
  }
}
