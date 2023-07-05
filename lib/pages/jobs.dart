import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/widgets/navbar.dart';
import '/widgets/jobCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
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
      appBar: (w! < 1080)
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text('QueerHire'),
            )
          : PreferredSize(child: NavBar(), preferredSize: Size.fromHeight(100)),
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
                'Applying for Jobs is Now Easy',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: w! / 30,
                    height: 1.1,
                    fontWeight: FontWeight.w600),
              ),
              Divider(
                height: 80,
              ),
              StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('jobs').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return new Text("There is no expense");
                    }
                    return GridView.builder(
                      scrollDirection: Axis.vertical, //important
                      shrinkWrap: true, //important
                      //padding: EdgeInsets.fromLTRB(60.0, 40.0, 24.0, 24.0),
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 60,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return JobCard(
                            jobId: snapshot.data!.docs[index]['jobId'],
                            company: snapshot.data!.docs[index]['companyName'],
                            description: snapshot.data!.docs[index]
                                ['description'],
                            role: snapshot.data!.docs[index]['roleAvailable'],
                            openings: snapshot.data!.docs[index]['openings']);
                      },
                    );

                  })
              // Divider(
              //   thickness: 2,
              //   height: 140,
              // ),
              // Text(
              //   'Recruiter? Hire From Us',
              //   style: TextStyle(
              //       color: Colors.grey[700],
              //       fontSize: w! / 30, height: 1.1, fontWeight: FontWeight.w600),
              // ),
              // SizedBox(height: 20),
              // Container(
              //   height: 40.0,
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //       overlayColor:  MaterialStateProperty.all(AppColors.primary.withOpacity(0.05)),
              //       elevation: MaterialStateProperty.all(0),
              //       backgroundColor: MaterialStateProperty.all(Colors.transparent),
              //       shape: MaterialStateProperty.all(
              //         RoundedRectangleBorder(
              //           side: BorderSide(color: AppColors.primary, width: 2),
              //           borderRadius: BorderRadius.circular(50),
              //         ),
              //       ),
              //     ),
              //
              //     onPressed: () {},
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //       child: Text(
              //         'HIRE NOW',
              //         style: TextStyle(
              //           fontSize: 20,
              //           color: AppColors.primary,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


//return Wrap(
//   spacing: 50,
//   runSpacing: 30,
//   children: [
//     JobCard(
//         company: 'KPMG',
//         description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget.',
//         role: 'Junior Consultant',
//         openings: 7),
//     JobCard(
//         company: 'KPMG',
//         description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget.',
//         role: 'Junior Consultant',
//         openings: 7),
//     JobCard(
//         company: 'KPMG',
//         description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget.',
//         role: 'Junior Consultant',
//         openings: 7),
//     JobCard(
//         company: 'KPMG',
//         description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget.',
//         role: 'Junior Consultant',
//         openings: 7),
//     JobCard(
//         company: 'KPMG',
//         description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget.',
//         role: 'Junior Consultant',
//         openings: 7),
//     JobCard(
//         company: 'KPMG',
//         description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget.',
//         role: 'Junior Consultant',
//         openings: 7),
//   ],
//
