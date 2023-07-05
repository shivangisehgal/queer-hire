import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              // AppColors.red,
              // AppColors.yellow,
              // AppColors.oliveGreen,
              // AppColors.pastelBlue,
              //AppColors.primary,
              //Color(0xFFFDF7C3),
              Color(0xFFFFDEB4),
              Color.fromRGBO(255, 180, 180, 1),
              Color(0xFFB2A4FF),
            ],
          ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Conceptualised and created by Shivangi Sehgal'.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Container(
            width: w!/2,
            child: Divider(
              color: Colors.white,
              height: 36,
            ),
          ),
          Text(
            'COPYRIGHT \u00a9 2022',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
