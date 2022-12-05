import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_button.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_icon_button.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'cart_item_widget.dart';
import '../../common_widgets/empty_page_widget.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart-page';

  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          iconName: IconName.arrowLeftCircle,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Cart',
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) =>
            cartProvider.cartItemsLength != 0
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cartProvider.cartItemsLength,
                    itemBuilder: (context, index) => CartItemWidget(
                      cartProductModal: cartProvider.getCartProducts[index],
                    ),
                  )
                : EmptyPageWidget(
                    imageName: ImageName.emptyCart,
                  ),
      ),
      bottomNavigationBar: BottomAppBar(
        //color: Theme.of(context).scaffoldBackgroundColor,
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: KAppPadding * 2, vertical: KAppPadding),
          decoration: BoxDecoration(
            color: appTheme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(KAppPadding),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Payment',
                    style: appTheme.textTheme.headline5,
                  ),
                  Text(
                    '\$${Provider.of<CartProvider>(context).getTotalPayment}',
                    style: appTheme.textTheme.headline5!.copyWith(
                      color: appTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              AppHSizedBox(),
              AppButton(
                text: 'Checkout',
                onPressed: () {},
                borderRadius: 48.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
