import 'package:cloud_firestore/cloud_firestore.dart';

class ScholarshipModel {
  String sid;
  String name;
  String description;
  String eligibility;

  ScholarshipModel({
    required this.sid,
    required this.name,
    required this.description,
    required this.eligibility,
  });

  factory ScholarshipModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ScholarshipModel(
      sid: data['sid'],
      name: data['name'],
      description: data['description'],
      eligibility: data['eligibility'],
    );
  }

}

class ScholarshipApplication {
  final String sid;
  final String uid;
  final String name;
  final String email;
  final int age;
  final String contact;
  final String gender;
  final String coverletter;

  ScholarshipApplication({
    required this.sid,
    required this.uid,
    required this.name,
    required this.email,
    required this.age,
    required this.contact,
    required this.gender,
    required this.coverletter,
  });

  Map<String, dynamic> toMap() {
    return {
      'sid': sid,
      'uid': uid,
      'name': name,
      'email': email,
      'age': age,
      'contact': contact,
      'gender': gender,
      'coverletter': coverletter,
    };
  }

  factory ScholarshipApplication.fromMap(Map<String, dynamic> map) {
    return ScholarshipApplication(
      sid: map['sid'],
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      age: map['age'],
      contact: map['contact'],
      gender: map['gender'],
      coverletter: map['coverletter'],
    );
  }
}
