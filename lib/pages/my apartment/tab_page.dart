import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/pages/my%20apartment/my_apartment_secondary.dart';
import 'package:padosee/pages/my%20apartment/my_aprtment_primary.dart';

import 'package:padosee/widgets/drawer.dart';

import '../../bottomBar.dart';

class MainApartmentPage extends StatelessWidget {
  MainApartmentPage({Key? key}) : super(key: key);

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
          title: Text(
            apartmentTitle,
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
                ? const ApartmentPrimary()
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
            const ApartmentSecondary(),
          ],
        ),
      ),
    );
  }
}
