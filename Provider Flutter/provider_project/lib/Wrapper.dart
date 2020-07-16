
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/Screens/HomeScreen.dart';
import 'package:provider_project/Screens/LoginScreen.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null){

      return LoginScrenn();
    }
    return HomeScreen();
  }
}
