import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:responsive_builder/responsive_builder.dart';
import '/utils/constants.dart';
import '/utils/colors.dart';

class Container2 extends StatefulWidget {
  const Container2({Key? key}) : super(key: key);

  @override
  State<Container2> createState() => _Container2State();
}

class _Container2State extends State<Container2> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){

          if(constraints.maxWidth < 970)
            return MobileContainer2();

          else
            return DesktopContainer2();
        }
    );
  }
}

class DesktopContainer2 extends StatelessWidget {
  const DesktopContainer2({Key? key}) : super(key: key);

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
            CustomCard(title: 'Jobs & Intenships', image: jobIcon),
            SizedBox(width: 10),
            CustomCard(title: 'Scholarships', image: scholarIcon),
            SizedBox(width: 10),
            CustomCard(title: 'Trainings', image: trainingIcon),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({required this.title, required this.image});
  String title;
  String image;
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
              radius: 40,
              backgroundColor: AppColors.primary,
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 35,
                backgroundImage: AssetImage(
                    image,
                ),
              ),
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

class MobileContainer2 extends StatelessWidget {
  const MobileContainer2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
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
            Color(0xFFFDF7C3),
            Color(0xFFFFDEB4),
            Color(0XFFFFB4B4),
            Color(0xFFB2A4FF),
          ],
        ),
        //color: AppColors.primary,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCard(title: 'Jobs & Intenships', image: jobIcon),
            //SizedBox(width: 10),
            CustomCard(title: 'Scholarships', image: scholarIcon),
            //SizedBox(width: 10),
            CustomCard(title: 'Trainings', image: trainingIcon),
          ],
        ),
      ),
    );
  }
}
