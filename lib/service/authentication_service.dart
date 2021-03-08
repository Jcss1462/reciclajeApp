import 'package:firebase_auth/firebase_auth.dart';

class AutenticationService {
  final FirebaseAuth _firebaseAuth;

  AutenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> singIn({String email, String password}) async {
    
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
  }

  Future<String> singUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> singOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void>  sendEmailVerification() async {
    await _firebaseAuth.currentUser.sendEmailVerification();
  }
  
  
}
