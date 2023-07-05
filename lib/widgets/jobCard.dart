import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/styles.dart';
import '/utils/constants.dart';
import '/pages/job_app.dart';
import '/models/job.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobCard extends StatefulWidget {
  String company, description, role, jobId;
  int openings;

  JobCard(
      {required this.company,
        required this.jobId,
        required this.description,
        required this.role,
        required this.openings});

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 300,
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
                    width: 290,
                    child: Center(
                      child: Text(
                        this.widget.company,
                        style:
                        TextStyle(fontSize: w! / 40, color: Colors.white),
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
                'Roles Available',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                this.widget.role,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Number of Openings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '${widget.openings}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobApplicationForm(job: JobModel(jobId: widget.jobId, companyName: widget.company, description: widget.description, openings: widget.openings, roleAvailable: widget.role)),
                    ),
                  );
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

