import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/modals/product_modal.dart';
import 'package:shop_app/pages/products/product_widget.dart';
import 'package:sizer/sizer.dart';

class AppStaggeredGridView extends StatelessWidget {
  final List<ProductModal> products;
  final List<String> productsIds;


  const AppStaggeredGridView({
    Key? key,
    required this.products,
    required this.productsIds,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      //shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(KAppPadding),
      crossAxisCount: SizerUtil.orientation == Orientation.portrait ? 2 : 4,
      itemCount: products.length,
      staggeredTileBuilder: (int index) =>
      //StaggeredTile.count(2, index.isEven ? 2 : 1.8),
      StaggeredTile.fit(1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 16.0,
      itemBuilder: (BuildContext context, int index){

        return ProductWidget(
          product: products[index],
          productId: productsIds[index],
          key: ValueKey(productsIds[index]),
        );
      },
    );
  }
}
