import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:padosee/constants/theme/shared_styles.dart';

class VideoSstream extends StatefulWidget {
  final String videoUrl;
  final String cameraName;
  const VideoSstream({Key? key, required this.videoUrl, required this.cameraName}) : super(key: key);

  @override
  State<VideoSstream> createState() => _VideoSstreamState();
}

class _VideoSstreamState extends State<VideoSstream> {
  VlcPlayerController? controller;

  bool isStreamPlaying = false;

  Timer? t1;

  @override
  void initState() {
    try {
      controller = VlcPlayerController.network(
        widget.videoUrl,
        hwAcc: HwAcc.full,
        autoPlay: false,
        options: VlcPlayerOptions(
          advanced: VlcAdvancedOptions([
            VlcAdvancedOptions.networkCaching(1000),
          ]),
          rtp: VlcRtpOptions([
            VlcRtpOptions.rtpOverRtsp(true),
          ]),
        ),
      )..addOnInitListener(() {
          controller?.setVolume(0);
          controller?.play();
          setState(() {});
        });
    } catch (e) {
      print("error::::$e");
    }
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isStreamPlaying = controller!.value.isPlaying;
      });
      print("video is playing:::>>>$isStreamPlaying");
    });

    super.initState();
  }

  @override
  void dispose() {
    controller?.stopRendererScanning();
    controller?.dispose();
    if (Get.mediaQuery.orientation != Orientation.portrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: VlcPlayer(
                controller: controller!,
                // aspectRatio: 16 / 9,
                aspectRatio: Get.context!.devicePixelRatio,
                // placeholder: const Center(
                //   child: CircularProgressIndicator(),
                // ),
              ),
            ),
            // !isStreamPlaying
            //     ? Align(
            //         alignment: Alignment.center,
            //         child: AspectRatio(
            //           aspectRatio: 16 / 9,
            //           child: Center(
            //             child: Text(
            //               "Camera Not Connected",
            //               style: textStyle1.copyWith(
            //                 color: WHITE_COLOR.withOpacity(.9),
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     : const SizedBox(),
            Align(
              alignment: Alignment.bottomCenter,
              child: rotateButton(),
            ),
            Positioned(
              top: 15,
              right: 0,
              child: closeButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget rotateButton() {
    return InkWell(
      onTap: () {
        if (Get.mediaQuery.orientation == Orientation.portrait) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ]);
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Rotate",
              style: textStyle1.copyWith(
                fontSize: 14,
                color: WHITE_COLOR,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.screen_rotation_rounded,
              color: WHITE_COLOR,
            ),
          ],
        ),
      ),
    );
  }

  Widget closeButton() {
    return MaterialButton(
      onPressed: () {
        Get.back();
      },
      color: Colors.white24,
      padding: const EdgeInsets.all(10),
      shape: const CircleBorder(),
      child: const Icon(
        Icons.close,
        size: 30,
        color: WHITE_COLOR,
      ),
    );
  }
}
