import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';


class CountContainer extends StatefulWidget {
  const CountContainer({Key? key}) : super(key: key);

  @override
  State<CountContainer> createState() => _CountContainerState();
}

class _CountContainerState extends State<CountContainer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){

          if(constraints.maxWidth < 625)
            return MobileCountContainer();
          else
            return DesktopCountContainer();
        }
    );
  }
}



class DesktopCountContainer extends StatefulWidget {
  const DesktopCountContainer({Key? key}) : super(key: key);

  @override
  _DesktopCountContainerState createState() => _DesktopCountContainerState();
}

class _DesktopCountContainerState extends State<DesktopCountContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        image: DecorationImage(
            image: AssetImage(image3),
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
            fit: BoxFit.cover
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CountCard(count: 15, title: 'Companies'),
          Container(
            height: 150,
            child: VerticalDivider(
              thickness: 3,
              color: Colors.white.withOpacity(0.45),

            ),
          ),
          CountCard(count: 60, title: 'Recruited'),
          Container(
            height: 150,
            child: VerticalDivider(
              thickness: 3,
              color: Colors.white.withOpacity(0.45),

            ),
          ),
          CountCard(count: 12, title: 'Scholarships'),
          Container(
            height: 150,
            child: VerticalDivider(
              thickness: 3,
              color: Colors.white.withOpacity(0.45),

            ),
          ),
          CountCard(count: 310, title: 'Trainees')
        ],
      ),
    );
  }
}

class CountCard extends StatefulWidget {
  double count;
  String title;
  CountCard({required this.count, required this.title});

  @override
  _CountCardState createState() => _CountCardState();
}

class _CountCardState extends State<CountCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Countup(
          begin: 0,
          end: widget.count,
          duration: Duration(seconds: 3),
          separator: ',',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        Text(widget.title.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}

class MobileCountContainer extends StatefulWidget {
  const MobileCountContainer({Key? key}) : super(key: key);

  @override
  State<MobileCountContainer> createState() => _MobileCountContainerState();
}

class _MobileCountContainerState extends State<MobileCountContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        image: DecorationImage(
            image: AssetImage(image3),
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
            fit: BoxFit.cover
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CountCard(count: 15, title: 'Companies'),
          Container(
            width: w! - 20,
            child: Divider(
              thickness: 3,
              color: Colors.white.withOpacity(0.45),

            ),
          ),
          CountCard(count: 60, title: 'Recruited'),
          Container(
            width: w! - 20,
            child: Divider(
              thickness: 3,
              color: Colors.white.withOpacity(0.45),

            ),
          ),
          CountCard(count: 12, title: 'Scholarships'),
          Container(
            width: w! - 20,
            child: Divider(
              thickness: 3,
              color: Colors.white.withOpacity(0.45),

            ),
          ),
          CountCard(count: 310, title: 'Trainees')
        ],
      ),
    );
  }
}
