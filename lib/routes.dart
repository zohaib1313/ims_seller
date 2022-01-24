import 'package:flutter/cupertino.dart';
import 'package:ims_seller/screens/dashboard_screen.dart';
import 'package:ims_seller/screens/main_screen.dart';
import 'package:ims_seller/screens/sigin_screen.dart';
import 'package:ims_seller/screens/splash_screen.dart';
import 'package:ims_seller/view_models/dashboard_view_model.dart';
import 'package:ims_seller/view_models/main_screen_view_model.dart';
import 'package:ims_seller/view_models/sigin_screen_view_model.dart';
import 'package:ims_seller/view_models/splash_screen_view_model.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext? myContext = navigatorKey.currentState!.context;

class RoutesAndNavigation {
  final Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.id: (context) => const SplashScreen(),
    SignInScreen.id: (context) => const SignInScreen(),
    DashBoardScreen.id: (context) => const DashBoardScreen(),
    MainScreen.id: (context) => const MainScreen()
  };

  final List<ChangeNotifierProvider<dynamic>> multiProviders = [
    ChangeNotifierProvider<SplashScreenViewModel>(
        create: (_) => SplashScreenViewModel()),
    ChangeNotifierProvider<SignInViewModel>(create: (_) => SignInViewModel()),
    ChangeNotifierProvider<DashboardViewModel>(
        create: (_) => DashboardViewModel()),
    ChangeNotifierProvider<MainScreenViewModel>(
        create: (_) => MainScreenViewModel()),
  ];
}
