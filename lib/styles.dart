import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

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
      color: AppColor.whiteColor, fontWeight: FontWeight.bold, fontSize: 20);
  static const TextStyle mediumBold = TextStyle(
      color: AppColor.whiteColor, fontWeight: FontWeight.bold, fontSize: 14);
  static const TextStyle medium =
      TextStyle(color: AppColor.whiteColor, fontSize: 16);
  static const TextStyle smallBold = TextStyle(
      color: AppColor.whiteColor, fontWeight: FontWeight.bold, fontSize: 12);
  static const TextStyle small =
      TextStyle(color: AppColor.whiteColor, fontSize: 16);
  static const TextStyle large = TextStyle(
      color: AppColor.whiteColor, fontWeight: FontWeight.normal, fontSize: 20);

  static double largep = 60;
  static double mediump = 40;
  static double smallp = 30;
  static double xSmallp = 20;
/*  static double largep = 30;
  static double mediump = 20;
  static double smallp = 10;
  static double xSmallp = 7;*/

  static pw.TextStyle largeBoldPrint =
      pw.TextStyle(fontSize: largep, fontWeight: pw.FontWeight.bold);
  static pw.TextStyle mediumBoldPrint =
      pw.TextStyle(fontSize: mediump, fontWeight: pw.FontWeight.bold);
  static pw.TextStyle smallBoldPrint =
      pw.TextStyle(fontSize: smallp, fontWeight: pw.FontWeight.bold);
  static pw.TextStyle sSmallBoldPrint =
      pw.TextStyle(fontSize: xSmallp, fontWeight: pw.FontWeight.bold);

  static pw.TextStyle largeNormalPrint = pw.TextStyle(fontSize: largep);
  static pw.TextStyle mediumNormalPrint = pw.TextStyle(fontSize: mediump);
  static pw.TextStyle smallNormalPrint = pw.TextStyle(fontSize: smallp);
  static pw.TextStyle sSmallNormalPrint = pw.TextStyle(fontSize: xSmallp);
}
