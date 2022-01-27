import 'package:flutter/material.dart';

class AppColor {
  static const blackColor = Colors.black;
  static const whiteColor = Colors.white;
  static const redColor = Colors.red;
  static const blueColor = Color(0xff0071E3);
  static const greenColor = Color(0xff42B14A);
  static const greyColor = Colors.grey;
  static const alphaGrey = Color(0xffF0F0F0);
}

class AppAssets {
  static const appLogo = 'assets/icons/app-icon.svg';
  static const lockIc = 'assets/icons/login-icon.svg';
  static const userIcon = 'assets/icons/icon-user.svg';
  static const passwordIc = 'assets/icons/icon-password.svg';
}

class AppTextStyles {
  static const TextStyle largeBold = TextStyle(
      color: AppColor.whiteColor, fontWeight: FontWeight.bold, fontSize: 22);
  static const TextStyle mediumBold = TextStyle(
      color: AppColor.whiteColor, fontWeight: FontWeight.bold, fontSize: 18);
  static const TextStyle medium =
      TextStyle(color: AppColor.whiteColor, fontSize: 18);
  static const TextStyle smallBold = TextStyle(
      color: AppColor.whiteColor, fontWeight: FontWeight.bold, fontSize: 16);
  static const TextStyle small =
      TextStyle(color: AppColor.whiteColor, fontSize: 16);
  static const TextStyle large = TextStyle(
      color: AppColor.whiteColor, fontWeight: FontWeight.normal, fontSize: 22);
}
