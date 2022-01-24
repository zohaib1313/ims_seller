import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/screens/sigin_screen.dart';
import 'package:ims_seller/styles.dart';

import '../routes.dart';

class SplashScreen extends StatefulWidget {
  static const id = "splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(myContext!, SignInScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.blackColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SvgViewer(svgPath: AppAssets.appLogo),
        ),
      ),
    );
  }
}
