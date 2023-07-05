import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/job.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobApplicationForm extends StatefulWidget {
  late JobModel job;
  static String uid = '';
  JobApplicationForm({required this.job});

  //final String? jobId;

  @override
  _JobApplicationFormState createState() => _JobApplicationFormState();
}

class _JobApplicationFormState extends State<JobApplicationForm> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> uid;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _contactController = TextEditingController();
  final _genderController = TextEditingController();
  final _yoeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    uid = _prefs.then<String>((SharedPreferences prefs) {
      return Future.value(prefs.getString('uid') != null ? prefs.getString('uid') : '');
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _contactController.dispose();
    _genderController.dispose();
    _yoeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      JobApplication jobApplication = JobApplication(
        jobId: widget.job.jobId,
        uid: FirebaseAuth.instance.currentUser!.uid,
        name: _nameController.text,
        email: _emailController.text,
        age: int.parse(_ageController.text),
        contact: _contactController.text,
        gender: _genderController.text,
        yoe: int.parse(_yoeController.text),
      );

      FirebaseFirestore.instance
          .collection('applications')
          .add(jobApplication.toMap())
          .then((value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Job application submitted successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to submit job application. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //_nameController.text = FirebaseAuth.instance.currentUser!.displayName ?? '';
    _emailController.text = FirebaseAuth.instance.currentUser!.email ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Job Application'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Job Title: ${widget.job.roleAvailable} - ${widget.job.companyName}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Your ID: ${FirebaseAuth.instance.currentUser!.uid}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),

                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _contactController,
                  decoration: InputDecoration(labelText: 'Contact'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your contact';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Gender'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your gender';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _yoeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Years of Experience'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your years of experience';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Apply'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
