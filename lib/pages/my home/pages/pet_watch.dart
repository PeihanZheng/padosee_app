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

class PetWatch extends StatefulWidget {
  const PetWatch({Key? key}) : super(key: key);

  @override
  State<PetWatch> createState() => _PetWatchState();
}

class _PetWatchState extends State<PetWatch> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(isFromDashboard: false),
      backgroundColor: ThemeManager.BACKGROUND_COLOR,
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
              PET_WATCH_ICON,
              width: 30,
            ),
            const SizedBox(width: 10),
            Text(
              petWatch,
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
                  AnalyticsCard(name: movementDetection),
                  SizedBox(height: 10),
                  AnalyticsCard(name: litterWatch),
                  SizedBox(height: 10),
                  AnalyticsCard(name: foodTrayCheck),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
