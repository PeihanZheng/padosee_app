import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/bottomBar.dart';
import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/widgets/drawer.dart';

import 'primary_alerts.dart';
import 'secondary_alerts.dart';

class AlertBoard extends StatefulWidget {
  const AlertBoard({Key? key}) : super(key: key);

  @override
  State<AlertBoard> createState() => _AlertBoardState();
}

class _AlertBoardState extends State<AlertBoard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: userRole.value == "secondary" ? 1 : 0,
      length: 2,
      child: Scaffold(
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
          centerTitle: true,
          toolbarHeight: 70,
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
          title: Text(
            alertBoardTitle,
            style: textStyle1.copyWith(fontSize: 18, color: ThemeManager.TITLE_COLOR),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Primary",
                  style: textStyle1.copyWith(fontSize: 16, color: ThemeManager.MENU_COLOR),
                ),
              ),
              Tab(
                child: Text(
                  "Secondary",
                  style: textStyle1.copyWith(fontSize: 16, color: ThemeManager.MENU_COLOR),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            userRole.value == "primary"
                ? const PrimaryAlerts()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        "You Can't access Primary Notification. Switch to Secondary Tab",
                        textAlign: TextAlign.center,
                        style: textStyle1.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
                      ),
                    ),
                  ),
            const SecondaryAlerts()
          ],
        ),
      ),
    );
  }
}
