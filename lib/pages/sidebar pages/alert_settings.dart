import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/widgets/analytics_card.dart';
import 'package:padosee/widgets/drawer.dart';

class AlertSettings extends StatefulWidget {
  const AlertSettings({Key? key}) : super(key: key);

  @override
  State<AlertSettings> createState() => _AlertSettingsState();
}

class _AlertSettingsState extends State<AlertSettings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ThemeManager.BACKGROUND_COLOR,
      drawer: const MyDrawer(isFromDashboard: false),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: ThemeManager.BACKGROUND_COLOR,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            size: 35,
            color: ThemeManager.MENU_COLOR,
          ),
        ),
        title: Text(
          alertSettings,
          style: textStyle1.copyWith(color: ThemeManager.TITLE_COLOR),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    size: 33,
                    color: Colors.blue,
                  ),
                  Text(
                    back,
                    style: textStyle1.copyWith(fontSize: 10, color: ThemeManager.APP_TEXT_COLOR),
                  ),
                ],
              ),
            ),
          ),
        ],
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
