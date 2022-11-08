import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/controller/dashboard_controller.dart';

import 'package:padosee/pages/my%20home/home_primary.dart';
import 'package:padosee/pages/my%20home/home_secondary.dart';
import 'package:padosee/widgets/drawer.dart';

import '../../bottomBar.dart';
import '../../constants/theme/themes.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final con = Get.put(DashboardController());

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    print(con.firstName.value);
    setState(() {});
  }

  var tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: userRole.value == "secondary" ? 1 : 0,
      length: 2,
      child: Obx(
        () => Scaffold(
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
            toolbarHeight: 60,
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
              '${con.firstName.value}\'s Home',
              style: textStyle1.copyWith(fontSize: 18, color: ThemeManager.TITLE_COLOR),
            ),
            bottom: TabBar(
              indicatorWeight: 3,
              indicatorColor: primarycolor,
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
                  ? HomePrimary(con: con)
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
              HomeSecondary(con: con),
            ],
          ),
        ),
      ),
    );
  }
}
