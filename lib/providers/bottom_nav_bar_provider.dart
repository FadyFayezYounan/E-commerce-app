import 'package:flutter/material.dart';
import 'package:shop_app/pages/categories/kids_page.dart';
import 'package:shop_app/pages/categories/men_page.dart';
import 'package:shop_app/pages/categories/teen_page.dart';
import 'package:shop_app/pages/categories/womenPage.dart';
import 'package:shop_app/pages/favorites/favorites_page.dart';
import 'package:shop_app/pages/products/products_widget.dart';
import 'package:shop_app/pages/profile/profile_page.dart';
import 'package:shop_app/pages/search/search_page.dart';

class BottomNavBarProvider extends ChangeNotifier{

  int currentIndex = 0;

  void changeCurrentIndexValue(int newValue){
    currentIndex = newValue;
    notifyListeners();
  }


  List<Widget> pages = [
    TabBarView(
      children: [
        ProductsWidget(),
        WomenPage(),
        MenPage(),
        TeenPage(),
        KidsPage(),
      ],
    ),
    SearchPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

}