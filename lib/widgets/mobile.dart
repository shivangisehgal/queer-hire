import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/navbar.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: RichText(
        text: TextSpan(
          style: TextStyle(
              height: 1.2,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'HindSiliguri'),
          children: <TextSpan>[
            TextSpan(text: 'Q', style: TextStyle(color: AppColors.red)),
            TextSpan(text: 'u', style: TextStyle(color: AppColors.yellow)),
            TextSpan(text: 'e', style: TextStyle(color: AppColors.oliveGreen)),
            TextSpan(text: 'e', style: TextStyle(color: AppColors.pastelBlue)),
            TextSpan(text: 'r', style: TextStyle(color: AppColors.primary)),
            TextSpan(text: 'Hire'),
          ],
        ),
      ),
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
    );
  }
}

class CustomDrawer extends StatefulWidget {
  static String uid = '';

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> uid;

  void initState() {
    super.initState();
    uid = _prefs.then<String>((SharedPreferences prefs) {
      return Future.value(
          prefs.getString('uid') != null ? prefs.getString('uid') : '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //   ),
          //   child: Text(
          //     'Drawer Header',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 24,
          //     ),
          //   ),
          // ),
          FutureBuilder<String>(
            future: uid,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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

                              return Container(
                                height: 125,
                                child: DrawerHeader(
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      GoRouter.of(context).pushNamed('profile');
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 22,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            size: 25,
                                            Icons.person,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          snap.data!.docs[0]['name'],
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              //),
                              //   Container(
                              //   child: Row(
                              //     crossAxisAlignment:
                              //     CrossAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         'Hi, ',
                              //         style: TextStyle(
                              //
                              //         ),
                              //       ),
                              //       Text(
                              //         snap.data!.docs[0]['name'],
                              //         style: TextStyle(
                              //           color: AppColors.primary,
                              //           fontWeight: FontWeight.w600,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: 7,
                              //       ),
                              //       GestureDetector(
                              //         onTap: () async {
                              //           GoRouter.of(context).pushNamed('profile');
                              //         },
                              //         child: CircleAvatar(
                              //           radius: 22,
                              //           backgroundColor: AppColors.primary,
                              //           child: Icon(
                              //             Icons.person,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            })
                        : ListTile(
                            title: Text(
                                'Login or Register',
                              style: TextStyle(
                                color: AppColors.primary
                              ),
                            ),
                            onTap: () {
                              GoRouter.of(context).pushNamed('login');
                            },
                          );
                  }
              }
            },
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
    );
  }
}
