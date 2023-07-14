import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/user_provider.dart';
import '/utils/colors.dart';
import '/pages/home.dart';
import '/pages/jobs.dart';
import '/pages/training.dart';
import '/pages/scholarships.dart';
import '/pages/counselling.dart';
import '/pages/login.dart';
import '/pages/register.dart';
import 'package:url_strategy/url_strategy.dart';
import '/routes/app_route_configuration.dart';
import '/services/auth.dart';
import 'package:provider/provider.dart';
import '/models/user.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDAWmzjonYLjwelFPcAlpAjqHSNxS8gEXI",
          appId: "1:612916349107:web:35692b75c7160d50bec8c6",
          messagingSenderId: "612916349107",
          projectId: "queerhire",
          storageBucket: "queerhire.appspot.com"
      ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final MaterialColor purple = MaterialColor(
    0xFFB37DC1,
    <int, Color>{
      50: Color(0xFFB37DC1),
      100: Color(0xFFB37DC1),
      200: Color(0xFFB37DC1),
      300: Color(0xFFB37DC1),
      400: Color(0xFFB37DC1),
      500: Color(0xFFB37DC1),
      600: Color(0xFFB37DC1),
      700: Color(0xFFB37DC1),
      800: Color(0xFFB37DC1),
      900: Color(0xFFB37DC1),
    },
  );

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'QueerHire',
      theme: ThemeData(
        primarySwatch: widget.purple,
        fontFamily: 'HindSiliguri',
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
      ),
      routeInformationParser: MyAppRouter.router.routeInformationParser,
      routerDelegate: MyAppRouter.router.routerDelegate,
      //home: Home(),
      //home: JobsPage(),
      //home: TrainingPage(),
      //home: ScholarshipsPage(),
      //home: GuidancePage(),
      //home: LoginRegisterPage(),
    );
  }
}
