import 'package:flutter/material.dart';
import '/pages/home.dart';
import '/utils/constants.dart';
import '/widgets/navbar.dart';
import '/provider/user_provider.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
class SignOutPage extends StatelessWidget {
  const SignOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          width: w! / 4,
          height: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular((15.0))),
            gradient: LinearGradient(
              end: Alignment.topLeft,
              begin: Alignment.bottomRight,
              colors: [
                //Color(0xFFFDF7C3),
                Color(0xFFFFDEB4),
                Color(0XFFFFB4B4),
                Color(0xFFB2A4FF),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bye-Bye!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'PLEASE REFRESH BEFORE SIGNING OUT :)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),

              TextButton(
                style: ButtonStyle(
                  overlayColor:
                  MaterialStateProperty.all(Colors.white.withOpacity(0.05)),
                  elevation: MaterialStateProperty.all(0),
                  //backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                onPressed: () {
                  GoRouter.of(context).pushNamed('home');
                },
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  child: Text(
                    'SIGN OUT',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        )
      ),
    );
  }
}
