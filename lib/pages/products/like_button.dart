

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modals/product_modal.dart';
import 'package:shop_app/providers/favorites_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:sizer/sizer.dart';
class LikeButton extends StatelessWidget {
  final String productId;
  final ProductModal productModal;
  const LikeButton({
    Key? key,
    required this.productId,
    required this.productModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context , favoritesProvider , child){
        //bool _isLiked = favoritesProvider.favoritesProductsAsList.contains(productId)  == true ? true : false;
        bool _isLiked = favoritesProvider.favoritesProductsAsMap.containsKey(productId)  == true ? true : false;
        return RawMaterialButton(
          onPressed: (){
            favoritesProvider.toggleProductFavoriteValue(productId: productId,productModal: productModal);
          },
          fillColor: Colors.white,
          elevation: 0.0,
          child: Icon(
            _isLiked == true ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: _isLiked == true ? Color(0xFFE57373) : Colors.grey.withOpacity(0.5),
            size: 14.sp,
          ),
          shape: StadiumBorder(),
          constraints: BoxConstraints.tightFor(
            width: 24.sp,
            height: 24.sp,
          ),
        );
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/providers/products_provider.dart';
// import 'package:sizer/sizer.dart';
// class LikeButton extends StatelessWidget {
//   final String productId;
//   const LikeButton({
//     Key? key,
//     required this.productId,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Consumer<ProductProvider>(
//       builder: (context , productProvider , child){
//         bool _isLiked = productProvider.favoritesProducts.containsKey(productId) == false ? false : productProvider.favoritesProducts[productId]!;
//         return RawMaterialButton(
//           onPressed: (){
//             productProvider.toggleProductFavoriteValue(productId: productId,);
//           },
//           fillColor: Colors.white,
//           elevation: 0.0,
//           child: Icon(
//             _isLiked == true ? Icons.favorite_rounded : Icons.favorite_border_rounded,
//             color: _isLiked == true ? Color(0xFFE57373) : Theme.of(context).accentColor.withOpacity(0.5),
//             size: 14.sp,
//           ),
//           shape: StadiumBorder(),
//           constraints: BoxConstraints.tightFor(
//             width: 24.sp,
//             height: 24.sp,
//           ),
//         );
//       },
//     );
//   }
// }




////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/modals/product_modal.dart';
// import 'package:sizer/sizer.dart';
// class LikeButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   const LikeButton({
//     Key? key,
//     required this.onPressed,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final product = Provider.of<ProductModal>(context);
//     return RawMaterialButton(
//       onPressed: (){
//         product.toggleInFavoriteStatus();
//       },
//       fillColor: Colors.white,
//       elevation: 0.0,
//       child: Icon(
//         product.inFavorites == true ? Icons.favorite_rounded : Icons.favorite_border_rounded,
//         color: product.inFavorites == true ? Color(0xFFE57373) : Theme.of(context).accentColor.withOpacity(0.5),
//         size: 14.sp,
//       ),
//       shape: StadiumBorder(),
//       constraints: BoxConstraints.tightFor(
//         width: 24.sp,
//         height: 24.sp,
//       ),
//     );
//   }
// }