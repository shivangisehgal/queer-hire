import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';
import 'package:go_router/go_router.dart';
import '/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/job.dart';
import '/models/scholarship.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> uid;

  @override
  void initState() {
    super.initState();
    uid = _prefs.then<String>((SharedPreferences prefs) {
      return Future.value(
          prefs.getString('uid') != null ? prefs.getString('uid') : '');
    });
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            //padding: EdgeInsets.only(top: h! * 0.2),
            child: Center(
              child: Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: w! * 0.7,
                  height: 700,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      // Expanded(
                      //   child: ProfileSide(),
                      // ),
                      Expanded(
                        flex: 2,
                        child: MyApplications(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileSide extends StatefulWidget {
  const ProfileSide({Key? key}) : super(key: key);

  @override
  State<ProfileSide> createState() => _ProfileSideState();
}

class _ProfileSideState extends State<ProfileSide> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> uid;

  @override
  void initState() {
    super.initState();
    uid = _prefs.then<String>((SharedPreferences prefs) {
      return Future.value(
          prefs.getString('uid') != null ? prefs.getString('uid') : '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 18.0, top: 25),
        child: FutureBuilder<String>(
          future: uid,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
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

                            return Column(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 15),
                                    // CircleAvatar(
                                    //   radius: 70,
                                    //   child: Image.network(
                                    //       'assets/images/profile-pride.png'),
                                    // ),
                                    SizedBox(height: 45),
                                    Text(
                                      "Hello,",
                                      style: TextStyle(
                                        fontSize: 13,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      snap.data!.docs[0]['name'].toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        height: 1.2,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 42,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    Text(
                                      snap.data!.docs[0]['email'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        letterSpacing: 1.1,
                                        //color:
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.primary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: AppColors.primary),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      print(snap.data!);
                                      AuthService _auth =
                                      AuthService();
                                      await _auth.signOut();
                                      final SharedPreferences
                                      prefs = await _prefs;
                                      Future<String> _logout =
                                      prefs
                                          .setString(
                                          'uid', '')
                                          .then(
                                              (bool success) {
                                            return 'Log out success';
                                          });
                                      print('Log out');
                                      GoRouter.of(context).pushNamed('home');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        'LOG OUT',
                                        style: TextStyle(
                                          fontSize: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          })
                      : Text('No data');
                }
            }
          },
        ),

        //   SizedBox(height: 15),
        //   // SizedBox(
        //   //   width: 230,
        //   //   child: GoogleLoginButton(),
        //   // ),
        //   // SizedBox(height: 20),

        //   // SizedBox(height: 5),
        //   // TextFormField(
        //   //   controller: emailController,
        //   //   validator: (value) {
        //   //     if (value == null || value.isEmpty) {
        //   //       return 'Please enter your email';
        //   //     }
        //   //     return null;
        //   //   },
        //   //   decoration: InputDecoration(
        //   //     hintText: 'Email',
        //   //     filled: true,
        //   //     contentPadding:
        //   //         const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        //   //     focusedBorder: OutlineInputBorder(
        //   //       borderSide: BorderSide(color: Colors.grey.shade100),
        //   //       borderRadius: BorderRadius.circular(10),
        //   //     ),
        //   //     enabledBorder: OutlineInputBorder(
        //   //       borderSide: BorderSide(color: Colors.grey.shade100),
        //   //       borderRadius: BorderRadius.circular(10),
        //   //     ),
        //   //   ),
        //   // ),
        //   // SizedBox(height: 10),
        //   // TextFormField(
        //   //   controller: passwordController,
        //   //   obscureText: true,
        //   //   validator: (value) {
        //   //     if (value == null || value.isEmpty) {
        //   //       return 'Please enter your password';
        //   //     }
        //   //     return null;
        //   //   },
        //   //   decoration: InputDecoration(
        //   //     hintText: 'Password',
        //   //     filled: true,
        //   //     contentPadding:
        //   //         const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        //   //     focusedBorder: OutlineInputBorder(
        //   //       borderSide: BorderSide(color: Colors.grey.shade100),
        //   //       borderRadius: BorderRadius.circular(10),
        //   //     ),
        //   //     enabledBorder: OutlineInputBorder(
        //   //       borderSide: BorderSide(color: Colors.grey.shade100),
        //   //       borderRadius: BorderRadius.circular(10),
        //   //     ),
        //   //   ),
        //   // ),
        //   // SizedBox(height: 20),
        //   // Text(
        //   //   'Forgot Password?',
        //   //   style: TextStyle(
        //   //     letterSpacing: 1.1,
        //   //     fontSize: 12,
        //   //   ),
        //   // ),
        //   // SizedBox(height: 5),
        //   // ElevatedButton(
        //   //   style: ButtonStyle(
        //   //     elevation: MaterialStateProperty.all(0),
        //   //     backgroundColor: MaterialStateProperty.all(AppColors.primary),
        //   //     shape: MaterialStateProperty.all(
        //   //       RoundedRectangleBorder(
        //   //         side: BorderSide(color: AppColors.primary),
        //   //         borderRadius: BorderRadius.circular(50),
        //   //       ),
        //   //     ),
        //   //   ),
        //   //   onPressed: () async {
        //   //     await _auth
        //   //         .signInWithEmailAndPassword(
        //   //             emailController.text, passwordController.text)
        //   //         .then((result) {
        //   //       GoRouter.of(context).pushNamed('home');
        //   //       print(result.name);
        //   //     }).catchError((error) {
        //   //       print('Registration Error: $error');
        //   //     });
        //   //   },
        //   //   // setState(() {
        //   //   //   _isRegistering = false;
        //   //   //   _isEditingEmail = false;
        //   //   // });
        //   //   child: Padding(
        //   //     padding:
        //   //         const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        //   //     child: Text(
        //   //       'Log in',
        //   //       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        //   //     ),
        //   //   ),
        //   //),
        // ],
        //),
      ),
    );
  }
}

class MyApplications extends StatefulWidget {
  const MyApplications({Key? key}) : super(key: key);

  @override
  State<MyApplications> createState() => _MyApplicationsState();
}

class _MyApplicationsState extends State<MyApplications> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> uid;
  //late Stream<List<JobModel>> jobAppStream;

  @override
  void initState() {
    super.initState();
    uid = _prefs.then<String>((SharedPreferences prefs) {
      return Future.value(
          prefs.getString('uid') != null ? prefs.getString('uid') : '');
    });

    //jobAppStream = _getjobAppStream();
  }

  Stream<List<JobModel>> _getjobAppStream(Future<String> uidFuture) async* {
    String uid = await uidFuture;
    Stream<QuerySnapshot> applicationsSnapshot = FirebaseFirestore.instance
        .collection('applications')
        .where('uid', isEqualTo: uid)
        .snapshots();

    await for (QuerySnapshot snapshot in applicationsSnapshot) {
      List<JobModel> jobs = [];
      for (DocumentSnapshot applicationSnapshot in snapshot.docs) {
        String? jobId =
            (applicationSnapshot.data() as Map<String, dynamic>)['jobId'];
        print(jobId);

        QuerySnapshot jobSnapshot = await FirebaseFirestore.instance
            .collection('jobs')
            .where('jobId', isEqualTo: jobId)
            .get();

        if (jobSnapshot.docs[0].exists) {
          JobModel job = JobModel.fromSnapshot(jobSnapshot.docs[0]);
          print('printing jobid');
          print(job.jobId);
          jobs.add(job);
        } else {
          print('job snapshot doesnt exist');
        }
      }

      yield jobs;
    }
  }

  Stream<List<ScholarshipModel>> _getScholarshipAppStream(
      Future<String> uidFuture) async* {
    String uid = await uidFuture;
    Stream<QuerySnapshot> scholarAppsSnapshot = FirebaseFirestore.instance
        .collection('scholarshipapply')
        .where('uid', isEqualTo: uid)
        .snapshots();

    await for (QuerySnapshot snapshot in scholarAppsSnapshot) {
      List<ScholarshipModel> scholarships = [];
      for (DocumentSnapshot scholarAppsSnapshot in snapshot.docs) {
        String? sid =
            (scholarAppsSnapshot.data() as Map<String, dynamic>)['sid'];
        print(sid);

        QuerySnapshot scholarshipSnapshot = await FirebaseFirestore.instance
            .collection('scholarships')
            .where('sid', isEqualTo: sid)
            .get();

        if (scholarshipSnapshot.docs[0].exists) {
          ScholarshipModel scholarship =
              ScholarshipModel.fromSnapshot(scholarshipSnapshot.docs[0]);
          print('printing sid');
          print(scholarship.sid);
          scholarships.add(scholarship);
        } else {
          print('scholarship snapshot doesnt exist');
        }
      }

      yield scholarships;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)),
        // gradient: LinearGradient(
        //   end: Alignment.topLeft,
        //   begin: Alignment.bottomRight,
        //   colors: [
        //     //Color(0xFFFDF7C3),
        //     Color(0xFFFFDEB4).withOpacity(0.75),
        //     Color(0XFFFFB4B4).withOpacity(0.75),
        //     Color(0xFFB2A4FF).withOpacity(0.75),
        //   ],
        // ),
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            FutureBuilder<String>(
              future: uid,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
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

                            return Column(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Hello, ",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                        Text(
                                          snap.data!.docs[0]['name'].toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            //height: 1.2,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                      ],
                                    ),
                                //     Text(
                                //       snap.data!.docs[0]['email'],
                                //       style: TextStyle(
                                //         fontSize: 13,
                                //         letterSpacing: 1.1,
                                //         //color:
                                //       ),
                                //     ),
                                  ],
                                ),
                                SizedBox(height: 30),

                              ],
                            );
                          })
                          : Text('No data');
                    }
                }
              },
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Divider(
                height: 1.2,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Track your applications here!',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: w! * 0.4,
                  child: Divider(
                    color: AppColors.primary.withOpacity(0.5),
                    thickness: 1.5,
                    height: 1.2,
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            Text(
              'Your Job Applications',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 1.2,
              ),
            ),

            Container(
              width: w! * 0.6,
              child: FutureBuilder<String>(
                future: uid,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container();
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return snapshot.data != ''
                            ? StreamBuilder<List<JobModel>>(
                                stream: _getjobAppStream(uid),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<JobModel>> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }

                                  List<JobModel> jobs = snapshot.data ?? [];

                                  if (jobs.isEmpty) {
                                    return Text('No applications found.');
                                  }

                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: jobs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      JobModel job = jobs[index];
                                      return Container(
                                        height: 40.0,

                                        child: ElevatedButton(

                                          style: ButtonStyle(
                                            overlayColor:
                                            MaterialStateProperty.all(AppColors.primary.withOpacity(0.25)),
                                            elevation: MaterialStateProperty.all(0),
                                            backgroundColor: MaterialStateProperty.all(AppColors.primary),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                side: BorderSide(color: AppColors.primary, width: 1),
                                                borderRadius: BorderRadius.circular(50),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Text(
                                              job.companyName,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );

                                      // ListTile(
                                      //   title: Text(job.companyName),
                                      //   // Display other job details here
                                      // );
                                    },
                                  );
                                })
                            //   return Column(
                            //     children: [
                            //       // CircleAvatar(
                            //       //   child: Image.network(
                            //       //       'assets/images/profile-pride.png'),
                            //       // ),
                            //       // SizedBox(height: 15),
                            //       Text(
                            //         snap.data!.docs[0]['name'],
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 30,
                            //           letterSpacing: 1.2,
                            //         ),
                            //       ),
                            //       Text(
                            //         snap.data!.docs[0]['name'],
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 30,
                            //           letterSpacing: 1.2,
                            //         ),
                            //       ),
                            //       Text(
                            //         snap.data!.docs[0]['email'],
                            //         style: TextStyle(
                            //           fontSize: 12,
                            //           letterSpacing: 1.1,
                            //         ),
                            //       ),
                            //     ],
                            //   );
                            // })
                            : Text('No data');
                      }
                  }
                },
              ),
            ),

            Text(
              'Your Scholarships Applications',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 1.2,
              ),
            ),

            FutureBuilder<String>(
              future: uid,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return snapshot.data != ''
                          ? StreamBuilder<List<ScholarshipModel>>(
                              stream: _getScholarshipAppStream(uid),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<ScholarshipModel>>
                                      snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }

                                List<ScholarshipModel> scholarships =
                                    snapshot.data ?? [];

                                if (scholarships.isEmpty) {
                                  return Text(
                                      'No shcolarship applications found.');
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: scholarships.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ScholarshipModel scholarship =
                                        scholarships[index];
                                    return ListTile(
                                      title: Text(scholarship.name),
                                      // Display other job details here
                                    );
                                  },
                                );
                              })
                          //   return Column(
                          //     children: [
                          //       // CircleAvatar(
                          //       //   child: Image.network(
                          //       //       'assets/images/profile-pride.png'),
                          //       // ),
                          //       // SizedBox(height: 15),
                          //       Text(
                          //         snap.data!.docs[0]['name'],
                          //         style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 30,
                          //           letterSpacing: 1.2,
                          //         ),
                          //       ),
                          //       Text(
                          //         snap.data!.docs[0]['name'],
                          //         style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 30,
                          //           letterSpacing: 1.2,
                          //         ),
                          //       ),
                          //       Text(
                          //         snap.data!.docs[0]['email'],
                          //         style: TextStyle(
                          //           fontSize: 12,
                          //           letterSpacing: 1.1,
                          //         ),
                          //       ),
                          //     ],
                          //   );
                          // })
                          : Text('No data');
                    }
                }
              },
            ),

            Container(
              width: 300,
              height: 60.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                  MaterialStateProperty.all(
                      AppColors.primary),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(
                          color: AppColors.primary),
                      borderRadius:
                      BorderRadius.circular(50),
                    ),
                  ),
                ),
                onPressed: () async {
                  //print(snap.data!);
                  AuthService _auth =
                  AuthService();
                  await _auth.signOut();
                  final SharedPreferences
                  prefs = await _prefs;
                  Future<String> _logout =
                  prefs
                      .setString(
                      'uid', '')
                      .then(
                          (bool success) {
                        return 'Log out success';
                      });
                  print('Log out');
                  GoRouter.of(context).pushNamed('home');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0),
                  child: Text(
                    'LOG OUT',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
            )

            // Text(
            //   'New to QueerHire?',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 18,
            //     letterSpacing: 1.2,
            //   ),
            // ),
            // SizedBox(
            //   height: 40.0,
            // ),
            // TextButton(
            //   style: ButtonStyle(
            //     overlayColor:
            //         MaterialStateProperty.all(Colors.white.withOpacity(0.05)),
            //     elevation: MaterialStateProperty.all(0),
            //     //backgroundColor: MaterialStateProperty.all(Colors.white),
            //     shape: MaterialStateProperty.all(
            //       RoundedRectangleBorder(
            //         side: BorderSide(color: Colors.white, width: 2),
            //         borderRadius: BorderRadius.circular(40),
            //       ),
            //     ),
            //   ),
            //   onPressed: () {
            //     GoRouter.of(context).pushNamed('register');
            //   },
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            //     child: Text(
            //       'REGISTER',
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 25.0,
            // ),
            // TextButton(
            //   style: ButtonStyle(
            //     overlayColor:
            //         MaterialStateProperty.all(Colors.white.withOpacity(0.05)),
            //     elevation: MaterialStateProperty.all(0),
            //     //backgroundColor: MaterialStateProperty.all(Colors.white),
            //     shape: MaterialStateProperty.all(
            //       RoundedRectangleBorder(
            //         side: BorderSide(color: Colors.white, width: 2),
            //         borderRadius: BorderRadius.circular(40),
            //       ),
            //     ),
            //   ),
            //   onPressed: () {
            //     GoRouter.of(context).pushNamed('home');
            //   },
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            //     child: Text(
            //       'RETURN HOME',
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 40.0,
            // ),
          ],
        ),
      ),
    );
  }
}

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({Key? key}) : super(key: key);

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'data:image/png;base64,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'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Sign in with Google',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
