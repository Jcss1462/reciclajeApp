import 'package:firebase_auth/firebase_auth.dart';

class AutenticationService {
  final FirebaseAuth _firebaseAuth;

  AutenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> singIn({String email, String password}) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> singUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> singOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    await _firebaseAuth.currentUser.sendEmailVerification();
  }

  Future<void> restablecerPassword({String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
