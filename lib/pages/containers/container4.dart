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
  _Container4State createState() => _Container4State();
}

class _Container4State extends State<Container4> {
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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('jobs').limit(3).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text("There are no job listings available");
                }
                List<DocumentSnapshot> jobListings = snapshot.data!.docs;
                return Row(
                  children: jobListings.map((doc) {
                    return Expanded(
                      child: JobCard(
                        jobId: doc['jobId'],
                        company: doc['companyName'],
                        description: doc['description'],
                        role: doc['roleAvailable'],
                        openings: doc['openings'],
                      ),
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

