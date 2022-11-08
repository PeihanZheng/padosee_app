import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';

class PrimaryAlerts extends StatefulWidget {
  const PrimaryAlerts({Key? key}) : super(key: key);

  @override
  State<PrimaryAlerts> createState() => _PrimaryAlertsState();
}

class _PrimaryAlertsState extends State<PrimaryAlerts> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: alerts.length,
                    itemBuilder: (context, index) {
                      // final data = widget.loitering?.raw?.last;
                      return alertNotificationWidget(message: alerts[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<String> alerts = [
    'Loitering detected by Camera_1 at 10:45 pm',
    'Abandond Object detected by Camera_3 at 9:00 am',
    'Movement detected by Camera_2 at 7:30 pm',
  ];

  Widget alertNotificationWidget({String? message}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: Get.width,
      decoration: BoxDecoration(
        color: GREY_COLOR.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      child: Text(
        message ?? "",
        style: textStyle1.copyWith(
          color: ThemeManager.APP_TEXT_COLOR,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
