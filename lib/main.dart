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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // void initState() {
  //   getUserInfo();
  //   super.initState();
  // }
  //
  // Future getUserInfo() async {
  //   await getUser();
  //   setState(() {});
  //   print(uid);
  //   print(isRecruiter);
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'QueerHire',
      theme: ThemeData(
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
