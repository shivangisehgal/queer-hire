import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/user.dart';



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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      final SharedPreferences prefs = await _prefs;

      Future<String> _uid =
      prefs.setString('uid', user!.uid).then((bool success) {
        return user!.uid;
      });

      print(user.uid);

      return _userFromFirebaseUser(user);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(
      String email, String password, String name, bool isRecruiter) async {
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

    } catch (e) {
      print(e.toString());
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

  
}