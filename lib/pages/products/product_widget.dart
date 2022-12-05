
import 'package:flutter/material.dart';
import 'package:shop_app/common_widgets/cached_network_image.dart';
import 'package:shop_app/common_widgets/discount_widget.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/modals/product_modal.dart';
import 'package:shop_app/pages/product_details/product_details_page.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'like_button.dart';

class ProductWidget extends StatelessWidget {
  final ProductModal product;
  final String productId;

  const ProductWidget({
    Key? key,
    required this.product,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    //final product = Provider.of<ProductModal>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      splashColor: appTheme.accentColor.withOpacity(0.3),
      highlightColor: appTheme.accentColor.withOpacity(0.1),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              productId: productId,
              productModal: product,
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProductImage(context),
            const SizedBox(
              height: KAppPadding / 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${product.name}',
                style: appTheme.textTheme.headline6,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
              child: Row(
                children: [
                  Text(
                    '\$${product.price} ',
                    style: appTheme.textTheme.subtitle1!.copyWith(
                      color: appTheme.primaryColor,
                    ),
                  ),
                  if (product.discount != '0.0')
                    Text(
                      '\$${product.oldPrice}',
                      style: TextStyle(
                        fontSize: 9.sp,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductImage(context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Align(
          alignment: Alignment.center,
          child: AppCachedNetworkImage(
            imageUrl: '${product.imageUrl}',
            borderRadius: 12.0,
          ),
        ),
        LikeButton(
          productId: productId,
          productModal: product,
        ),
        if (product.discount != '0.0') DiscountWidget(discountAmount: '${product.discount}',),
      ],
    );
  }
}
