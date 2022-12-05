import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_staggered_grid_view.dart';
import 'package:shop_app/common_widgets/error_page.dart';
import 'package:shop_app/common_widgets/loading_page.dart';

import 'package:shop_app/providers/categories_provider.dart';


class MenPage extends StatelessWidget {
  const MenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future: Provider.of<CategoriesProvider>(context,listen: false).getWomenProducts(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        }
        if (snapshot.hasError == true) {
          return ErrorPage();
        }
        return Consumer<CategoriesProvider>(
            builder: (context, categoriesProvider, child) {
              var allMenProducts = categoriesProvider.menProducts;
              return Scaffold(
                body: AppStaggeredGridView(products: allMenProducts,productsIds: categoriesProvider.menProductIds,),
              );
            });
      },

    );
  }
}
