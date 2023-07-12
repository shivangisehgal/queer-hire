import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '/widgets/bottomAppBar.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import '/widgets/navbar.dart';
import '/widgets/scholarshipCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScholarshipsPage extends StatefulWidget {
  const ScholarshipsPage({Key? key}) : super(key: key);

  @override
  _ScholarshipsPageState createState() => _ScholarshipsPageState();
}

class _ScholarshipsPageState extends State<ScholarshipsPage> {
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
      extendBodyBehindAppBar: true,
      appBar: (w! < 1080) ? AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('QueerHire'),
      ) : PreferredSize(child: NavBar(), preferredSize: Size.fromHeight(100)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: h! * 0.2),
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
          child: Column(
            children: [
              Text(
                'World\'s Most Inclusive Scholarships',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: w! / 30, height: 1.1, fontWeight: FontWeight.w600),
              ),
              Center(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('scholarships').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Text("There are no scholarships available");
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: (snapshot.data!.docs.length / 3).ceil(),
                      itemBuilder: (context, rowIndex) {
                        int startIndex = rowIndex * 3;
                        int endIndex = startIndex + 3;
                        if (endIndex > snapshot.data!.docs.length) {
                          endIndex = snapshot.data!.docs.length;
                        }
                        List<DocumentSnapshot> rowItems =
                        snapshot.data!.docs.sublist(startIndex, endIndex);
                        return Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: rowItems.map((doc) {
                            return ScholarshipCard(
                              sid: doc['sid'],
                              name: doc['name'],
                              description: doc['description'],
                              eligibility: doc['eligibility'],
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),
              ),

              Divider(
                thickness: 2,
                height: 140,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
