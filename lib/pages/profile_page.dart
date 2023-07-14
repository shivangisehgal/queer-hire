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
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){

          if(constraints.maxWidth < 740)
            return MobileProfilePage();

          else if(constraints.maxWidth < 1100)
            return TabletProfilePage();

          else
            return DesktopProfilePage();
        }
    );
  }
}





class DesktopProfilePage extends StatefulWidget {
  const DesktopProfilePage({Key? key}) : super(key: key);

  @override
  _DesktopProfilePageState createState() => _DesktopProfilePageState();
}

class _DesktopProfilePageState extends State<DesktopProfilePage> {
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topLeft,
            begin: Alignment.bottomRight,
            colors: [
              Color(0xFFFDF7C3).withOpacity(0.75),
              Color(0xFFFFDEB4).withOpacity(0.75),
              Color(0XFFFFB4B4).withOpacity(0.75),
              Color(0xFFB2A4FF).withOpacity(0.75),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.only(top: h! * 0.2),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileCard(),
                        SizedBox(
                          height: 15,
                        ),
                        LogoutCard(),
                      ],
                    ),
                    MyJobApplications(),
                    MyScholarshipApplications(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class TabletProfilePage extends StatefulWidget {
  const TabletProfilePage({Key? key}) : super(key: key);

  @override
  State<TabletProfilePage> createState() => _TabletProfilePageState();
}

class _TabletProfilePageState extends State<TabletProfilePage> {
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topLeft,
            begin: Alignment.bottomRight,
            colors: [
              Color(0xFFFDF7C3).withOpacity(0.75),
              Color(0xFFFFDEB4).withOpacity(0.75),
              Color(0XFFFFB4B4).withOpacity(0.75),
              Color(0xFFB2A4FF).withOpacity(0.75),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.only(top: h! * 0.2),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    ProfileCard(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyJobApplicationsShort(),
                        MyScholarshipApplicationsShort(),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    LogoutCard(),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class MobileProfilePage extends StatefulWidget {
  const MobileProfilePage({Key? key}) : super(key: key);

  @override
  State<MobileProfilePage> createState() => _MobileProfilePageState();
}

class _MobileProfilePageState extends State<MobileProfilePage> {
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topLeft,
            begin: Alignment.bottomRight,
            colors: [
              Color(0xFFFDF7C3).withOpacity(0.75),
              Color(0xFFFFDEB4).withOpacity(0.75),
              Color(0XFFFFB4B4).withOpacity(0.75),
              Color(0xFFB2A4FF).withOpacity(0.75),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.only(top: h! * 0.2),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    ProfileCard(),
                    MyJobApplicationsShort(),
                    MyScholarshipApplicationsShort(),
                    SizedBox(
                      height: 40,
                    ),
                    LogoutCard(),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {

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
    return FutureBuilder<String>(
        future: uid,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot)
    {
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
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 100 / 2.0),
                        child: Container(
                          //replace this Container with your Card
                          height: 180.0,
                          width: 350.0,
                          child: Card(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                        border: Border.all(
                                          color: AppColors.primary,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(50))
                                    ),

                                    child: Text(
                                      snap.data!.docs[0]['name'].toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                      ),
                                    ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snap.data!.docs[0]['email'].toLowerCase(),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration:
                        ShapeDecoration(
                            shape: CircleBorder(), color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DecoratedBox(
                            decoration: ShapeDecoration(
                                shape: CircleBorder(),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(userProfile))),
                          ),
                        ),
                      )
                    ],
                  );
                }
            )
                : Text('No data');
          }
      }
    }
    );
  }
}


class LogoutCard extends StatefulWidget {
  const LogoutCard({Key? key}) : super(key: key);

  @override
  State<LogoutCard> createState() => _LogoutCardState();
}

class _LogoutCardState extends State<LogoutCard> {
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
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        backgroundColor:
        MaterialStateProperty.all(
            AppColors.primary),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(
              width: 4,
                color: Colors.white),
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
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'LOG OUT',
          style: TextStyle(
            fontSize: 26,
          ),
        ),
      ),
    );
    // return Container(
    //   width: 350.0,
    //   child: Card(
    //     elevation: 15,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(15),
    //     ),
    //     color: Colors.white,
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
    //       child: Container(
    //         width: 250,
    //         height: 45.0,
    //         child: ElevatedButton(
    //           style: ButtonStyle(
    //             elevation: MaterialStateProperty.all(0),
    //             backgroundColor:
    //             MaterialStateProperty.all(
    //                 AppColors.primary),
    //             shape: MaterialStateProperty.all(
    //               RoundedRectangleBorder(
    //                 side: BorderSide(
    //                     color: AppColors.primary),
    //                 borderRadius:
    //                 BorderRadius.circular(50),
    //               ),
    //             ),
    //           ),
    //           onPressed: () async {
    //             //print(snap.data!);
    //             AuthService _auth =
    //             AuthService();
    //             await _auth.signOut();
    //             final SharedPreferences
    //             prefs = await _prefs;
    //             Future<String> _logout =
    //             prefs
    //                 .setString(
    //                 'uid', '')
    //                 .then(
    //                     (bool success) {
    //                   return 'Log out success';
    //                 });
    //             print('Log out');
    //             GoRouter.of(context).pushNamed('home');
    //           },
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(
    //                 horizontal: 10.0),
    //             child: Text(
    //               'LOG OUT',
    //               style: TextStyle(
    //                 fontSize: 26,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}





class MyJobApplications extends StatefulWidget {
  const MyJobApplications({Key? key}) : super(key: key);

  @override
  State<MyJobApplications> createState() => _MyJobApplicationsState();
}

class _MyJobApplicationsState extends State<MyJobApplications> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100 / 2.0),
      child: Container(
        //replace this Container with your Card
        height: 500.0,
        width: 350.0,
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),

                  child: Center(
                    child: Text(
                      'My Job Applications',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
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
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                          children: [
                                            Text(
                                              'You haven\'t applied for any jobs yet :(',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade700
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                elevation: MaterialStateProperty.all(0),
                                                backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColors.primary),
                                                shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: AppColors.primary),
                                                    borderRadius: BorderRadius.circular(50),
                                                  ),
                                                ),
                                              ),
                                              onPressed: (){
                                                GoRouter.of(context).pushNamed('jobs');
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10.0, vertical: 4),
                                                child: Text(
                                                  'Apply',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ]
                                      ),
                                    ),
                                  );
                                }

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: jobs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      JobModel job = jobs[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            // side: BorderSide(
                                            //   color: AppColors.primary,
                                            // ),
                                          ),
                                          child: ListTile(
                                            title: Text(job.companyName),
                                            subtitle: Text(
                                                '${job.roleAvailable}: Applied',
                                              style: TextStyle(
                                                color: AppColors.primary
                                              ),
                                            ),
                                            // Display other job details here
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              })

                              : Text('No data');
                        }
                    }
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}



class MyJobApplicationsShort extends StatefulWidget {
  const MyJobApplicationsShort({Key? key}) : super(key: key);

  @override
  State<MyJobApplicationsShort> createState() => _MyJobApplicationsShortState();
}

class _MyJobApplicationsShortState extends State<MyJobApplicationsShort> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> uid;
  late bool _isExpanded = false; // Track expansion state

  @override
  void initState() {
    super.initState();
    uid = _prefs.then<String>((SharedPreferences prefs) {
      return Future.value(
          prefs.getString('uid') != null ? prefs.getString('uid') : '');
    });
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100 / 2.0),
      child: Container(
        height: _isExpanded ? 500.0 : 80.0, // Set initial and expanded height
        width: 360.0,
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded; // Toggle expansion state
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'My Job Applications',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                        ),
                        Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _isExpanded ? 380.0 : 0.0, // Set expanded height
                  child: _isExpanded
                      ? FutureBuilder<String>(
                    future: uid,
                    builder: (BuildContext context,
                        AsyncSnapshot<String> snapshot) {
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
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                            children: [
                                              Text(
                                                'You haven\'t applied for any jobs yet :(',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey.shade700
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  elevation: MaterialStateProperty.all(0),
                                                  backgroundColor:
                                                  MaterialStateProperty.all(
                                                      AppColors.primary),
                                                  shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: AppColors.primary),
                                                      borderRadius: BorderRadius.circular(50),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: (){
                                                  GoRouter.of(context).pushNamed('jobs');
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10.0, vertical: 4),
                                                  child: Text(
                                                    'Apply',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            ]
                                        ),
                                      ),
                                    );
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: jobs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        JobModel job = jobs[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
// side: BorderSide(
//   color: AppColors.primary,
// ),
                                            ),
                                            child: ListTile(
                                              title: Text(job.companyName),
                                              subtitle: Text(
                                                '${job.roleAvailable}: Applied',
                                                style: TextStyle(
                                                    color: AppColors.primary
                                                ),
                                              ),
// Display other job details here
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                })
                                : Text('No data');
                          }
                      }
                    },
                  )
                      : null, // Don't render contents when not expanded
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class MyScholarshipApplications extends StatefulWidget {
  const MyScholarshipApplications({Key? key}) : super(key: key);

  @override
  State<MyScholarshipApplications> createState() => _MyScholarshipApplicationsState();
}

class _MyScholarshipApplicationsState extends State<MyScholarshipApplications> {

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
          print('scholarship snapshot doesn\'t exist');
        }
      }

      yield scholarships;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100 / 2.0),
      child: Container(
        //replace this Container with your Card
        height: 500.0,
        width: 350.0,
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),

                  child: Center(
                    child: Text(
                      'My Scholarship Applications',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
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
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text(
                                            'You haven\'t applied to any scholarships yet :(',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade700
                                          ),
                                        ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              elevation: MaterialStateProperty.all(0),
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.primary),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: AppColors.primary),
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                              ),
                                            ),
                                            onPressed: (){
                                              GoRouter.of(context).pushNamed('scholarships');
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10.0, vertical: 4),
                                              child: Text(
                                                'Apply',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                      ]
                                      ),
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: scholarships.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ScholarshipModel scholarship =
                                    scholarships[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          // side: BorderSide(
                                          //   color: AppColors.primary,
                                          // ),
                                        ),
                                        child: ListTile(
                                          title: Text(scholarship.name),
                                          subtitle: Text(
                                              'Applied',
                                            style: TextStyle(
                                                color: AppColors.primary
                                            ),
                                          ),
                                          // Display other job details here
                                        ),
                                      ),
                                    );
                                  },
                                );
                              })
                              : Text('No data');
                        }
                    }
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyScholarshipApplicationsShort extends StatefulWidget {
  const MyScholarshipApplicationsShort({Key? key}) : super(key: key);

  @override
  State<MyScholarshipApplicationsShort> createState() => _MyScholarshipApplicationsShortState();
}

class _MyScholarshipApplicationsShortState extends State<MyScholarshipApplicationsShort> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> uid;
  late bool _isExpanded = false; // Track expansion state

  @override
  void initState() {
    super.initState();
    uid = _prefs.then<String>((SharedPreferences prefs) {
      return Future.value(
          prefs.getString('uid') != null ? prefs.getString('uid') : '');
    });
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
          print('scholarship snapshot doesn\'t exist');
        }
      }

      yield scholarships;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100 / 2.0),
      child: Container(
        height: _isExpanded ? 500.0 : 80.0, // Set initial and expanded height
        width: 360.0,
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded; // Toggle expansion state
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        border: Border.all(
                          color: AppColors.primary,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Row(
                      children: [
                        Text(
                          'My Scholarship Applications',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                        ),
                        Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _isExpanded ? 380.0 : 0.0, // Set expanded height
                  child: _isExpanded
                      ? FutureBuilder<String>(
                    future: uid,
                    builder: (BuildContext context,
                        AsyncSnapshot<String> snapshot) {
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
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                            children: [
                                              Text(
                                                'You haven\'t applied to any scholarships yet :(',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey.shade700
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  elevation: MaterialStateProperty.all(0),
                                                  backgroundColor:
                                                  MaterialStateProperty.all(
                                                      AppColors.primary),
                                                  shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: AppColors.primary),
                                                      borderRadius: BorderRadius.circular(50),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: (){
                                                  GoRouter.of(context).pushNamed('scholarships');
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10.0, vertical: 4),
                                                  child: Text(
                                                    'Apply',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            ]
                                        ),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: scholarships.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      ScholarshipModel scholarship =
                                      scholarships[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            // side: BorderSide(
                                            //   color: AppColors.primary,
                                            // ),
                                          ),
                                          child: ListTile(
                                            title: Text(scholarship.name),
                                            subtitle: Text(
                                              'Applied',
                                              style: TextStyle(
                                                  color: AppColors.primary
                                              ),
                                            ),
                                            // Display other job details here
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                })
                                : Text('No data');
                          }
                      }
                    },
                  )
                      : null, // Don't render contents when not expanded
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// class GoogleLoginButton extends StatefulWidget {
//   const GoogleLoginButton({Key? key}) : super(key: key);
//
//   @override
//   State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
// }
//
// class _GoogleLoginButtonState extends State<GoogleLoginButton> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(Colors.white),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             side: BorderSide(color: Colors.white),
//             borderRadius: BorderRadius.circular(50),
//           ),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundImage: NetworkImage(
//                   'data:image/png;base64,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'),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               'Sign in with Google',
//               style: TextStyle(fontSize: 16, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
