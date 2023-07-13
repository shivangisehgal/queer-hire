import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '/utils/constants.dart';
import '/utils/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Container1 extends StatelessWidget {
  const Container1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth < 970)
          return MobileContainer1();

        else
          return DesktopContainer1();
      }
    );
  }
}

class DesktopContainer1 extends StatefulWidget {
  const DesktopContainer1({Key? key}) : super(key: key);

  @override
  State<DesktopContainer1> createState() => _DesktopContainer1State();
}

class _DesktopContainer1State extends State<DesktopContainer1> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> uid;

  @override
  void initState() {
    super.initState();
    uid = _prefs.then<String>((SharedPreferences prefs) {
      return Future.value(
          prefs.getString('uid') != null ? prefs.getString('uid') : '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color(0xFFF4EEDB),
      margin: EdgeInsets.symmetric(horizontal: w! / 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          height: 1.2,
                          fontSize: w! / 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HindSiliguri'),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Q', style: TextStyle(color: AppColors.red)),
                        TextSpan(
                            text: 'u',
                            style: TextStyle(color: AppColors.yellow)),
                        TextSpan(
                            text: 'e',
                            style: TextStyle(color: AppColors.oliveGreen)),
                        TextSpan(
                            text: 'e',
                            style: TextStyle(color: AppColors.pastelBlue)),
                        TextSpan(
                            text: 'r',
                            style: TextStyle(color: AppColors.primary)),
                        TextSpan(text: 'Hire'),
                      ],
                    ),
                  ),
                  Text(
                    'Breaking down employment barriers \nfor the LGBTQ+ community.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  FirebaseAuth.instance.currentUser == null
                      ?
                  Row(
                    children: [
                      Container(
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.primary)),
                                onPressed: () {
                                  GoRouter.of(context).pushNamed('login');
                                },
                                child: Text(
                                  'Login or Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),),
                          SizedBox(
                            width: 17.0,
                          ),
                          Text(
                        'Join our community \nin just one step!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  ) :
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.primary)),
                      onPressed: () {
                        GoRouter.of(context).pushNamed('jobs');
                      },
                      child: Text(
                        'Grab your dream oppportunity now!',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 735,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(illustration1),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MobileContainer1 extends StatefulWidget {
  const MobileContainer1({Key? key}) : super(key: key);

  @override
  State<MobileContainer1> createState() => _MobileContainer1State();
}

class _MobileContainer1State extends State<MobileContainer1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: w!/10),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            height: 600,
            width: 600,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(illustration1),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      height: 1.2,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HindSiliguri'),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Q', style: TextStyle(color: AppColors.red)),
                    TextSpan(
                        text: 'u',
                        style: TextStyle(color: AppColors.yellow)),
                    TextSpan(
                        text: 'e',
                        style: TextStyle(color: AppColors.oliveGreen)),
                    TextSpan(
                        text: 'e',
                        style: TextStyle(color: AppColors.pastelBlue)),
                    TextSpan(
                        text: 'r',
                        style: TextStyle(color: AppColors.primary)),
                    TextSpan(text: 'Hire'),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Breaking down employment barriers \nfor the LGBTQ+ community.',
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),

              FirebaseAuth.instance.currentUser == null
                  ?
              Column(
                children: [
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.primary)),
                      onPressed: () {
                        GoRouter.of(context).pushNamed('login');
                      },
                      child: Text(
                        'Login or Register',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),),
                  SizedBox(
                    height: 17.0,
                  ),
                  Text(
                    'Join our community in just one step!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ) :
              Container(
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppColors.primary)),
                  onPressed: () {
                    GoRouter.of(context).pushNamed('jobs');
                  },
                  child: Text(
                    'Grab your dream oppportunity now!',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}

