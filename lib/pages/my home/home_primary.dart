// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/controller/dashboard_controller.dart';

class HomePrimary extends StatefulWidget {
  final DashboardController con;
  const HomePrimary({Key? key, required this.con}) : super(key: key);

  @override
  State<HomePrimary> createState() => _HomePrimaryState();
}

class _HomePrimaryState extends State<HomePrimary> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              "Main Categories",
              style: textStyle1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xff00171F),
              ),
            ),
            const SizedBox(height: 10),
            categoriesFirstRow(),
            const SizedBox(height: 15),
            categoriesSecondRow(),
            const SizedBox(height: 25),
            Text(
              "Other Features",
              style: textStyle1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xff00171F),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: analyticsCard(
                      image: ELDERS_ICON,
                      title: 'Elderly Care',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: analyticsCard(
                      image: HAZARDS_ICON,
                      title: 'Hazard Detection',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: analyticsCard(
                      image: TEMPERING_ICON,
                      title: 'Tempering Alert',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: analyticsCard(
                      image: MEMORY_ICON,
                      title: 'Memory Capture',
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 10),
            // bottomRowSecond(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget analyticsCard({String? image, String? title}) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      decoration: BoxDecoration(
        color: primarycolor.withOpacity(.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 55,
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: WHITE_COLOR,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              image!,
              width: 27,
              height: 27,
              color: primarycolor,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title!,
              style: textStyle1.copyWith(
                color: primarycolor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: .5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: .5,
            color: primarycolor.withOpacity(.3),
            height: 0,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Off',
                  style: textStyle1.copyWith(
                    color: textcolor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Transform.scale(
                  scale: 0.75,
                  child: CupertinoSwitch(
                    onChanged: (val) {},
                    value: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriesSecondRow() {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: categoryWidget(
              image: STAFF_MONITOR_IMG,
              title: staffMonitorTitle,
              backColor: const Color(0xff4E3966),
              ontap: () {
                Get.toNamed('/staff-monitor');
              },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: categoryWidget(
              image: DOOR_SURVELLIANCE_IMG,
              title: doorSurvellianceTitle,
              backColor: const Color(0xffFFBD7B),
              ontap: () {
                Get.toNamed('/door-survi');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriesFirstRow() {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: categoryWidget(
              image: BABY_MONITOR_IMG,
              title: babyMonitorTitle,
              backColor: const Color(0xff38648c),
              ontap: () {
                Get.toNamed('/baby-monitor');
              },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: categoryWidget(
              image: PET_WATCH_IMG,
              title: petWatchTitle,
              backColor: const Color(0xffDDAF89),
              ontap: () {
                Get.toNamed('/pet-watch');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryWidget({String? image, String? title, Color? backColor, Function? ontap}) {
    return InkWell(
      onTap: ontap as void Function(),
      borderRadius: BorderRadius.circular(15),
      highlightColor: Colors.transparent,
      splashColor: primarycolor.withOpacity(.3),
      child: Stack(
        children: [
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
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
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primarycolor.withOpacity(.6),
                    primarycolor.withOpacity(.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: textStyle1.copyWith(
                  color: WHITE_COLOR,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget categoryWidget({String? image, String? title, Color? backColor, Function? ontap}) {
  //   return InkWell(
  //     onTap: ontap as void Function(),
  //     borderRadius: BorderRadius.circular(15),
  //     highlightColor: Colors.transparent,
  //     splashColor: primarycolor.withOpacity(.3),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
  //       decoration: BoxDecoration(
  //         color: backColor!.withOpacity(.2),
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Image.asset(
  //             image!,
  //             width: 35,
  //             height: 35,
  //           ),
  //           const SizedBox(height: 10),
  //           Text(
  //             title!,
  //             style: textStyle1.copyWith(
  //               color: textcolor,
  //               fontSize: 14,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
