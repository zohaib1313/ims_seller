import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ims_seller/routes.dart';
import 'package:ims_seller/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: () => MultiProvider(
        providers: RoutesAndNavigation().multiProviders,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.id,
          routes: RoutesAndNavigation().routes,
          navigatorKey: navigatorKey,
          theme: ThemeData(textTheme: GoogleFonts.ibmPlexSansTextTheme()),
        ),
      ),
    );
  }
}
