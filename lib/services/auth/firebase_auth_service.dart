// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser?> getCurrentUser() {
    return _auth.currentUser();
  }

  signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  restPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  signOut() async {
    await _auth.signOut();
  }
}
