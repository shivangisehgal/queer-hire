import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';

Widget CommonContainer(String s1, s2, s3, image, bool imageLeft) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: w! / 20, vertical: 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        imageLeft
            ? Container(
                height: 300,
                width: 400,
                margin: EdgeInsets.only(right: 100),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill),
                ),
              )
            : Container(),
        //SizedBox(width: 100),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment:
                imageLeft ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                s2,
                textAlign: imageLeft ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: w! / 30,
                    height: 1.1,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                s1.toUpperCase(),
                textAlign: imageLeft ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                s3,
                textAlign: imageLeft ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        //SizedBox(width: 100),
        !imageLeft
            ? Container(
                margin: EdgeInsets.only(left: 100),
                padding: EdgeInsets.all(5),
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill),
                ),
              )
            : Container()
      ],
    ),
  );
}
// gradient: LinearGradient(
// begin: Alignment.topLeft,
// end: Alignment.bottomRight,
// colors: [
// AppColors.red,
// AppColors.yellow,
// AppColors.oliveGreen,
// AppColors.pastelBlue,
// AppColors.primary
// ],
// ),

// Container(
// padding: EdgeInsets.all(5),
// height: 300,
// width: 200,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(Radius.circular(10)),
// image: DecorationImage(
// image: AssetImage(image), fit: BoxFit.contain),
// ),
// ),
// )
