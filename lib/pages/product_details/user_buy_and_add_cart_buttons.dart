import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_button.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';
import 'package:shop_app/modals/product_modal.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import 'add_to_cart_button.dart';

class UserBuyAndAddCartButtons extends StatelessWidget {
  final String productId;
  final ProductModal productModal;
  const UserBuyAndAddCartButtons({
    Key? key,
    required this.productId,
    required this.productModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizerUtil.orientation == Orientation.portrait ? 100.w : 100.h,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: KAppPadding),
      child: Row(
        children: [
          Expanded(
            child: AddToCartButton(productId: productId,productModal: productModal,),
            flex: 1,
          ),
          AppWSizedBox(),
          Expanded(
            child: AppButton(
              text: 'Buy Now',
              onPressed: () {},
              borderRadius: 48.0,
              buttonHeight: 9,
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }
}

// class AddToCartButton extends StatelessWidget {
//   final String productId;
//   const AddToCartButton({
//     Key? key,
//     required this.productId,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartProvider>(
//      builder: (context , cartProvider , child){
//        bool _inCart = cartProvider.cart.containsKey(productId) == true? true : false;
//        return RawMaterialButton(
//          onPressed: () {
//            cartProvider.toggleProductCartValue(productId: productId);
//          },
//          fillColor: Colors.white,
//          child: AppIcon(
//            iconName: _inCart == true ? IconName.buyFilled : IconName.buyStyle2,
//          ),
//          //Icon(Icons.shopping_cart_outlined),
//          shape: StadiumBorder(),
//          elevation: 0.0,
//          constraints: BoxConstraints.tightFor(
//            height: 9.h,
//          ),
//        );
//      },
//     );
//   }
// }




//class AddToCartButton extends StatelessWidget {
//   final String productId;
//   const AddToCartButton({
//     Key? key,
//     required this.productId,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProductProvider>(
//      builder: (context , productProvider , child){
//        bool _inCart = productProvider.cartProducts.containsKey(productId) == false ? false : productProvider.cartProducts[productId]!;
//        return RawMaterialButton(
//          onPressed: () {
//            productProvider.toggleProductCartValue(productId: productId);
//          },
//          fillColor: Colors.white,
//          child: AppIcon(
//            iconName: _inCart == true ? IconName.buyFilled : IconName.buyStyle2,
//          ),
//          //Icon(Icons.shopping_cart_outlined),
//          shape: StadiumBorder(),
//          elevation: 0.0,
//          constraints: BoxConstraints.tightFor(
//            height: 9.h,
//          ),
//        );
//      },
//     );
//   }
// }