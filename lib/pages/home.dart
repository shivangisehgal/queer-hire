import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '/utils/colors.dart';
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
import '/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: (w! < 1080) ? AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('QueerHire',
        style: TextStyle(
          color: AppColors.primary
        ),),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: AppColors.primary,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ) : PreferredSize(child: NavBar(), preferredSize: Size.fromHeight(100)),
      drawer: w! < 1080 ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Handle Home tap
                GoRouter.of(context).pushNamed('home');
              },
            ),
            ListTile(
              title: Text('Jobs'),
              onTap: () {
                // Handle Jobs tap
                GoRouter.of(context).pushNamed('jobs');
              },
            ),
            ListTile(
              title: Text('Scholarships'),
              onTap: () {
                // Handle Scholarships tap
                GoRouter.of(context).pushNamed('scholarships');
              },
            ),
            ListTile(
              title: Text('Training'),
              onTap: () {
                // Handle Training tap
                GoRouter.of(context).pushNamed('training');
              },
            ),
            ListTile(
              title: Text('Guidance'),
              onTap: () {
                // Handle Guidance tap
                GoRouter.of(context).pushNamed('guidance');
              },
            ),
          ],
        ),
      ) : null,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container1(),
            //Text(Provider.of<UserProvider>(context).user.email!),
            Container2(),
            CommonContainer(
              'Fostering LGBTQ+ Representation and Inclusivity in the Workplace',
              'Connecting the LGBTQ+ community with inclusive employers',
              'QueerHire promotes diversity and equality by creating an inclusive job market for all job seekers. We aim to advance LGBTQ+ representation and provide equal opportunities to everyone, regardless of their characteristics.',
              image2,
              true),
            CommonContainer(
                'Building Inclusive Workplaces',
                'Providing LGBTQ+ Inclusive Training for Employers',
                'QueerHire provides LGBTQ+ inclusive training for employers to build a more welcoming and supportive workplace for all employees. Our training program equips employers with the tools they need to create a safe and welcoming environment for LGBTQ+ employees.',
                image1,
                false),
            CountContainer(),
            Cointainer3(),
            Container4(),
            Container5(false),
            CustomBottomAppBar(),
          ],
        ),
      ),
    );
  }
}
