import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qh_project/models/scholarship.dart';
import 'package:qh_project/pages/scholarships_app.dart';
import '/utils/colors.dart';
import '/utils/styles.dart';
import '/utils/constants.dart';
import 'package:go_router/go_router.dart';

class ScholarshipCard extends StatefulWidget {
  String name, description, eligibility, sid;
  ScholarshipCard(
      { required this.sid,
        required this.name,
        required this.description,
        required this.eligibility});

  @override
  State<ScholarshipCard> createState() => _ScholarshipCardState();
}

class _ScholarshipCardState extends State<ScholarshipCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 470,
      width: 400,
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Card(
                color: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: 280,
                    child: Center(
                      child: Text(
                        this.widget.name,
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(fontSize: w! / 50, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                this.widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Eligibility',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                this.widget.eligibility,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 60),
              ElevatedButton(
                style: AppButtonStyle,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'APPLY',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  if(FirebaseAuth.instance.currentUser == null)
                    {
                      GoRouter.of(context).pushNamed('login');
                    }
                  else
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScholarshipApplicationForm(scholarship: ScholarshipModel(sid: widget.sid, name: widget.name, description: widget.description, eligibility: widget.eligibility)),
                        ),
                      );
                    }
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
