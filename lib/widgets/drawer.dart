import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';

import 'package:padosee/pages/sidebar%20pages/profile_page.dart';

import 'package:padosee/services/authentication_service.dart';

import 'package:padosee/pages/sidebar%20pages/change_password.dart';
import 'package:padosee/pages/sidebar%20pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  final bool isFromDashboard;
  const MyDrawer({Key? key, required this.isFromDashboard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * .8,
      backgroundColor: ThemeManager.BACKGROUND_COLOR,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          sidebarHeaderPart(),
          const SizedBox(height: 20),
          ListTile(
            leading: Image.asset(
              MY_PROFILE_ICON,
              width: 33,
            ),
            title: Text(
              myprofile,
              style: textStyle1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ThemeManager.APP_TEXT_COLOR,
              ),
            ),
            horizontalTitleGap: 5,
            onTap: isFromDashboard
                ? () {
                    Get.back();
                    Get.to(ProfilePage());
                  }
                : () {
                    Get.off(ProfilePage());
                  },
          ),
          ListTile(
            horizontalTitleGap: 5,
            leading: Image.asset(
              CHANGE_PASSWORD,
              width: 33,
            ),
            title: Text(
              changePassword,
              style: textStyle1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ThemeManager.APP_TEXT_COLOR,
              ),
            ),
            onTap: isFromDashboard
                ? () {
                    Get.back();
                    Get.to(const ChangePasswordPage());
                  }
                : () {
                    Get.off(const ChangePasswordPage());
                  },
          ),
          ListTile(
            horizontalTitleGap: 5,
            leading: Image.asset(
              SETTINGS_ICON,
              width: 33,
            ),
            title: Text(
              settings,
              style: textStyle1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ThemeManager.APP_TEXT_COLOR,
              ),
            ),
            onTap: isFromDashboard
                ? () {
                    Get.back();
                    Get.to(const SettingsPage());
                  }
                : () {
                    Get.off(const SettingsPage());
                  },
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5),
            child: Text(
              'Communicate',
              style: textStyle1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ThemeManager.DRAWER_GREY_COLOR,
              ),
            ),
          ),
          const SizedBox(height: 5),
          ListTile(
            horizontalTitleGap: 5,
            leading: Image.asset(
              REFER_ICON,
              width: 33,
            ),
            title: Text(
              referAFriend,
              style: textStyle1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ThemeManager.APP_TEXT_COLOR,
              ),
            ),
            onTap: isFromDashboard
                ? () {
                    Get.back();
                    // Get.to(const SettingsPage());
                  }
                : () {
                    // Get.off(const SettingsPage());
                  },
          ),
          ListTile(
            horizontalTitleGap: 5,
            leading: Image.asset(
              LOGOUT,
              width: 33,
            ),
            title: Text(
              logout,
              style: textStyle1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ThemeManager.APP_TEXT_COLOR,
              ),
            ),
            onTap: () {
              AuthenticationService().signOut(context);
            },
          ),
        ],
      ),
    );
  }

  Widget sidebarHeaderPart() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Color(0xff003459),
      ),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 3,
                    color: Colors.blue.shade800.withOpacity(.25),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    userData.value.imageUrl ?? DUMMY_IMG,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userData.value.username ?? "",
              style: textStyle1.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
