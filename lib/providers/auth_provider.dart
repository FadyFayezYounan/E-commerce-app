import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/helpers/auth_helper.dart';
import 'package:shop_app/helpers/firebase_helper.dart';
import 'package:shop_app/local_storage/user_preferences.dart';
import 'package:shop_app/modals/user_modal.dart';

class AuthProvider extends ChangeNotifier {
  // String errorMessage = 'An error occurred, please check your credentials';
  //
  // void _changeErrorMessageValue(String newValue){
  //   errorMessage = newValue;
  //   notifyListeners();
  // }


  bool loading = false;

  void _changeLoadingValue(bool newValue) {
    loading = newValue;
    notifyListeners();
  }

  Future<UserCredential> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    _changeLoadingValue(true);
    try {
      var userCredential = await AuthHelper.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModal userData = await FirebaseHelper.getUserData(userId: userCredential.user!.uid);
      // print(userData.userId);
      // print(userData.userEmail);
      // print(userData.userName);
      // print(userData.userPhone);
      UserPreferences.setUser(userData);

      _changeLoadingValue(false);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _changeLoadingValue(false);
      throw e;
    } catch (e) {
      _changeLoadingValue(false);
      throw e;
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    _changeLoadingValue(true);
    try {
      var userCredential = await AuthHelper.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveUserData(
        userId: userCredential.user!.uid,
        userName: name,
        userEmail: email,
        userPhone: phone,
      );
      UserModal userData = await FirebaseHelper.getUserData(userId: userCredential.user!.uid);
      // print(userData.userId);
      // print(userData.userEmail);
      // print(userData.userName);
      // print(userData.userPhone);
      UserPreferences.setUser(userData);
      _changeLoadingValue(false);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _changeLoadingValue(false);
      throw e;
    } catch (e) {
      _changeLoadingValue(false);
      throw e;
    }
  }
}

Future saveUserData({
  required String userId,
  required String userName,
  required String userEmail,
  required String userPhone,
}) async {
  UserModal userModal = UserModal(
    userId: userId,
    userName: userName,
    userEmail: userEmail,
    userPhone: userPhone,
  );
  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(userModal.toJson());
}
