import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:Signin/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Signin/database.dart';

class Authserve {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create custom user model from FirebaseUser

  InternalUser _userFromFirebaseUser(User user) {
    if (user == null) {
      return null;
    } else {
      return InternalUser(uid: user.uid);
    }
  }

  // auth change user stream
  Stream<InternalUser> get user {
    return _auth.onAuthStateChanged.map(
        //(User user)=>_userFromFirebaseUser(user)
        _userFromFirebaseUser);
  }

  // sign in anonymous
  Future anon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('the error starts here');
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password.
  Future login(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password.
  Future register(String name, String email, String password,
      String confirmpassword) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(name,email);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
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

  //forget password
  Future forgetpassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      print('didn\'t send resetemail');
    }
  }
}
