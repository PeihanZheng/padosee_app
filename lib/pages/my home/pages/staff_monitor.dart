import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/bottomBar.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';

import 'package:padosee/widgets/analytics_card.dart';
import 'package:padosee/widgets/drawer.dart';

class StaffMonitor extends StatefulWidget {
  const StaffMonitor({Key? key}) : super(key: key);

  @override
  State<StaffMonitor> createState() => _StaffMonitorState();
}

class _StaffMonitorState extends State<StaffMonitor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ThemeManager.BACKGROUND_COLOR,
      drawer: const MyDrawer(isFromDashboard: false),
      bottomNavigationBar: BottomBar(
        currentIndex: 0,
        onTapFunc: (val) {
          changeNav(context, val);
        },
      ),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: ThemeManager.BACKGROUND_COLOR,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 35,
            color: ThemeManager.MENU_COLOR,
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              STAFF_MONITOR_ICON,
              width: 30,
            ),
            const SizedBox(width: 10),
            Text(
              staffMonitor,
              style: textStyle1.copyWith(fontSize: 16, color: ThemeManager.TITLE_COLOR),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                children: const [
                  AnalyticsCard(name: violenceDetection),
                  SizedBox(height: 10),
                  AnalyticsCard(name: nannysActivityWatch),
                  SizedBox(height: 10),
                  AnalyticsCard(name: attendenceWatch),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
