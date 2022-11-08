import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/bottomBar.dart';

import 'package:padosee/constants/strings.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';

import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/models/data_models/camera_model.dart';

import 'package:padosee/widgets/alert_info.dart';
import 'package:padosee/widgets/drawer.dart';
import 'package:padosee/widgets/loader.dart';

import '../controller/camera_controller.dart';
import '../widgets/vlc_stream_card.dart';

class ViewCameras extends StatelessWidget {
  ViewCameras({Key? key}) : super(key: key);

  final con = Get.put(CameraController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      drawer: const MyDrawer(isFromDashboard: false),
      backgroundColor: ThemeManager.BACKGROUND_COLOR,
      bottomNavigationBar: BottomBar(
        currentIndex: 1,
        onTapFunc: (val) {
          changeNav(context, val);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: primarycolor,
        leading: IconButton(
          onPressed: () {
            con.scaffoldKey.currentState?.openDrawer();
          },
          icon: Image.asset(
            MENU_ICON,
            width: 30,
            color: WHITE_COLOR.withOpacity(.9),
          ),
        ),
        title: Text(
          'Manage Cameras',
          style: textStyle1.copyWith(
            color: WHITE_COLOR.withOpacity(.9),
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: Stack(
        children: [
          con.obx(
            (state) => Column(
              children: [
                con.assignCameras.isNotEmpty
                    ? Expanded(
                        child: StreamBuilder(
                            key: UniqueKey(),
                            stream: FirebaseFirestore.instance
                                .collection("camera_list")
                                .where("user_id", isEqualTo: userData.value.id)
                                // .orderBy(
                                //   "cam_id",
                                //   descending: false,
                                // )
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                QuerySnapshot cameraListSnapshot = snapshot.data as QuerySnapshot;

                                if (cameraListSnapshot.docs.isNotEmpty) {
                                  var localData = cameraListSnapshot.docs;
                                  localData.sort((a, b) =>
                                      int.parse((a.data() as Map)["cam_id"].toString()).compareTo(int.parse((b.data() as Map)["cam_id"].toString())));
                                  // cameraListSnapshot.docs.removeWhere((element) => (element.data() as Map)["user_id"] != userData.value.id);
                                  return ListView.builder(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    itemCount: localData.length,
                                    itemBuilder: (context, index) {
                                      print(":::::");
                                      print(localData.length);
                                      CameraModel cameraData = CameraModel.fromJson(localData[index].data() as Map<String, dynamic>);
                                      return VLCStreamCard(
                                        key: ValueKey(cameraData.camId),
                                        cameraData: cameraData,
                                      );
                                    },
                                  );
                                } else {
                                  return const AlertInfo();
                                }
                              }
                              return const CommonLoader();
                            }),
                      )
                    : const Expanded(
                        child: AlertInfo(),
                      ),
              ],
            ),
            onLoading: const CommonLoader(),
          ),
        ],
      ),
    );
  }
}
