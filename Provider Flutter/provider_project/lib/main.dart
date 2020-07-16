import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/Services/FireStoreService.dart';
import 'package:provider_project/Services/ImagePickerService.dart';
import 'package:provider_project/Services/StorageService.dart';
import 'package:provider_project/Services/firebase_auth.dart';
import 'package:provider_project/Wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          StreamProvider<FirebaseUser>.value(value: AuthenticationService().authSate),
        ],
      child: Wrapper(),
      )
    );
  }
}
