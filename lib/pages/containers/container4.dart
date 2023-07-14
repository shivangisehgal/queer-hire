import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/styles.dart';
import '/utils/constants.dart';
import '/widgets/jobCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Container4 extends StatefulWidget {
  const Container4({Key? key}) : super(key: key);

  @override
  State<Container4> createState() => _Container4State();
}

class _Container4State extends State<Container4> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){

          if(constraints.maxWidth < 840)
            return MobileContainer4();

          else if(constraints.maxWidth < 1320)
            return TabletContainer4();

          else
            return DesktopContainer4();
        }
    );
  }
}

class DesktopContainer4 extends StatefulWidget {
  const DesktopContainer4({Key? key}) : super(key: key);

  @override
  _DesktopContainer4State createState() => _DesktopContainer4State();
}

class _DesktopContainer4State extends State<DesktopContainer4> {
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

        width: double.infinity,

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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('jobs').limit(3).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text("There are no job listings available");
                }
                List<DocumentSnapshot> jobListings = snapshot.data!.docs;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: jobListings.map((doc) {
                    return JobCard(
                      jobId: doc['jobId'],
                      company: doc['companyName'],
                      description: doc['description'],
                      role: doc['roleAvailable'],
                      openings: doc['openings'],
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ));
  }
}



class TabletContainer4 extends StatefulWidget {
  const TabletContainer4({Key? key}) : super(key: key);

  @override
  State<TabletContainer4> createState() => _TabletContainer4State();
}

class _TabletContainer4State extends State<TabletContainer4> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1300,
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
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Popular Jobs',
            style: TextStyle(
              fontSize: 40,
              height: 1.1,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 50),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('jobs')
                .limit(3)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("There are no job listings available");
              }
              List<DocumentSnapshot> jobListings = snapshot.data!.docs;
              int itemCount = jobListings.length;

              if (itemCount == 0) {
                return Text("There are no job listings available");
              } else if (itemCount == 1) {
                return JobCard(
                  jobId: jobListings[0]['jobId'],
                  company: jobListings[0]['companyName'],
                  description: jobListings[0]['description'],
                  role: jobListings[0]['roleAvailable'],
                  openings: jobListings[0]['openings'],
                );
              } else {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: JobCard(
                            jobId: jobListings[0]['jobId'],
                            company: jobListings[0]['companyName'],
                            description: jobListings[0]['description'],
                            role: jobListings[0]['roleAvailable'],
                            openings: jobListings[0]['openings'],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: JobCard(
                            jobId: jobListings[1]['jobId'],
                            company: jobListings[1]['companyName'],
                            description: jobListings[1]['description'],
                            role: jobListings[1]['roleAvailable'],
                            openings: jobListings[1]['openings'],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    JobCard(
                      jobId: jobListings[2]['jobId'],
                      company: jobListings[2]['companyName'],
                      description: jobListings[2]['description'],
                      role: jobListings[2]['roleAvailable'],
                      openings: jobListings[2]['openings'],
                    ),
                  ],
                );
              }
            },
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}


class MobileContainer4 extends StatefulWidget {
  const MobileContainer4({Key? key}) : super(key: key);

  @override
  _MobileContainer4State createState() => _MobileContainer4State();
}

class _MobileContainer4State extends State<MobileContainer4> {
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
      height: 1800,
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

        width: double.infinity,

        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Popular Jobs',
              style: TextStyle(
                  fontSize: 35, height: 1.1, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 50),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('jobs').limit(3).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text("There are no job listings available");
                }
                else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                List<DocumentSnapshot> jobListings = snapshot.data!.docs;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: jobListings.map((doc) {
                    return JobCard(
                      jobId: doc['jobId'],
                      company: doc['companyName'],
                      description: doc['description'],
                      role: doc['roleAvailable'],
                      openings: doc['openings'],
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ));
  }
}
