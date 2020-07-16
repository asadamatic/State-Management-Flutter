

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{

  final firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser>  anonSignIn() async {

    final authResult = await firebaseAuth.signInAnonymously();
    return authResult.user;
  }

  Stream<FirebaseUser> get authSate {

    return firebaseAuth.onAuthStateChanged;
  }

  Future<void> logout(){

    return firebaseAuth.signOut();
  }
}