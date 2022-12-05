import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_theme.dart';
import 'package:shop_app/local_storage/user_preferences.dart';
import 'package:shop_app/page_routes.dart';
import 'package:shop_app/pages/landing_page.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/providers/admin_product_provider.dart';
import 'package:shop_app/providers/bottom_nav_bar_provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/categories_provider.dart';
import 'package:shop_app/providers/favorites_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/providers/user_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: AdminProductProvider()),
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(
          value: CartProvider()
            ..fetchAndSetUserCartProducts(),
        ),
        ChangeNotifierProvider.value(
          value: FavoritesProvider()
            ..fetchAndSetUserFavoritesProducts(),
        ),
        ChangeNotifierProvider.value(
          value: CategoriesProvider()
            ..getWomenProducts()
            ..getMenProducts()
            ..getTeenProducts()
            ..getKidsProducts(),
        ),
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: BottomNavBarProvider()),
      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) =>
            Consumer<UserProvider>(
              builder: (context,userProvider, child)=>MaterialApp(
                title: 'Shop App',
                debugShowCheckedModeBanner: false,
                theme: userProvider.iSDarkMode == false ? AppTheme.lightTheme() : AppTheme.darkTheme(),
                home: LandingPage(),
                routes: pageRoutes,
                //builder: EasyLoading.init(),
              ),
            ),
      ),
    );
  }
}
