import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/mobile.dart';


class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      //separate build functions
      mobile: CustomAppBar(),
      desktop: DesktopNavBar(),
    );
  }
}

class DesktopNavBar extends StatefulWidget {
  static String uid = '';

  @override
  State<DesktopNavBar> createState() => _DesktopNavBarState();
}

class _DesktopNavBarState extends State<DesktopNavBar> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> uid;

  void initState() {
    super.initState();
    uid = _prefs.then<String>((SharedPreferences prefs) {
      return Future.value(prefs.getString('uid') != null ? prefs.getString('uid') : '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      margin: EdgeInsets.only(left: 50, right: 50, top: 16, bottom: 16),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavLogo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NavButton('Home', 'home'),
                SizedBox(width: 20),
                NavButton('Jobs', 'jobs'),
                SizedBox(width: 20),
                NavButton('Scholarships', 'scholarships'),
                SizedBox(width: 20),
                NavButton('Training', 'training'),
                SizedBox(width: 20),
                NavButton('Guidance', 'guidance'),
              ],
            ),

            FutureBuilder<String>(
              future: uid,
              builder: (BuildContext context,
                  AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');

                    }

                    else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    else {
                      return snapshot.data != ''
                          ? StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where('id', isEqualTo: snapshot.data)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snap) {
                            if (!snap.hasData) {
                              return Container();
                            }
                            else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            return Container(
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hi, ',
                                    style: TextStyle(

                                    ),
                                  ),
                                  Text(
                                    snap.data!.docs[0]['name'],
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      GoRouter.of(context).pushNamed('profile');
                                    },
                                    child: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: AppColors.primary,
                                      child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          })
                          : NavButton2(title: 'Login or Register', purpose: 'login');
                    }
                }
              },
            ),



            // InkWell(
            //   //onTap: userEmail == null ? ();
            //   child: userEmail == null
            //       ?
            //       : Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //
            //           ],
            //         ),
            // ),



            //NavButton2(title: Provider.of<UserProvider>(context).user.name),
          ],
        ),
      ),
    );
  }
}

Widget NavLogo() {
  return Container(
    width: 110.0,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(logo),
      ),
    ),
  );
}

class NavButton extends StatelessWidget {
  String title;
  String navString;
  NavButton(this.title, this.navString);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(AppColors.primary.withOpacity(0.25)),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        onPressed: () {
          //context.vxNav.push(Uri.parse('/${widget.navString}'));
          GoRouter.of(context).pushNamed('$navString');
          //Navigator.pushNamed(context, '/${widget.navString}');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class NavButton2 extends StatelessWidget {
  String title;
  String purpose;
  NavButton2({required this.title, required this.purpose});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(AppColors.primary),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: AppColors.primary),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        onPressed: () {
          if (purpose == 'login')
            GoRouter.of(context).pushNamed('login');
          else
            GoRouter.of(context).pushNamed('profile');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
