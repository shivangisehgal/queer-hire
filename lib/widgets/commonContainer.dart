import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';


class CommonContainer extends StatelessWidget {
  final String s1;
  final String s2;
  final String s3;
  final String image;
  final bool imageLeft;

  const CommonContainer({
    required this.s1,
    required this.s2,
    required this.s3,
    required this.image,
    required this.imageLeft,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){

          if(constraints.maxWidth < 900)
            return MobileCommonContainer(s1: s1, s2: this.s2, s3: this.s3, image: this.image, imageLeft: this.imageLeft);

          else
            return DesktopCommonContainer(s1: s1, s2: this.s2, s3: this.s3, image: this.image, imageLeft: this.imageLeft);
        }
    );
  }
}



class DesktopCommonContainer extends StatelessWidget {
  final String s1;
  final String s2;
  final String s3;
  final String image;
  final bool imageLeft;

  const DesktopCommonContainer({
    required this.s1,
    required this.s2,
    required this.s3,
    required this.image,
    required this.imageLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20, vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (imageLeft)
            Container(
              height: 300,
              width: 400,
              margin: EdgeInsets.only(right: 100),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
              ),
            )
          else
            Container(),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: imageLeft ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  s2,
                  textAlign: imageLeft ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width / 30,
                    height: 1.1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  s1.toUpperCase(),
                  textAlign: imageLeft ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  s3,
                  textAlign: imageLeft ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'HindSiliguri',
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          if (!imageLeft)
            Container(
              margin: EdgeInsets.only(left: 100),
              padding: EdgeInsets.all(5),
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}

class MobileCommonContainer extends StatelessWidget {
  final String s1;
  final String s2;
  final String s3;
  final String image;
  final bool imageLeft;

  const MobileCommonContainer({
    required this.s1,
    required this.s2,
    required this.s3,
    required this.image,
    required this.imageLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 680,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

            Container(
              height: 300,
              width: 400,
              //margin: EdgeInsets.only(right: 100),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
              ),
            ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                s2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                s1.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                s3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
              //SizedBox(height: 20),
            ],
          ),

        ],
      ),
    );
  }
}
