import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '/widgets/bottomAppBar.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import '/widgets/navbar.dart';
import '/widgets/jobCard.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: (w! < 1080)
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text('QueerHire'),
            )
          : PreferredSize(child: NavBar(), preferredSize: Size.fromHeight(100)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: h! * 0.2),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFDEB4).withOpacity(0.5),
                Color(0XFFFFB4B4).withOpacity(0.5),
                Color(0xFFB2A4FF).withOpacity(0.5),
              ],
            ),
          ),
          child: Column(
            children: [
              Text(
                'Be Job Ready',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: w! / 30, height: 1.1, fontWeight: FontWeight.w600),
              ),
              Divider(
                height: 80,
              ),
              Wrap(
                spacing: 50,
                runSpacing: 30,
                children: [
                  CustomCard(title: 'App Development'),
                  CustomCard(title: 'UI/UX Designing'),
                  CustomCard(title: 'Product Management'),
                  CustomCard(title: 'Digital Marketing'),
                  CustomCard(title: 'HR Management'),
                  CustomCard(title: 'Data Analysis'),
                ],
              ),
            ],
          ),
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
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 200,
        width: 350,
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
