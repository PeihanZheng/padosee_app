import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/constants/theme/themes.dart';
import 'package:padosee/constants/value_notifiers.dart';
import 'package:padosee/models/data_models/notifications_model.dart';
import 'package:padosee/widgets/loader.dart';

import 'controller/secondary_controller.dart';

class SecondaryAlerts extends StatefulWidget {
  const SecondaryAlerts({Key? key}) : super(key: key);

  @override
  State<SecondaryAlerts> createState() => _SecondaryAlertsState();
}

class _SecondaryAlertsState extends State<SecondaryAlerts> {
  final con = Get.put(SecondaryController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                notificationsList.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: notificationsList.value.length,
                              itemBuilder: (context, index) {
                                var notificationData = notificationsList.value[index];

                                if (notificationData.type == "request") {
                                  return requestNotificationsCard(index, notificationData, con);
                                } else {
                                  notificationsCard();
                                }

                                return const Center(child: Text("No Mesaages"));
                              },
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text(
                            "No notifications yet",
                            style: textStyle1.copyWith(fontSize: 18, color: ThemeManager.APP_TEXT_COLOR),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          if (con.isLoading.value) const CommonLoader(),
        ],
      ),
    );
  }

  Widget notificationsCard({String? message}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: Get.width,
      decoration: BoxDecoration(
        color: GREY_COLOR.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      child: Text(
        message ?? "",
        style: textStyle1.copyWith(
          color: ThemeManager.APP_TEXT_COLOR,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget requestNotificationsCard(int index, NotificationModel data, SecondaryController con) {
    return Card(
      elevation: 2,
      color: ThemeManager.CARD_COLOR,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    data.profileImage ?? DUMMY_IMG,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? "",
                    style: textStyle1.copyWith(fontSize: 16),
                  ),
                  Text(
                    data.subtitle ?? "",
                    style: textStyle1.copyWith(fontSize: 12, color: TEXT_COLOR, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Accept button
                      acceptWidget(con, index, data),
                      const SizedBox(width: 10),
                      // Remove button
                      actionsWidget(
                          onPressed: () {
                            con.onDeclined(index, data: data);
                          },
                          actionName: "Remove"),
                      const SizedBox(width: 10),
                      // Archive button
                      actionsWidget(
                          onPressed: () {
                            con.onArchived(index, data: data);
                          },
                          actionName: "Archive"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget acceptWidget(SecondaryController con, int index, NotificationModel data) {
    return TextButton(
      onPressed: () {
        con.onAccepted(index, data: data);
      },
      style: ButtonStyle(
        visualDensity: VisualDensity.comfortable,
        backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
        side: MaterialStateProperty.all(const BorderSide(
          color: PRIMARY_COLOR,
          width: 1,
        )),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8)),
      ),
      child: Text(
        "Accept",
        style: textStyle1.copyWith(fontSize: 12, color: WHITE_COLOR),
      ),
    );
  }

  Widget actionsWidget({Function? onPressed, String? actionName}) {
    return TextButton(
      onPressed: onPressed as void Function(),
      style: ButtonStyle(
        visualDensity: VisualDensity.comfortable,
        side: MaterialStateProperty.all(const BorderSide(
          color: GREY_COLOR,
          width: 1,
        )),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8)),
      ),
      child: Text(
        actionName!,
        style: textStyle1.copyWith(fontSize: 12, color: TEXT_COLOR),
      ),
    );
  }
}
