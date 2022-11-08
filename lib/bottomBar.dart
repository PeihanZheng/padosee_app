import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/theme/assets.dart';
import 'package:padosee/constants/theme/colors.dart';

class BottomBar extends StatefulWidget {
  final int currentIndex;
  final Function onTapFunc;
  const BottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTapFunc,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  activeIconWidget(String image) {
    return Container(
      transform: Matrix4.translationValues(0, 8, 0),
      child: Column(
        children: [
          Image.asset(
            image,
            width: 25,
            height: 25,
            color: WHITE_COLOR,
          ),
          const Text(
            "•",
            style: TextStyle(
              fontSize: 18,
              height: .8,
              fontWeight: FontWeight.bold,
              color: WHITE_COLOR,
            ),
          ),
        ],
      ),
    );
  }

  inactiveIconWidget(String image) {
    return Image.asset(
      image,
      width: 25,
      height: 25,
      color: WHITE_COLOR.withOpacity(.6),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .08,
      child: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 0,
        onTap: widget.onTapFunc as void Function(int),
        backgroundColor: primarycolor,
        currentIndex: widget.currentIndex,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: widget.currentIndex == 0 ? activeIconWidget(HOME_TAB2) : inactiveIconWidget(HOME_TAB1),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: widget.currentIndex == 1 ? activeIconWidget(CAMERA_TAB2) : inactiveIconWidget(CAMERA_TAB1),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: widget.currentIndex == 2 ? activeIconWidget(ADD_TAB2) : inactiveIconWidget(ADD_TAB1),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: widget.currentIndex == 3 ? activeIconWidget(MEMBER_TAB2) : inactiveIconWidget(MEMBER_TAB1),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: widget.currentIndex == 4 ? activeIconWidget(CHAT_TAB2) : inactiveIconWidget(CHAT_TAB1),
          ),
        ],
      ),
    );
  }
}

changeNav(BuildContext ctx, int index) {
  switch (index) {
    case 0:
      {
        Get.offNamed('/dashboard');
      }
      break;
    case 1:
      {
        Get.offNamed('/view-camera');
      }
      break;
    case 2:
      {
        Get.offNamed('/assign-camera');
      }
      break;
    case 3:
      {
        Get.offNamed('/manage-members');
      }
      break;
    case 4:
      {
        Get.offNamed('/messages');
      }
      break;
    default:
      {
        Get.offNamed('/dashboard');
      }
      break;
  }
}
