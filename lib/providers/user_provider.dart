import 'package:flutter/foundation.dart';
import 'package:shop_app/local_storage/user_preferences.dart';

class UserProvider extends ChangeNotifier{


  bool iSDarkMode = UserPreferences.getDarkModeValue();

  void changeIsDarkModeValue(bool value)async{
    iSDarkMode = value;
    notifyListeners();
    await UserPreferences.setDarkMode(isDarkMode: value);
  }



  // UserModal? currentUser = UserPreferences.getUser();
  //
  //
  // void changeCurrentUserValue({UserModal? userModal}){
  //   UserPreferences.setUser(userModal);
  //   currentUser = userModal;
  //   notifyListeners();
  // }
}