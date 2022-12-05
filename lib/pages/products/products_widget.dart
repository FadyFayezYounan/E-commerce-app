
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/products/product_widget.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:sizer/sizer.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          Provider.of<ProductProvider>(context, listen: false).getAllProducts(),
      child:
      Consumer<ProductProvider>(builder: (context, productProvider, child) {
        var allProducts = productProvider.allProducts;
        return Scaffold(
          body: StaggeredGridView.countBuilder(
            //shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16.0),
            crossAxisCount: SizerUtil.orientation == Orientation.portrait ? 2 : 4,
            itemCount: allProducts.length,
            staggeredTileBuilder: (int index) =>
            //StaggeredTile.count(2, index.isEven ? 2 : 1.8),
            StaggeredTile.fit(1),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 16.0,
            itemBuilder: (BuildContext context, int index) => Container(
              //margin: EdgeInsets.only(top: index == 1 ? 16.0 : 0.0),
              child: ProductWidget(
                product: allProducts[index],
                productId: productProvider.productsIds[index],
                key: ValueKey(productProvider.productsIds[index]),
              ),
            ),
          ),
        );
      }),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/pages/products/product_widget.dart';
// import 'package:shop_app/providers/products_provider.dart';
//
// class ProductsWidget extends StatelessWidget {
//   const ProductsWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () =>
//           Provider.of<ProductProvider>(context, listen: false).getAllProducts(),
//       child:
//           Consumer<ProductProvider>(builder: (context, productProvider, child) {
//         var allProducts = productProvider.allProducts;
//         return StaggeredGridView.countBuilder(
//           //shrinkWrap: true,
//           physics: BouncingScrollPhysics(),
//           padding: EdgeInsets.all(16.0),
//           crossAxisCount: 2,
//           itemCount: allProducts.length,
//           staggeredTileBuilder: (int index) =>
//               //StaggeredTile.count(2, index.isEven ? 2 : 1.8),
//               StaggeredTile.fit(1),
//           mainAxisSpacing: 8.0,
//           crossAxisSpacing: 16.0,
//           itemBuilder: (BuildContext context, int index) => ChangeNotifierProvider.value(
//             value: allProducts[index],
//             child: ProductWidget(
//               //product: allProducts[index],
//               productId: productProvider.productsIds[index],
//               key: ValueKey(productProvider.productsIds[index]),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
