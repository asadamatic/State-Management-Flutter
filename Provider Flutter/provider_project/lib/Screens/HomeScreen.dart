

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/Avatar.dart';
import 'package:provider_project/Model/AvatarReference.dart';
import 'package:provider_project/Services/FireStoreService.dart';
import 'package:provider_project/Services/ImagePickerService.dart';
import 'package:provider_project/Services/StorageService.dart';
import 'package:provider_project/Services/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // 1. Get image from picker
      final imagePicker =
      Provider.of<ImagePickerService>(context, listen: false);
      final file = await imagePicker.imagePicker(source: ImageSource.gallery);
      if (file != null) {
        // 2. Upload to storage
        final firebaseUser = Provider.of<FirebaseUser>(context, listen: false);
        final storage =
        Provider.of<StorageService>(context, listen: false);
        final downloadUrl = await storage.uploadAvatar(file: file);
        // 3. Save url to Firestore
        final database = Provider.of<FirestoreService>(context, listen: false);
        await database.setAvatarReference(uid: firebaseUser.uid, avatarReference: AvatarReference(downloadUrl));
        // 4. (optional) delete local file as no longer needed
        await file.delete();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            child: Text('Logout'),
            textColor: Colors.white,
            onPressed: () async{
              await AuthenticationService().logout();
            },
          ),
        ]
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Center(
              child: GestureDetector(
                onTap: () async{
                  await ImagePickerService().imagePicker(source: ImageSource.gallery);
                },
                child: _buildUserInfo(context: context),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildUserInfo({BuildContext context}) {
    final firebaseuser = Provider.of<FirebaseUser>(context, listen: false);
    final database = Provider.of<FirestoreService>(context,);
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(uid: firebaseuser.uid),
      builder: (context, snapshot) {
        final avatarReference = snapshot.data;
        return Avatar(
          photoUrl: avatarReference?.downloadUrl,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
          onPressed: () => _chooseAvatar(context),
        );
      },
    );
  }
}
