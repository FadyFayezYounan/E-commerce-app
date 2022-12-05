import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_icon_button.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';
import 'package:shop_app/common_widgets/cached_network_image.dart';
import 'package:shop_app/common_widgets/discount_widget.dart';
import 'package:shop_app/modals/favorite_product_modal.dart';
import 'package:shop_app/pages/product_details/product_details_page.dart';
import 'package:shop_app/providers/favorites_provider.dart';
import 'package:sizer/sizer.dart';

class FavoriteItemWidget extends StatelessWidget {
  final FavoriteProductModal favoriteProductModal;

  const FavoriteItemWidget({
    Key? key,
    required this.favoriteProductModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  productId: favoriteProductModal.productId,
                  productModal: favoriteProductModal.productModal,
                ),
              ),
            );
          },
          splashColor: appTheme.accentColor.withOpacity(0.3),
          highlightColor: appTheme.accentColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: 100.w,
            height: 20.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: appTheme.accentColor.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(
              right: 6.w,
              top: 8.0,
              bottom: 8.0,
              left: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: AppCachedNetworkImage(
                    height: 20.h,
                    imageUrl: '${favoriteProductModal.productModal.imageUrl}',
                    borderRadius: 12,
                    boxFit: BoxFit.cover,
                  ),
                ),
                AppWSizedBox(),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${favoriteProductModal.productModal.name}',
                          style: appTheme.textTheme.headline6,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 0.6.h,
                      ),
                      if (favoriteProductModal.productModal.discount != '0.0')
                        Text(
                          '\$${favoriteProductModal.productModal.oldPrice}',
                          style: TextStyle(
                            fontSize: 9.sp,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Text(
                        '\$${favoriteProductModal.productModal.price}',
                        style: appTheme.textTheme.headline6!.copyWith(
                          color: appTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (favoriteProductModal.productModal.discount != '0.0')
          Positioned(
            top: 0,
            right: 0,
            child: DiscountWidget(
              discountAmount: '${favoriteProductModal.productModal.discount}',
              topRightBorderRadius: 12.0,
            ),
          ),
        Positioned(
          bottom: 0,
          right: 0,
          child: AppIconButton(
            onPressed: () {
              Provider.of<FavoritesProvider>(context, listen: false)
                  .removeFavoriteItem(
                      productId: favoriteProductModal.productId);
            },
            iconName: IconName.delete,
            splashRadius: 16.0,
            iconSize: 14.0,
            iconColor: Color(0xFFE57373),
          ),
        ),
      ],
    );
  }
}
