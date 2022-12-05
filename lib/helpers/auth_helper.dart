import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/local_storage/user_preferences.dart';

class AuthHelper{
  static final _firebaseAuth = FirebaseAuth.instance;
  static String? userId = UserPreferences.getUser().userId;//'7hHMIm7efIaUVqjXAMtAwua0JhL2';//FirebaseAuth.instance.currentUser!.uid;

  static Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  static Future<UserCredential> loginWithEmailAndPassword({required String email, required String password})async{
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<UserCredential> signUpWithEmailAndPassword({required String email, required String password})async{
    var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }


}