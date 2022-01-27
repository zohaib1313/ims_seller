import 'package:flutter/cupertino.dart';
import 'package:ims_seller/screens/add_new_customer.dart';
import 'package:ims_seller/screens/add_new_product_screen.dart';
import 'package:ims_seller/screens/dashboard_screen.dart';
import 'package:ims_seller/screens/invoice_new_screen.dart';
import 'package:ims_seller/screens/invoice_summary_screen.dart';
import 'package:ims_seller/screens/main_screen.dart';
import 'package:ims_seller/screens/search_customer_screen.dart';
import 'package:ims_seller/screens/send_alert_screen.dart';
import 'package:ims_seller/screens/sigin_screen.dart';
import 'package:ims_seller/screens/splash_screen.dart';
import 'package:ims_seller/screens/target_details_screen.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:ims_seller/view_models/dashboard_view_model.dart';
import 'package:ims_seller/view_models/invoice_new_view_model.dart';
import 'package:ims_seller/view_models/main_screen_view_model.dart';
import 'package:ims_seller/view_models/sigin_screen_view_model.dart';
import 'package:ims_seller/view_models/splash_screen_view_model.dart';
import 'package:ims_seller/view_models/target_details_view_model.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext? myContext = navigatorKey.currentState!.context;

class RoutesAndNavigation {
  final Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.id: (context) => const SplashScreen(),
    SignInScreen.id: (context) => const SignInScreen(),
    DashBoardScreen.id: (context) => const DashBoardScreen(),
    MainScreen.id: (context) => const MainScreen(),
    TargetDetailsScreen.id: (context) => const TargetDetailsScreen(),
    InvoiceNewScreen.id: (context) => const InvoiceNewScreen(),
    SearchCustomerScreen.id: (context) => const SearchCustomerScreen(),
    AddNewCustomer.id: (context) => const AddNewCustomer(),
    AddNewProductScreen.id: (context) => AddNewProductScreen(),
    InvoiceSummaryScreen.id: (context) => const InvoiceSummaryScreen(),
    SendAlertInvoiceGeneratedScreen.id: (context) =>
        const SendAlertInvoiceGeneratedScreen(),
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
    ChangeNotifierProvider<InvoiceNewViewModel>(
        create: (_) => InvoiceNewViewModel()),
    ChangeNotifierProvider<AddNewProductViewModel>(
        create: (_) => AddNewProductViewModel()),
  ];
}
