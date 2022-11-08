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

class DoorSurvelliance extends StatefulWidget {
  const DoorSurvelliance({Key? key}) : super(key: key);

  @override
  State<DoorSurvelliance> createState() => _DoorSurvellianceState();
}

class _DoorSurvellianceState extends State<DoorSurvelliance> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loitringAndIntrusion = false;
  bool fRAnalysis = false;

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
              DOOR_SURVELLIANCE_ICON,
              width: 30,
            ),
            const SizedBox(width: 10),
            Text(
              doorSurvelliance,
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
                  AnalyticsCard(name: visitorAndDeliveryView),
                  SizedBox(height: 10),
                  AnalyticsCard(name: loiteringAndIntrusion),
                  SizedBox(height: 10),
                  AnalyticsCard(name: doorLockCheck),
                  SizedBox(height: 10),
                  AnalyticsCard(name: facialRecognition),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
