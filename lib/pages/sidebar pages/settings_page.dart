import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';

import 'package:padosee/main.dart';

import 'package:padosee/widgets/drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
        backgroundColor: primarycolor,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Image.asset(
            MENU_ICON,
            width: 30,
            color: WHITE_COLOR.withOpacity(.9),
          ),
        ),
        title: Text(
          settings,
          style: textStyle1.copyWith(
            color: WHITE_COLOR.withOpacity(.9),
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                size: 33,
                color: WHITE_COLOR.withOpacity(.9),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      visualDensity: VisualDensity.standard,
                      leading: Image.asset(
                        DARK_MODE,
                        width: 40,
                      ),
                      title: Text(
                        'Dark Mode',
                        style: textStyle1.copyWith(color: ThemeManager.APP_TEXT_COLOR, fontSize: 16),
                      ),
                      trailing: CupertinoSwitch(
                        value: themeManager.themeMode == ThemeMode.dark,
                        onChanged: (value) {
                          setState(() {
                            themeManager.toggleTheme(value);
                          });
                        },
                      ),
                    ),
                    Divider(
                      thickness: .8,
                      color: ThemeManager.DIVIDER_COLOR,
                    ),
                    ListTile(
                      visualDensity: VisualDensity.standard,
                      leading: Image.asset(
                        NOTIFICATIONS,
                        width: 40,
                      ),
                      title: Text(
                        'Notifications',
                        style: textStyle1.copyWith(color: ThemeManager.APP_TEXT_COLOR, fontSize: 16),
                      ),
                      trailing: CupertinoSwitch(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                    Divider(
                      thickness: .8,
                      color: ThemeManager.DIVIDER_COLOR,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
