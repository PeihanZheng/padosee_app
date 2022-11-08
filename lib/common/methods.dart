import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/theme/colors.dart';
import '../constants/theme/shared_styles.dart';

customSnackbar({String? message, bool? isSuccess}) {
  Get.showSnackbar(
    GetSnackBar(
      backgroundColor: isSuccess! ? Colors.green : Colors.red,
      borderRadius: 20,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      snackPosition: SnackPosition.TOP,
      messageText: Text(
        message!,
        style: textStyle1.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: isSuccess ? TEXT_COLOR : WHITE_COLOR,
          letterSpacing: .5,
        ),
      ),
    ),
  );
}
