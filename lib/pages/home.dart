import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '/utils/constants.dart';
import 'package:go_router/go_router.dart';
import '/pages/containers/container1.dart';
import '/pages/containers/container2.dart';
import '/pages/containers/container3.dart';
import '/pages/containers/container4.dart';
import '/pages/containers/container5.dart';
import '/widgets/navbar.dart';
import '/widgets/commonContainer.dart';
import '/widgets/countContainer.dart';
import '/widgets/bottomAppBar.dart';
import '/widgets/mobile.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: (w! < 1070) ? PreferredSize(child: CustomAppBar(), preferredSize: Size.fromHeight(60)) : PreferredSize(child: NavBar(), preferredSize: Size.fromHeight(100)),
      drawer: (w! < 1070) ? CustomDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container1(),
            //Text(Provider.of<UserProvider>(context).user.email!),
            Container2(),
            CommonContainer(
              s1: 'Fostering LGBTQ+ Representation and Inclusivity in the Workplace',
              s2: 'Connecting the LGBTQ+ community with inclusive employers',
              s3: 'QueerHire promotes diversity and equality by creating an inclusive job market for all job seekers. We aim to advance LGBTQ+ representation and provide equal opportunities to everyone, regardless of their characteristics.',
              image: image2,
              imageLeft: true),
            CommonContainer(
                s1: 'Building Inclusive Workplaces',
                s2: 'Providing LGBTQ+ Inclusive Training for Employers',
                s3: 'QueerHire provides LGBTQ+ inclusive training for employers to build a more welcoming and supportive workplace for all employees. Our training program equips employers with the tools they need to create a safe and welcoming environment for LGBTQ+ employees.',
                image: image1,
                imageLeft: false),
            CountContainer(),
            Container3(),
            Container4(),
            Container5(false),
            CustomBottomAppBar(),
          ],
        ),
      ),
    );
  }
}
