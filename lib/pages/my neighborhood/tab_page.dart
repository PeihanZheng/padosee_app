import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';

import 'package:padosee/pages/my%20neighborhood/my_neighborhood_primary.dart';
import 'package:padosee/pages/my%20neighborhood/my_neighborhood_secondary.dart';

import 'package:padosee/widgets/drawer.dart';

import '../../bottomBar.dart';

class MainNeighborhoodPage extends StatelessWidget {
  MainNeighborhoodPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: userRole.value == "secondary" ? 1 : 0,
      length: 2,
      child: Scaffold(
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
          centerTitle: true,
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
            neighbourTitle,
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
          children: [
            userRole.value == "primary"
                ? const NeighborhoodPrimary()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        "You Can't access this section.",
                        textAlign: TextAlign.center,
                        style: textStyle1.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
                      ),
                    ),
                  ),
            const NeighborhoodSecondary(),
          ],
        ),
      ),
    );
  }
}
