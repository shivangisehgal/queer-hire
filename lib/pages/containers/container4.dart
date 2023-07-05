import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/styles.dart';
import '/utils/constants.dart';
import '/widgets/jobCard.dart';

class Container4 extends StatefulWidget {
  const Container4({Key? key}) : super(key: key);

  @override
  _Container4State createState() => _Container4State();
}

class _Container4State extends State<Container4> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFDF7C3).withOpacity(0.5),
              Color(0xFFFFDEB4).withOpacity(0.5),
              Color(0XFFFFB4B4).withOpacity(0.5),
              Color(0xFFB2A4FF).withOpacity(0.5),
            ],
          ),
        ),
        //color: AppColors.primary.withOpacity(0.25),
        width: double.infinity,
        //height: 700,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Popular Jobs',
              style: TextStyle(
                  fontSize: w! / 30, height: 1.1, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 50),
            Row(
              //crossAxisAlignment: WrapCrossAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                JobCard(
                  jobId: '1',
                    company: 'KPMG',
                    description:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget.',
                    role: 'Junior Consultant',
                    openings: 7),
                JobCard(
                    jobId: '1',
                    company: 'Apple',
                    description:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget.',
                    role: 'Junior Consultant',
                    openings: 7),
                JobCard(
                    jobId: '1',
                    company: 'CosRX',
                    description:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget.',
                    role: 'Junior Consultant',
                    openings: 7),
              ],
            ),
            //SizedBox(height: 30),
          ],
        ));
  }
}

