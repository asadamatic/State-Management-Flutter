
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provider_project/Model/AvatarReference.dart';
import 'package:provider_project/Services/StorageService.dart';

class FirestoreService {
  FirestoreService({@required this.uid});
  final String uid;

  // Sets the avatar download url
  Future<void> setAvatarReference( {@required String uid, @required AvatarReference avatarReference}) async {
    final path = FirestorePath.avatar(uid);
    final reference = Firestore.instance.document(path);
    await reference.setData(avatarReference.toMap());
  }

  // Reads the current avatar download url
  Stream<AvatarReference> avatarReferenceStream({ @required String uid,}) {
    final path = FirestorePath.avatar(uid);
    final reference = Firestore.instance.document(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => AvatarReference.fromMap(snapshot.data));
  }
}