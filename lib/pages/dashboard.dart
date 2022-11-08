import 'dart:async';

import 'package:flutter/material.dart';
import 'package:padosee/bottomBar.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/controller/dashboard_controller.dart';
import 'package:padosee/main.dart';
import 'package:padosee/widgets/loader.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';

import 'package:padosee/widgets/drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final con = Get.put(DashboardController());

  @override
  void initState() {
    themeManager.addListener(themeListner);
    con.onInit();
    // Timer.periodic(const Duration(seconds: 8), (timer) {
    //   con.onInit();
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListner);
    super.dispose();
  }

  themeListner() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      backgroundColor: ThemeManager.BACKGROUND_COLOR,
      drawer: const MyDrawer(isFromDashboard: true),
      bottomNavigationBar: BottomBar(
        currentIndex: 0,
        onTapFunc: (val) {
          changeNav(context, val);
        },
      ),
      body: Obx(
        () => Stack(
          children: [
            mainWidget(context),
            if (con.isLoading.value) const CommonLoader(),
          ],
        ),
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    var usableHeight = Get.height - MediaQuery.of(context).padding.top - (Get.height * .08);
    return SafeArea(
      child: SizedBox(
        width: Get.width,
        height: usableHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // appbar widget
            SizedBox(
              width: Get.width,
              height: usableHeight * .1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        con.scaffoldKey.currentState?.openDrawer();
                      },
                      icon: Image.asset(
                        MENU_ICON,
                        width: 30,
                        color: primarycolor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/alerts-page');
                      },
                      icon: Image.asset(
                        BELL_ICON,
                        width: 25,
                        color: primarycolor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // welcome text widget
            SizedBox(
              height: usableHeight * .12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Ashish!",
                      style: textStyle1.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: primarycolor,
                      ),
                    ),
                    Text(
                      "Welcome Back",
                      style: textStyle1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: primarycolor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // my cameras widget
            myCameraWidget(usableHeight),
            // available cameras widget
            availableLocationsWidget(usableHeight),
          ],
        ),
      ),
    );
  }

  Widget myCameraWidget(double usableHeight) {
    return SizedBox(
      height: usableHeight * .28,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "My Cameras",
              style: textStyle1.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xff00171F),
              ),
            ),
            const SizedBox(height: 5),
            viewCameraCard(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget viewCameraCard() {
    return Expanded(
      child: Container(
        width: Get.width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              blurRadius: 8,
              spreadRadius: 1,
              color: primarycolor.withOpacity(.4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Image.asset(
              CCTV_IMG,
              width: Get.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 10,
              left: 15,
              child: Text(
                "You have ${camerasCount.value} camera assigned.",
                style: textStyle1.copyWith(
                  color: WHITE_COLOR,
                  fontSize: 15,
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  Get.offNamed('/view-camera');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(WHITE_COLOR),
                  elevation: MaterialStateProperty.all(3),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                ),
                child: Text(
                  "View Cameras",
                  style: textStyle1.copyWith(
                    fontSize: 12,
                    color: const Color(0xff00171F),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget availableLocationsWidget(double usableHeight) {
    return SizedBox(
      width: Get.width,
      height: usableHeight * .5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Available Locations",
              style: textStyle1.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xff00171F),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    locationCard(
                        image: HOME_IMG,
                        title: home,
                        ontap: () {
                          Get.toNamed('/home');
                        }),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          locationCard(
                              image: APARTMENT_IMG,
                              title: apartment,
                              ontap: () {
                                Get.toNamed('/apartment');
                              }),
                          const SizedBox(height: 16),
                          locationCard(
                              image: NEIGHBORHOOD_IMG,
                              title: neighborhood,
                              ontap: () {
                                Get.toNamed('/neighbourhood');
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: usableHeight * 0.05),
          ],
        ),
      ),
    );
  }

  Widget locationCard({String? image, String? title, VoidCallback? ontap}) {
    return Expanded(
      child: InkWell(
        onTap: ontap,
        borderRadius: BorderRadius.circular(15),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: Get.width - 8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    image!,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 8,
                    spreadRadius: 1,
                    color: primarycolor.withOpacity(.4),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Container(
                width: Get.width - 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primarycolor.withOpacity(.9),
                      primarycolor.withOpacity(.01),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  title!,
                  style: textStyle1.copyWith(
                    color: WHITE_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
