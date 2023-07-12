import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/user.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  //create user obj based on FirebaseUser
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }


  //sign in email and password
  Future signInWithEmailAndPassword(String email, String password, BuildContext context) async {


    try {

      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      final SharedPreferences prefs = await _prefs;

      Future<String> _uid = prefs.setString('uid', user!.uid).then((bool success) {
        return user!.uid;
      });

      print(user.uid);

      return _userFromFirebaseUser(user);

    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(
      String email, String password, String name, bool isRecruiter, BuildContext context) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      final SharedPreferences prefs = await _prefs;

      Future<String> _uid =
      prefs.setString('uid', user!.uid).then((bool success) {
        return user.uid;
      });
      //create info client
      await _createDataUser(email, user.uid, name, isRecruiter);

      return _userFromFirebaseUser(user);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      }
      showSnackBar(context, e.message!); // Displaying the error message
      return null;
    }
  }

  // Forgot password
  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, 'Password reset email sent. Please check your email.');
    } catch (e) {
      showSnackBar(context, 'Failed to send password reset email. Please try again.');
    }
  }

//  Future signInWithGoogle() async {
//    try{
//      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//      AuthCredential credential = GoogleAuthProvider.getCredential(
//        idToken: googleAuth.idToken,
//        accessToken: googleAuth.accessToken,
//      );
//
//      AuthResult result = await _auth.signInWithCredential(credential);
//      FirebaseUser user = result.user;
//
//      _updateDataUserGoogle(user.email, 'Your phone', user.uid, user.photoUrl, user.displayName);
//
//      return _userFromFirebaseUser(user);
//    }catch(e){
//      print(e.toString());
//      return null;
//    }
//  }

  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> _createDataUser(email, uid, name, isRecruiter) async {
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'id': uid,
      'name': name,
      'isRecruiter': isRecruiter
    });
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      return false;
    }
  }

  
}
