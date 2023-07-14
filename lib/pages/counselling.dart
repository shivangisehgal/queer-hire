import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '/utils/constants.dart';
import '/widgets/navbar.dart';
import '/pages/containers/container5.dart';
import '/widgets/mobile.dart';

class GuidancePage extends StatefulWidget {
  const GuidancePage({Key? key}) : super(key: key);

  @override
  _GuidancePageState createState() => _GuidancePageState();
}

class _GuidancePageState extends State<GuidancePage> {
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
          //padding: EdgeInsets.symmetric(horizontal: 50, vertical: h! * 0.2),
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
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container5(true),
          ),
        ),
      ),
    );
  }
}
