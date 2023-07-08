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
    return ScreenTypeLayout(
      mobile: MobileContainer1(),
      desktop: DesktopContainer1(),
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
                          fontSize: w! / 15,
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
                  //SizedBox(height: 20.0),
                  // Text('Your one-stop-shop for queer-friendly job opportunities and resources.',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.grey[400],
                  //   ),
                  // ),
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

Widget MobileContainer1() {
  return Container(
    //margin: EdgeInsets.symmetric(horizontal: w!/10),
    child: Column(
      children: <Widget>[
        Container(
          height: w! / 1.2,
          width: w! / 1.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(illustration1),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Track your \nExpenses to \nSave Money',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.2,
                  fontSize: w! / 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Helps you organize \nyour income and expenses',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 45,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primary)),
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_down),
                  label: Text('Try free demo'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '-Web, iOS and Android',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    ),
  );
}
