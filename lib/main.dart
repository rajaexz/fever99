// main backup
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'common/services/utils.dart';
import './screens/home.dart';
import './screens/landing.dart';
import '../support/app_theme.dart' as app_theme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fever99',
        theme: ThemeData(
          fontFamily: 'Fuzzy_Bubbles',
          useMaterial3: true,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: const Color.fromARGB(240, 30, 30, 30),
          primaryColor: const Color(0xFF74AC1D),
          colorScheme: ColorScheme.fromSwatch(
            errorColor: app_theme.error,
            brightness: Brightness.dark,
            primarySwatch: createMaterialColor(
              app_theme.primary,
            ),
          ).copyWith(
            background: app_theme.primary2,
          ),
        ),
        home: const HomePage(),
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/landing": (BuildContext context) => const LandingPage(),
          "/home": (BuildContext context) => const HomePage(),
        });
  }
}
