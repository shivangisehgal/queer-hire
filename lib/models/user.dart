import 'dart:convert';

class UserModel {
  final String uid;
  final String? name;
  final String? email;
  final bool? isRecruiter;
UserModel({
  required this.uid,
  this.name,
  this.email,
  this.isRecruiter
});

// Map<String, dynamic> toMap() {
//   return {
//     'name': name,
//     'email': email,
//     'password': password,
//   };
// }
//
// factory User.fromMap(Map<String, dynamic> map) {
// return User(
// uid: map['_id'] ?? '',
// name: map['name'] ?? '',
// email: map['email'] ?? '',
// password: map['password'] ?? '',
// );
// }
//
// String toJson() => json.encode(toMap());
//
// factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
