import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/filled_icon_button.dart';
import 'package:shop_app/modals/product_collection_modal.dart';
import 'package:shop_app/modals/product_modal.dart';
import 'package:shop_app/pages/product_details/product_color_widget.dart';
import 'package:shop_app/pages/product_details/product_images_widget.dart';
import 'package:shop_app/pages/product_details/user_buy_and_add_cart_buttons.dart';
import 'package:shop_app/pages/products/like_button.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  final ProductModal productModal;

  const ProductDetailsPage({
    Key? key,
    required this.productId,
    required this.productModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return FutureBuilder(
      future: Provider.of<ProductProvider>(context, listen: false)
          .getProductCollectionsById(productId: productId),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return WillPopScope(
              onWillPop: () async {
                productProvider.changeSelectedColorValue(0);
                return true;
              },
              child: Scaffold(
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 64.h,
                          pinned: true,
                          flexibleSpace: ProductImages(),
                          //backgroundColor: Colors.redAccent,
                          leading: Padding(
                            padding: const EdgeInsets.all(12),
                            child: FilledIconButton(
                              icon: Icons.keyboard_arrow_left_rounded,
                              onPressed: () {
                                productProvider.changeSelectedColorValue(0);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          actions: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 13.0),
                              child: LikeButton(
                                productId: productId,
                                productModal: productModal,
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 8.0, vertical: 12.0),
                            //   child: FilledIconButton(
                            //     icon: Icons.favorite_rounded,
                            //     iconColor: Color(0xFFE57373),
                            //     onPressed: () {},
                            //   ),
                            // ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildProductColors(appTheme, productProvider),
                                buildProductNameAndPrice(appTheme),
                                buildProductDescription(appTheme),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    UserBuyAndAddCartButtons(
                      productId: productId,
                      productModal: productModal,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Row buildProductColors(ThemeData appTheme, ProductProvider productProvider) {
    return Row(
      children: [
        Text(
          'Product Colors : ',
          style: appTheme.textTheme.subtitle1,
        ),
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productProvider.productCollections.length,
              itemBuilder: (context, index) {
                List<ProductCollectionModal> reversedList =
                productProvider.productCollections.reversed.toList();
                return ProductColorWidget(
                  hexColor: reversedList[index].color,
                  index: index,
                );
              },
              //reverse: true,
            ),
          ),
        ),
      ],
    );
  }
  ListTile buildProductNameAndPrice(ThemeData appTheme) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      title: Text(
        '${productModal.name}',
        style: appTheme.textTheme.headline5,
      ),
      trailing: Text(
        '\$${double.parse(productModal.price!)}',
        style: appTheme.textTheme.headline5!.copyWith(
          color: appTheme.primaryColor,
        ),
      ),
    );
  }
  ExpandableText buildProductDescription(ThemeData appTheme) {
    return ExpandableText(
      '${productModal.description}',
      expandText: 'show more',
      collapseText: 'show less',
      linkColor: appTheme.primaryColor,
      maxLines: 5,
      textAlign: TextAlign.start,
      style: appTheme.textTheme.subtitle2,
      animation: true,
      animationDuration: Duration(seconds: 1),
    );
  }


}
