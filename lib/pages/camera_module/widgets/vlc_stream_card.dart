// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'package:get/get.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';

import 'package:padosee/constants/theme/shared_styles.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/models/data_models/camera_model.dart';

import '../controller/camera_controller.dart';
import 'video_stream.dart';

class VLCStreamCard extends StatefulWidget {
  final CameraModel? cameraData;
  const VLCStreamCard({Key? key, this.cameraData}) : super(key: key);

  @override
  State<VLCStreamCard> createState() => _VLCStreamCardState();
}

class _VLCStreamCardState extends State<VLCStreamCard> {
  final con = Get.put(CameraController());

  VlcPlayerController? controller;

  bool errorText = false;

  String? imageUrl;

  var playing;

  Uint8List? imageData;

  @override
  void initState() {
    // controller = VlcPlayerController.network(
    //   widget.cameraData?.rtspLink ?? "",
    //   hwAcc: HwAcc.full,
    //   autoPlay: true,
    //   options: VlcPlayerOptions(),
    // );

    // Future.delayed(const Duration(seconds: 1), () async {
    //   imageData = await controller?.takeSnapshot();
    //   setState(() {});
    // });

    super.initState();
  }

  @override
  void dispose() {
    // controller?.startRendererScanning();
    // controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      color: WHITE_COLOR,
      shadowColor: primarycolor.withOpacity(.5),
      child: SizedBox(
        width: Get.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              highlightColor: Colors.transparent,
              splashColor: primarycolor.withOpacity(.1),
              onTap: () {
                Get.to(
                  () => VideoSstream(
                    cameraName: widget.cameraData!.camName!,
                    videoUrl: widget.cameraData!.rtspLink!,
                  ),
                );
              },
              child: Container(
                width: (Get.width - 20) / 3.1,
                height: (Get.width - 20) / 4.3,
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/cctv-thumbnail.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      spreadRadius: 1,
                      color: Colors.black26,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_outline_rounded,
                    color: WHITE_COLOR,
                    size: 50,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(
                        widget.cameraData?.camName ?? "NA",
                        style: textStyle1.copyWith(
                          fontSize: 18,
                          color: primarycolor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.start,
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 18,
                        color: textcolor.withOpacity(.7),
                      ),
                      Text(
                        widget.cameraData?.camLocation ?? "NA",
                        style: textStyle1.copyWith(
                          fontSize: 12,
                          color: textcolor.withOpacity(.7),
                          letterSpacing: .5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () {
                con.onRemoveCamera(context, num.parse(widget.cameraData!.camId.toString()));
              },
              splashRadius: 25,
              icon: Image.asset(
                TRASH_ICON,
                width: 22,
                height: 22,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
