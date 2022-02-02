import 'package:flutter/cupertino.dart';
import 'package:ims_seller/screens/TestProviderScren.dart';
import 'package:ims_seller/screens/add_new_customer.dart';
import 'package:ims_seller/screens/dashboard_screen.dart';
import 'package:ims_seller/screens/invoice_summary_screen.dart';
import 'package:ims_seller/screens/main_screen.dart';
import 'package:ims_seller/screens/search_customer_screen.dart';
import 'package:ims_seller/screens/send_alert_screen.dart';
import 'package:ims_seller/screens/sigin_screen.dart';
import 'package:ims_seller/screens/splash_screen.dart';
import 'package:ims_seller/screens/success_screen.dart';
import 'package:ims_seller/view_models/TesTViewModel.dart';
import 'package:ims_seller/view_models/add_new_customer_view_model.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:ims_seller/view_models/dashboard_view_model.dart';
import 'package:ims_seller/view_models/main_screen_view_model.dart';
import 'package:ims_seller/view_models/sales_invoice_view_model.dart';
import 'package:ims_seller/view_models/search_customer_view_model.dart';
import 'package:ims_seller/view_models/sigin_screen_view_model.dart';
import 'package:ims_seller/view_models/splash_screen_view_model.dart';
import 'package:ims_seller/view_models/target_details_view_model.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext? myContext = navigatorKey.currentState!.context;

final Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.id: (context) => const SplashScreen(),
  SignInScreen.id: (context) => SignInScreen(),
  DashBoardScreen.id: (context) => DashBoardScreen(),
  MainScreen.id: (context) => const MainScreen(),
  SearchCustomerScreen.id: (context) => SearchCustomerScreen(),
  AddNewCustomer.id: (context) => AddNewCustomer(),
  InvoiceSummaryScreen.id: (context) => InvoiceSummaryScreen(),
  SendAlertInvoiceGeneratedScreen.id: (context) =>
      SendAlertInvoiceGeneratedScreen(),
  SuccessScreen.id: (context) => SuccessScreen(""),
  TestScreen.id: (context) => TestScreen(),
};

final List<ChangeNotifierProvider<dynamic>> multiProviders = [
  ChangeNotifierProvider<SplashScreenViewModel>(
      create: (_) => SplashScreenViewModel()),
  ChangeNotifierProvider<SignInViewModel>(create: (_) => SignInViewModel()),
  ChangeNotifierProvider<DashboardViewModel>(
      create: (_) => DashboardViewModel()),
  ChangeNotifierProvider<MainScreenViewModel>(
      create: (_) => MainScreenViewModel()),
  ChangeNotifierProvider<TargetDetailsViewModel>(
      create: (_) => TargetDetailsViewModel()),
  ChangeNotifierProvider<SaleInvoiceViewModel>(
      create: (_) => SaleInvoiceViewModel()),
  ChangeNotifierProvider<AddNewProductViewModel>(
      create: (_) => AddNewProductViewModel()),
  ChangeNotifierProvider<SearchCustomerViewModel>(
      create: (_) => SearchCustomerViewModel()),
  ChangeNotifierProvider<AddNewCustomerViewModel>(
      create: (_) => AddNewCustomerViewModel()),
  ChangeNotifierProvider<TestViewModel>(create: (_) => TestViewModel()),
];
