import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_app_bar.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_icon_button.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';
import 'package:shop_app/common_widgets/empty_page_widget.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/pages/favorites/favorite_item_widget.dart';
import 'package:shop_app/providers/favorites_provider.dart';

class FavoritesPage extends StatelessWidget {
  static const routeName = '/favorites-page';

  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  buildAppBar(context: context,title: 'Favorites'),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) =>
            favoritesProvider.favoritesItemsLength != 0
                ? ListView.separated(
                    padding: EdgeInsets.all(KAppPadding),
                    physics: BouncingScrollPhysics(),
                    itemCount: favoritesProvider.favoritesItemsLength,
                    itemBuilder: (context, index) => FavoriteItemWidget(
                      favoriteProductModal:
                          favoritesProvider.getCartProducts[index],
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        AppHSizedBox(),
                  )
                : EmptyPageWidget(imageName: ImageName.noFavorites),
      ),
    );
  }
}
