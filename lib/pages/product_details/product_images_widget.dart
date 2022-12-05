import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/cached_network_image.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
  }) : super(key: key);

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final productCollections = productProvider.productCollections;
          var reversedCollections = productCollections.reversed.toList();
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemCount: reversedCollections[productProvider.selectedColor]
                    .imagesUrl
                    .length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                  child: AppCachedNetworkImage(
                    imageUrl: reversedCollections[productProvider.selectedColor]
                        .imagesUrl[index],
                    borderRadius: 24.0,
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count:  reversedCollections[productProvider.selectedColor]
                      .imagesUrl
                      .length,
                  axisDirection: Axis.horizontal,
                  effect:  ExpandingDotsEffect(
                      spacing:  4.0,
                      radius:  16,
                      dotWidth:  8.0,
                      dotHeight:  8.0,
                      //paintStyle:  PaintingStyle.stroke,
                      strokeWidth:  1.5,
                      dotColor:  Colors.grey.withOpacity(0.4),
                      activeDotColor:  Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}