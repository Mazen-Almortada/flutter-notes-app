// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_private_notes/strings/app_strings.dart';

import '../../model/user_model.dart';
import '../../utils/encrypt_decrypt_utils.dart';

class FirestoreUsersService {
  final Firestore _firestore = Firestore.instance;

  getUserInfo(FirebaseUser user) async {
    final DocumentSnapshot documentSnapshot = await _firestore
        .collection(usersCollectionName)
        .document(user.uid)
        .get();
    UserModel userModel = UserModel.fromSnapshot(documentSnapshot);

    return userModel;
  }

  setUserInfo(UserModel userModel, FirebaseUser user) async {
    userModel.password =
        Crypto.encryptText(userModel.password!, userModel.email);
    await _firestore
        .collection(usersCollectionName)
        .document(user.uid)
        .setData(userModel.toMap());
  }

  updateUserInfo(UserModel userModel, FirebaseUser user) async {
    await _firestore
        .collection(usersCollectionName)
        .document(user.uid)
        .updateData(userModel.toMap());
  }
}
