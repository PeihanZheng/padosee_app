// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/controller/dashboard_controller.dart';

import 'package:padosee/widgets/alert_info.dart';

class HomeSecondary extends StatefulWidget {
  final DashboardController con;
  const HomeSecondary({Key? key, required this.con}) : super(key: key);

  @override
  State<HomeSecondary> createState() => _HomeSecondaryState();
}

class _HomeSecondaryState extends State<HomeSecondary> {
  final con = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: con.primaryUserName.value != null
            ? MainAxisAlignment.start
            : con.primaryUserName.value == null && userRole.value == "primary"
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
        children: [
          con.primaryUserName.value != null
              ? Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Connected with ${con.primaryUserName.value}",
                          style: textStyle1.copyWith(
                            fontSize: 16,
                            color: ThemeManager.APP_TEXT_COLOR,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Image.asset(
                          con.isConnected.value ? 'assets/icons/enable.png' : 'assets/icons/disable.png',
                          width: 25,
                        ),
                      ],
                    ),
                  ),
                )
              : con.primaryUserName.value == null && userRole.value == "primary"
                  ? Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Not Connected with any user",
                              style: textStyle1.copyWith(
                                fontSize: 16,
                                color: ThemeManager.APP_TEXT_COLOR,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Image.asset(
                              'assets/icons/disable.png',
                              width: 25,
                            ),
                          ],
                        ),
                      ),
                    )
                  : const AlertInfo(),
        ],
      ),
    );
  }
}
