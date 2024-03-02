// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String firstName;
  String lastName;
  String email;
  String? password;
  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      "password": password
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
        id: snapshot.documentID,
        firstName: snapshot['firstName'] ?? '',
        lastName: snapshot['lastName'] ?? '',
        email: snapshot['email'],
        password: snapshot['password']);
  }
}
