import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/auth_helper.dart';
import 'package:shop_app/local_storage/user_preferences.dart';
import 'package:shop_app/providers/user_provider.dart';

import 'home/home_page.dart';
import 'log_in/login_page.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthHelper.userId = UserPreferences.getUser().userId;
    print(AuthHelper.userId);
    return Consumer<UserProvider>(
      builder: (context , userProvider , child){
        print('${UserPreferences.getUser().userEmail}');
        if(UserPreferences.getUser().userName == 'NoUserName'){
          return LogInPage();
        }
        return HomePage();
      },
    );
  }
}

//import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/local_storage/user_preferences.dart';
// import 'package:shop_app/providers/user_provider.dart';
//
// import 'home/home_page.dart';
// import 'log_in/login_page.dart';
//
//
// class LandingPage extends StatelessWidget {
//   const LandingPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProvider>(
//       builder: (context , userProvider , child){
//         print('${UserPreferences.getUser()!.userEmail}');
//         if(userProvider.currentUser!.userName == 'placeHolderName'){
//           return LogInPage();
//         }
//         return HomePage();
//       },
//     );
//   }
// }



/////////////////////////////////////////////////////////////////////////////
//import 'package:flutter/material.dart';
// import 'package:shop_app/helpers/auth_helper.dart';
// import 'package:shop_app/pages/log_in/login_page.dart';
//
//
// class LandingPage extends StatelessWidget {
//   const LandingPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: AuthHelper.authStateChanges(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if(snapshot.connectionState == ConnectionState.waiting){
//           return Center(child: CircularProgressIndicator());
//         }
//         if(snapshot.hasData == true){
//           return LogInPage();//HomePage();
//         }
//         return LogInPage();
//       },
//
//     );
//   }
// }