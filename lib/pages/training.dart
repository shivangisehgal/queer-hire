import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import '/widgets/navbar.dart';
import '/widgets/mobile.dart';

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
      appBar: (w! < 1070) ? PreferredSize(child: CustomAppBar(), preferredSize: Size.fromHeight(60)) : PreferredSize(child: NavBar(), preferredSize: Size.fromHeight(100)),
      drawer: (w! < 1070) ? CustomDrawer() : null,
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
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 50,
                    height: 1.1, fontWeight: FontWeight.w600),
              ),
              Divider(
                height: 80,
              ),
              Wrap(
                spacing: 50,
                runSpacing: 30,
                children: [
                  CustomCard(title: 'App Development', image: appDev),
                  CustomCard(title: 'UI/UX Designing', image: uiux,),
                  CustomCard(title: 'Product Management', image: product,),
                  CustomCard(title: 'Digital Marketing', image: digMark,),
                  CustomCard(title: 'HR Management', image: hrm,),
                  CustomCard(title: 'Data Analysis', image: dataAnal,),
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
  CustomCard({required this.title, required this.image});

  final String title;
  final String image;

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Thank you for your interest!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Congratulations, you\'ve taken the first step towards mastering the ',
                      ),
                      TextSpan(
                        text: title,
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                      TextSpan(
                        text: ' course. Our team is excited to bring you an exceptional learning experience!\n\n',
                      ),
                      TextSpan(
                        text: 'Stay tuned, as we prepare to launch soon.\n\nWe will notify you via email when this course becomes available.\n\n',
                      ),

                      TextSpan(
                        text: 'Keep exploring, keep growing, and keep rocking!',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDialog(context);
      },
      child: Card(
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
              Container(
                width: 70,
                height: 70,
                decoration:
                ShapeDecoration(
                    shape: CircleBorder(),
                    color: AppColors.primary),
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(image))),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
