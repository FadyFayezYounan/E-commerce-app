import 'package:flutter/material.dart';
import 'package:shop_app/pages/cart/cart_page.dart';
import 'package:shop_app/pages/favorites/favorites_page.dart';
import 'package:shop_app/pages/home/home_page.dart';
import 'package:shop_app/pages/log_in/login_page.dart';
import 'package:shop_app/pages/profile/profile_page.dart';
import 'package:shop_app/pages/search/search_page.dart';
import 'package:shop_app/pages/sign_up/sign_up_page.dart';

Map<String, WidgetBuilder> pageRoutes = {
  HomePage.routeName: (_) => HomePage(),
  SignUpPage.routeName: (_) => SignUpPage(),
  CartPage.routeName: (_) => CartPage(),
  FavoritesPage.routeName: (_) => FavoritesPage(),
  LogInPage.routeName: (_) => LogInPage(),
  ProfilePage.routeName: (_) => ProfilePage(),
  SearchPage.routeName : (_) => SearchPage(),
};
