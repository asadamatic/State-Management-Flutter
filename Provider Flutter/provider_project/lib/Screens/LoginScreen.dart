


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_project/Services/firebase_auth.dart';

class LoginScrenn extends StatefulWidget {


  @override
  _LoginScrennState createState() => _LoginScrennState();
}

class _LoginScrennState extends State<LoginScrenn> {

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: isLoading? CircularProgressIndicator() : FlatButton(
          child: Text('Sign In Anonymously'),
          onPressed: () async{
            setState(() {
              isLoading = true;
            });
            final firebaseUser = await AuthenticationService().anonSignIn();

            if (firebaseUser == null){
              setState(() {
                isLoading = false;
              });
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Unable to login :('),));
            }
          },
        ),
      ),
    );
  }
}
