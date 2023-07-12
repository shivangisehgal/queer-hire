import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/scholarship.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/constants.dart';
import '/utils/colors.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:flutter/material.dart';
//import 'package:path/path.dart';

import 'dart:typed_data';

class ScholarshipApplicationForm extends StatefulWidget {
  late ScholarshipModel scholarship;
  static String uid = '';
  ScholarshipApplicationForm({required this.scholarship});

  @override
  _ScholarshipApplicationFormState createState() =>
      _ScholarshipApplicationFormState();
}

class _ScholarshipApplicationFormState
    extends State<ScholarshipApplicationForm> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> uid;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _contactController = TextEditingController();
  final _genderController = TextEditingController();
  final _coverletterController = TextEditingController();

  late String filename;
  String coverLetterName = 'Cover Letter';
  bool isUploaded = false;

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List? file = result.files.single.bytes;

      File _file = new File(result.files.single.name);
      filename = _file.path.split('/').last;
      print(filename);
      fs.Reference storageRef =
          fs.FirebaseStorage.instance.ref().child('files/$filename');
      final fs.UploadTask uploadTask = storageRef.putData(file!);

      uploadTask.then((snapshot) {
        // File uploaded successfully
        print('File uploaded');
        setState(() {
          coverLetterName = filename;
          isUploaded = true;
        });
      }).catchError((error) {
        // Handle upload error
        print('Error uploading file: $error');
      });

    } else {
      // User canceled the picker
      // You can show snackbar or fluttertoast
      // here like this to show warning to user
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select file'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    uid = _prefs.then<String>((SharedPreferences prefs) {
      return Future.value(
          prefs.getString('uid') != null ? prefs.getString('uid') : '');
    });
    _fetchUserName();
  }

  void _fetchUserName() async {
    String currentUserUid = await uid;
    if (FirebaseAuth.instance.currentUser != null) {
      String userName = await getUserName(currentUserUid);
      setState(() {
        _nameController.text = userName;
        _emailController.text = FirebaseAuth.instance.currentUser!.email ?? '';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _contactController.dispose();
    _genderController.dispose();
    _coverletterController.dispose();
    super.dispose();
  }

  Future<String> getUserName(String uid) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: uid)
        .limit(1)
        .get();

    if (snapshot.size > 0) {
      final DocumentSnapshot document = snapshot.docs[0];
      final String userName = document['name'];
      return userName;
    } else {
      return 'null'; // or handle the case when the user with the provided UID does not exist
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if(isUploaded)
        {
          ScholarshipApplication scholarshipApplication = ScholarshipApplication(
            sid: widget.scholarship.sid,
            uid: FirebaseAuth.instance.currentUser!.uid,
            name: _nameController.text,
            email: _emailController.text,
            age: int.parse(_ageController.text),
            contact: _contactController.text,
            gender: _genderController.text,
            coverletter: _coverletterController.text,
          );

          FirebaseFirestore.instance
              .collection('scholarshipapply')
              .where('uid', isEqualTo: scholarshipApplication.uid)
              .where('sid', isEqualTo: scholarshipApplication.sid)
              .get()
              .then((QuerySnapshot querySnapshot) {
            if (querySnapshot.docs.isNotEmpty) {
              // Matching document found, update its data
              var docId = querySnapshot.docs.first.id;
              FirebaseFirestore.instance
                  .collection('scholarshipapply')
                  .doc(docId)
                  .update(scholarshipApplication.toMap())
                  .then((value) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Success'),
                      content: Text('Scholarship application updated successfully!'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            GoRouter.of(context).pushNamed('home');
                          },

                          child: Text('OK'),

                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.primary),
                          ),
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
                      content: Text(
                          'Failed to update scholarship application. Please try again.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.primary),
                          ),
                        ),
                      ],
                    );
                  },
                );
              });
            } else {
              // No matching document found, add a new document
              FirebaseFirestore.instance
                  .collection('scholarshipapply')
                  .add(scholarshipApplication.toMap())
                  .then((value) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Success'),
                      content: Text('Scholarship application submitted successfully!'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            GoRouter.of(context).pushNamed('home');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.primary),
                          ),
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
                      content: Text(
                          'Failed to submit scholarship application. Please try again.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.primary),
                          ),
                        ),
                      ],
                    );
                  },
                );
              });
            }
          });
        } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Upload Required'),
              content: Text('Please upload a file before submitting the form.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.primary),
                  ),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
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
        child: Container(
          // padding: EdgeInsets.only(top: h! * 0.2),
          child: SingleChildScrollView(
            child: Center(
              child: Card(
                elevation: 15,
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: w! * 0.5,
                  height: 700,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Apply For ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.scholarship.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   'Your ID: ${FirebaseAuth.instance.currentUser!.uid}',
                        //   style: TextStyle(
                        //       fontSize: 18, fontWeight: FontWeight.bold),
                        // ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            filled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
                          decoration: InputDecoration(
                            hintText: 'Age',
                            filled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your age';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _contactController,
                          decoration: InputDecoration(
                            hintText: 'Contact No.',
                            filled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your contact number';
                            }
                            // Regex pattern for phone number validation
                            final phoneRegex = RegExp(
                              r'(^(?:[+0]9)?[0-9]{10,12}$)',
                              caseSensitive: false,
                            );
                            if (!phoneRegex.hasMatch(value)) {
                              return 'Please enter a valid contact number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _genderController,
                          decoration: InputDecoration(
                            hintText: 'Gender',
                            filled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your gender';
                            }
                            return null;
                          },
                        ),

                        Row(
                          children: [

                            Expanded(
                              flex: 4,
                              child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, top: 10.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(coverLetterName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey.shade700
                                    ),
                                    ),
                                  ),
                                ),
                                onPressed: (){},
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(Colors.grey.shade100),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.grey.shade100),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                MaterialStateProperty.all(AppColors.primary),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    side: BorderSide(color: AppColors.primary),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              onPressed: getFile,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4),
                                child: Text(
                                  'Upload',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 18),
                                ),
                              ),
                            ),

                          ],
                        ),

                        SizedBox(height: 16),
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.primary),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: BorderSide(color: AppColors.primary),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          onPressed: () {
                            _submitForm();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
