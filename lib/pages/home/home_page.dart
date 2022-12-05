




import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_icon_button.dart';
import 'package:shop_app/common_widgets/error_page.dart';
import 'package:shop_app/common_widgets/loading_page.dart';
import 'package:shop_app/helpers/auth_helper.dart';
import 'package:shop_app/local_storage/user_preferences.dart';
import 'package:shop_app/pages/admin_products/admin_products_page.dart';
import 'package:shop_app/pages/cart/cart_page.dart';
import 'package:shop_app/pages/categories/kids_page.dart';
import 'package:shop_app/pages/categories/men_page.dart';
import 'package:shop_app/pages/categories/teen_page.dart';
import 'package:shop_app/pages/categories/womenPage.dart';
import 'package:shop_app/pages/favorites/favorites_page.dart';
import 'package:shop_app/pages/log_in/login_page.dart';
import 'package:shop_app/pages/products/products_widget.dart';
import 'package:shop_app/pages/profile/profile_page.dart';
import 'package:shop_app/pages/search/search_page.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/providers/user_provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    return DefaultTabController(
      length: 5,
      child: FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .getAllProducts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          }
          if (snapshot.hasError == true) {
            return ErrorPage();
          }
          return Scaffold(
            body: NestedScrollView(
              //floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  //snap: true,
                  title: Text(
                    'Home Page',
                    style: TextStyle(
                      fontFamily: 'Pacifico-Regular',
                      color: appTheme.primaryColor,
                    ),
                  ),
                  centerTitle: false,
                  leading: AppIconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AdminProductsPage(),
                        ),
                      );
                    },
                    iconName: IconName.category,
                  ),
                  titleSpacing: 0.0,
                  actions: [
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) => AppIconButton(
                        onPressed: () {
                          AuthHelper.signOut();
                          //userProvider.changeCurrentUserValue(userModal: null);
                          UserPreferences.setUser(null);
                          Navigator.pushReplacementNamed(context, LogInPage.routeName);
                          Phoenix.rebirth(context);
                        },
                        iconName: IconName.notification,
                      ),
                    ),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'All',
                      ),
                      Tab(
                        text: 'Women',
                      ),
                      Tab(
                        text: 'Men',
                      ),
                      Tab(
                        text: 'Teen',
                      ),
                      Tab(
                        text: 'Kids',
                      ),
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                children: [
                  ProductsWidget(),
                  WomenPage(),
                  MenPage(),
                  TeenPage(),
                  KidsPage(),
                ],
              ),
            ),
            floatingActionButton: buildFloatingActionButton(context, appTheme),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: buildBottomAppBar(context, appTheme),
          );
        },
      ),
    );
  }

  Widget buildFloatingActionButton(
    BuildContext context,
    ThemeData appTheme,
  ) {
    return OpenContainer(
      closedShape: CircleBorder(),
      closedElevation: 6,
      closedColor: appTheme.primaryColor,
      closedBuilder: (context, _) => Container(
        width: 44.sp,
        height: 44.sp,
        alignment: Alignment.center,
        //padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: appTheme.primaryColor,
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: EdgeInsets.all(3.sp),
              child: AppIcon(
                iconName: IconName.buyStyle2,
                iconColor: Colors.white,
              ),
            ),
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) => CircleAvatar(
                radius: 6.sp,
                backgroundColor: Color(0xFFE57373),
                child: FittedBox(
                  child: Text(
                    '${cartProvider.cartItemsLength}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      openBuilder: (context, _) => CartPage(),
      transitionDuration: Duration(milliseconds: 650),
      //transitionType: ContainerTransitionType.fade,
    );
  }
}

BottomAppBar buildBottomAppBar(BuildContext context, ThemeData appTheme) {
  return BottomAppBar(
    shape: CircularNotchedRectangle(),
    color: appTheme.scaffoldBackgroundColor,
    notchMargin: 8,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppIconButton(
            onPressed: () {},
            iconName: IconName.homeStyle2,
            iconColor: appTheme.primaryColor,
          ),
          AppIconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            iconName: IconName.searchFilled,
            iconColor: appTheme.accentColor.withOpacity(0.5),
          ),
          AppIconButton(
            onPressed: null,
            iconName: IconName.heartFilled,
            iconColor: appTheme.scaffoldBackgroundColor,
          ),
          AppIconButton(
            onPressed: () {
              Navigator.pushNamed(context, FavoritesPage.routeName);
            },
            iconName: IconName.heartFilled,
            iconColor: appTheme.accentColor.withOpacity(0.5),
          ),
          AppIconButton(
            onPressed: () {
              Navigator.pushNamed(context, ProfilePage.routeName);
            },
            iconName: IconName.profileFilled,
            iconColor: appTheme.accentColor.withOpacity(0.5),
          ),
        ],
      ),
    ),
  );
}

//FloatingActionButton(
//         onPressed: () {
//           //Navigator.pushNamed(context, CartPage.routeName);
//         },
//         backgroundColor: appTheme.primaryColor,
//         child: Stack(
//           alignment: Alignment.topRight,
//           children: [
//             Padding(
//               padding: EdgeInsets.all(3.sp),
//               child: AppIcon(
//                 iconName: IconName.buyStyle2,
//                 iconColor: Colors.white,
//               ),
//             ),
//             Consumer<CartProvider>(
//               builder: (context, cartProvider, child) => CircleAvatar(
//                 radius: 6.sp,
//                 backgroundColor: Color(0xFFE57373),
//                 child: FittedBox(
//                   child: Text(
//                     '${cartProvider.cartItemsLength}',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 8.sp,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )



//import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/common_widgets/app_icon.dart';
// import 'package:shop_app/common_widgets/app_icon_button.dart';
// import 'package:shop_app/common_widgets/error_page.dart';
// import 'package:shop_app/common_widgets/loading_page.dart';
// import 'package:shop_app/helpers/auth_helper.dart';
// import 'package:shop_app/local_storage/user_preferences.dart';
// import 'package:shop_app/pages/admin_products/admin_products_page.dart';
// import 'package:shop_app/pages/cart/cart_page.dart';
// import 'package:shop_app/pages/categories/kids_page.dart';
// import 'package:shop_app/pages/categories/men_page.dart';
// import 'package:shop_app/pages/categories/teen_page.dart';
// import 'package:shop_app/pages/categories/womenPage.dart';
// import 'package:shop_app/pages/favorites/favorites_page.dart';
// import 'package:shop_app/pages/log_in/login_page.dart';
// import 'package:shop_app/pages/products/products_widget.dart';
// import 'package:shop_app/pages/profile/profile_page.dart';
// import 'package:shop_app/providers/bottom_nav_bar_provider.dart';
// import 'package:shop_app/providers/cart_provider.dart';
// import 'package:shop_app/providers/products_provider.dart';
// import 'package:shop_app/providers/user_provider.dart';
// import 'package:sizer/sizer.dart';
//
// class HomePage extends StatelessWidget {
//   static const routeName = '/home-page';
//
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var appTheme = Theme.of(context);
//     final bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context);
//     return DefaultTabController(
//       length: 5,
//       child: FutureBuilder(
//         future: Provider.of<ProductProvider>(context, listen: false)
//             .getAllProducts(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return LoadingPage();
//           }
//           if (snapshot.hasError == true) {
//             return ErrorPage();
//           }
//           return Scaffold(
//             body: NestedScrollView(
//               //floatHeaderSlivers: true,
//               headerSliverBuilder:
//                   (BuildContext context, bool innerBoxIsScrolled) => [
//                 SliverAppBar(
//                   floating: true,
//                   pinned: true,
//                   //snap: true,
//                   title: Text(
//                     'Home Page',
//                     style: TextStyle(
//                       fontFamily: 'Pacifico-Regular',
//                       color: appTheme.primaryColor,
//                     ),
//                   ),
//                   centerTitle: false,
//                   leading: AppIconButton(
//                     onPressed: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => AdminProductsPage(),
//                         ),
//                       );
//                     },
//                     iconName: IconName.category,
//                   ),
//                   titleSpacing: 0.0,
//                   actions: [
//                     Consumer<UserProvider>(
//                       builder: (context, userProvider, child) => AppIconButton(
//                         onPressed: () {
//                           AuthHelper.signOut();
//                           //userProvider.changeCurrentUserValue(userModal: null);
//                           UserPreferences.setUser(null);
//                           Navigator.pushReplacementNamed(context, LogInPage.routeName);
//                           Phoenix.rebirth(context);
//                         },
//                         iconName: IconName.notification,
//                       ),
//                     ),
//                   ],
//                   bottom: TabBar(
//                     isScrollable: true,
//                     tabs: [
//                       Tab(
//                         text: 'All',
//                       ),
//                       Tab(
//                         text: 'Women',
//                       ),
//                       Tab(
//                         text: 'Men',
//                       ),
//                       Tab(
//                         text: 'Teen',
//                       ),
//                       Tab(
//                         text: 'Kids',
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//               body: bottomNavBarProvider.pages[bottomNavBarProvider.currentIndex],
//             ),
//             floatingActionButton: buildFloatingActionButton(context, appTheme),
//             floatingActionButtonLocation:
//                 FloatingActionButtonLocation.centerDocked,
//             bottomNavigationBar: buildBottomAppBar(context, appTheme,bottomNavBarProvider),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget buildFloatingActionButton(
//     BuildContext context,
//     ThemeData appTheme,
//   ) {
//     return OpenContainer(
//       closedShape: CircleBorder(),
//       closedElevation: 6,
//       closedColor: appTheme.primaryColor,
//       closedBuilder: (context, _) => Container(
//         width: 44.sp,
//         height: 44.sp,
//         alignment: Alignment.center,
//         //padding: EdgeInsets.all(10.sp),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: appTheme.primaryColor,
//         ),
//         child: Stack(
//           alignment: Alignment.topRight,
//           children: [
//             Padding(
//               padding: EdgeInsets.all(3.sp),
//               child: AppIcon(
//                 iconName: IconName.buyStyle2,
//                 iconColor: Colors.white,
//               ),
//             ),
//             Consumer<CartProvider>(
//               builder: (context, cartProvider, child) => CircleAvatar(
//                 radius: 6.sp,
//                 backgroundColor: Color(0xFFE57373),
//                 child: FittedBox(
//                   child: Text(
//                     '${cartProvider.cartItemsLength}',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 8.sp,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       openBuilder: (context, _) => CartPage(),
//       transitionDuration: Duration(milliseconds: 650),
//       //transitionType: ContainerTransitionType.fade,
//     );
//   }
// }
//
// BottomAppBar buildBottomAppBar(BuildContext context, ThemeData appTheme , BottomNavBarProvider bottomNavBarProvider) {
//   return BottomAppBar(
//     shape: CircularNotchedRectangle(),
//     color: appTheme.scaffoldBackgroundColor,
//     notchMargin: 8,
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           AppIconButton(
//             onPressed: () {
//               bottomNavBarProvider.changeCurrentIndexValue(0);
//             },
//             iconName: IconName.homeStyle2,
//             iconColor: appTheme.primaryColor,
//           ),
//           AppIconButton(
//             onPressed: () {
//               bottomNavBarProvider.changeCurrentIndexValue(1);
//             },
//             iconName: IconName.searchFilled,
//             iconColor: appTheme.accentColor,
//           ),
//           AppIconButton(
//             onPressed: null,
//             iconName: IconName.heartFilled,
//             iconColor: appTheme.scaffoldBackgroundColor,
//           ),
//           AppIconButton(
//             onPressed: () {
//               //Navigator.pushNamed(context, FavoritesPage.routeName);
//               bottomNavBarProvider.changeCurrentIndexValue(2);
//             },
//             iconName: IconName.heartFilled,
//             iconColor: appTheme.accentColor,
//           ),
//           AppIconButton(
//             onPressed: () {
//               //Navigator.pushNamed(context, ProfilePage.routeName);
//               bottomNavBarProvider.changeCurrentIndexValue(3);
//             },
//             iconName: IconName.profileFilled,
//             iconColor: appTheme.accentColor,
//           ),
//         ],
//       ),
//     ),
//   );
// }