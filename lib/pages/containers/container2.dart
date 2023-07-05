import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:responsive_builder/responsive_builder.dart';
import '/utils/constants.dart';
import '/utils/colors.dart';

class Container2 extends StatelessWidget {
  const Container2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ribbon),
          fit: BoxFit.fitHeight
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            // AppColors.red,
            // AppColors.yellow,
            // AppColors.oliveGreen,
            // AppColors.pastelBlue,
            //AppColors.primary,
            Color(0xFFFDF7C3),
            Color(0xFFFFDEB4),
            Color(0XFFFFB4B4),
            Color(0xFFB2A4FF),
          ],
        ),
        //color: AppColors.primary,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCard(title: 'Jobs & Intenships'),
            SizedBox(width: 10),
            CustomCard(title: 'Scholarships'),
            SizedBox(width: 10),
            CustomCard(title: 'Trainings'),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 200,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 35,
            ),
            SizedBox(height: 20,),
            Text(title,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
            ),
          ],
        ),
      ),
    );
  }
}
