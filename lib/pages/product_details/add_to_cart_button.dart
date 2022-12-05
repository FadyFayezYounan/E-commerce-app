import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/modals/product_modal.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:sizer/sizer.dart';

class AddToCartButton extends StatelessWidget {
  final String productId;
  final ProductModal productModal;
  const AddToCartButton({
    Key? key,
    required this.productId,
    required this.productModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context , cartProvider , child){
        bool _inCart = cartProvider.cartProductsAsMap.containsKey(productId) == true? true : false;
        return RawMaterialButton(
          onPressed: () {
            cartProvider.toggleProductCartValue(productId: productId,productModal: productModal);
          },
          fillColor: Colors.white,
          child: AppIcon(
            iconName: _inCart == true ? IconName.buyFilled : IconName.buyStyle2,
          ),
          //Icon(Icons.shopping_cart_outlined),
          shape: StadiumBorder(),
          elevation: 0.0,
          constraints: BoxConstraints.tightFor(
            height: 9.h,
          ),
        );
      },
    );
  }
}