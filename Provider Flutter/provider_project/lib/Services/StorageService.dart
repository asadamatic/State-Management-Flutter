import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageService{

  StorageService({@required this.uId});
  final String uId;

  Future<String> uploadAvatar({@required File file}) async{
    
    return await upload(
        uId: uId,
        file: file,
        path: FirestorePath.avatar(uId) + '/avatar.png',
        contentType: 'image/png');
  }
  
  Future<String> upload({
    @required String uId,
    @required File file,
    @required String path,
    @required String contentType}) async{

    final StorageReference imageReference = FirebaseStorage.instance.ref().child(path);
    final StorageUploadTask uploadTask = imageReference.putFile(file, StorageMetadata(contentType: contentType));
    final snapshot = await uploadTask.onComplete;
    if (snapshot.error != null) {
      print('upload error code: ${snapshot.error}');
      throw snapshot.error;
    }

    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('downloadUrl: $downloadUrl');
    return downloadUrl;
  }
}

class FirestorePath {
  static String avatar(String uid) => 'avatar/$uid';
}