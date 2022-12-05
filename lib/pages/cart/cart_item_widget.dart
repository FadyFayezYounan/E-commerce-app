import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';
import 'package:shop_app/common_widgets/cached_network_image.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/modals/cart_product_modal.dart';
import 'package:shop_app/pages/product_details/product_details_page.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:sizer/sizer.dart';

import 'amount_button.dart';

class CartItemWidget extends StatelessWidget {
  final CartProductModal cartProductModal;

  const CartItemWidget({
    Key? key,
    required this.cartProductModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Dismissible(
      key: ValueKey(cartProductModal.productId),
      onDismissed: (dismissDirection)async{
        try{
          await Provider.of<CartProvider>(context,listen: false).removeCartItem(productId: cartProductModal.productId);
        }catch(e){
          //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product deleted successfully.')));
        }
      },
      background: Container(
        padding: EdgeInsets.only(right: KAppPadding),
        alignment: Alignment.centerRight,
        color: Color(0xFFE57373),
        child: AppIcon(
          iconName: IconName.delete,
          iconColor: Colors.white,
          size: 24,
        ),
      ),
      direction: DismissDirection.endToStart,
      child: InkWell(
        splashColor: appTheme.accentColor.withOpacity(0.3),
        highlightColor: appTheme.accentColor.withOpacity(0.1),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                productId: cartProductModal.productId,
                productModal: cartProductModal.productModal,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 30.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Center(child: AppCheckBox()),
              AppCachedNetworkImage(
                boxFit: BoxFit.cover,
                borderRadius: 12.0,
                imageUrl: '${cartProductModal.productModal.imageUrl}',
              ),
              AppWSizedBox(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${cartProductModal.productModal.name}',
                        style: appTheme.textTheme.subtitle1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${cartProductModal.productModal.price}',
                          style: appTheme.textTheme.subtitle1!.copyWith(
                            color: appTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: KAppPadding / 2,
                        ),
                        if (cartProductModal.productModal.discount != '0.0')
                          Text(
                            '\$${cartProductModal.productModal.oldPrice}',
                            style: TextStyle(
                              fontSize: 9.sp,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AmountButton(
                        iconData: Icons.remove,
                        iconColor: appTheme.accentColor.withOpacity(0.5),
                        onPress: () {
                          // cartProductModal.decreaseAmount(
                          //     productId: cartProductModal.productId);
                         // Provider.of<CartProvider>(context).increaseAmount(productId: cartProductModal.productId);
                          Provider.of<CartProvider>(context,listen: false).decreaseAmount(productId: cartProductModal.productId);
                        },
                        splashColor: appTheme.accentColor,
                      ),
                      Text(
                        '${cartProductModal.amount}',
                        style: appTheme.textTheme.subtitle1,
                      ),
                      AmountButton(
                        iconData: Icons.add,
                        iconColor: appTheme.primaryColor,
                        onPress: () {
                          // cartProductModal.increaseAmount(
                          //     productId: cartProductModal.productId);
                          Provider.of<CartProvider>(context,listen: false).increaseAmount(productId: cartProductModal.productId);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
