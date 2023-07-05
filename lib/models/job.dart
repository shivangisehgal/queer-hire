import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  String jobId;
  String companyName;
  String description;
  int openings;
  String roleAvailable;

  JobModel({
    required this.jobId,
    required this.companyName,
    required this.description,
    required this.openings,
    required this.roleAvailable,
  });

  factory JobModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return JobModel(
      jobId: data['jobId'],
      companyName: data['companyName'],
      description: data['description'],
      openings: data['openings'],
      roleAvailable: data['roleAvailable'],
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'jobId': jobId,
  //     'companyName': companyName,
  //     'description': description,
  //     'openings': openings,
  //     'roleAvailable': roleAvailable,
  //   };
  //}
}

class JobApplication {
  final String jobId;
  final String uid;
  final String name;
  final String email;
  final int age;
  final String contact;
  final String gender;
  final int yoe;

  JobApplication({
    required this.jobId,
    required this.uid,
    required this.name,
    required this.email,
    required this.age,
    required this.contact,
    required this.gender,
    required this.yoe,
  });

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'uid': uid,
      'name': name,
      'email': email,
      'age': age,
      'contact': contact,
      'gender': gender,
      'yoe': yoe,
    };
  }

  factory JobApplication.fromMap(Map<String, dynamic> map) {
    return JobApplication(
      jobId: map['jobId'],
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      age: map['age'],
      contact: map['contact'],
      gender: map['gender'],
      yoe: map['yoe'],
    );
  }
}
