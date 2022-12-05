import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';
import 'package:shop_app/modals/product_collection_modal.dart';

import '../../constants.dart';
import 'package:sizer/sizer.dart';

class ProductCollection extends StatelessWidget {
  final ProductCollectionModal productCollectionModal;

  const ProductCollection({
    Key? key,
    required this.productCollectionModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final collectionImages = productCollectionModal.imagesPaths!;
    return Padding(
      padding: const EdgeInsets.all(KAppPadding),
      child: Column(
        children: [
          Divider(),
          Row(
            children: [
              Text(
                'Collection Color : ',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              CircleAvatar(
                radius: 12.sp,
                backgroundColor: HexColor('#${productCollectionModal.color}'),
              ),
              // Spacer(),
              // if (productProvider.collectionImages!.length != 0)
              //   TextButton(
              //     onPressed: () {},
              //     child: Text('Add new collection'),
              //   ),
            ],
          ),
          AppHSizedBox(),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12.0),
            padding: const EdgeInsets.all(6.0),
            color: Theme.of(context).accentColor.withOpacity(0.5),
            child: SizedBox(
              width: 100.w,
              height: 64.h,
              child: collectionImages.length != 0
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        return Image.file(
                          collectionImages[
                              index]!, //productProvider.collectionImages![index]!,
                        );
                      },
                      itemCount: collectionImages
                          .length, //productProvider.collectionImages!.length,
                    )
                  : Center(
                      child: Text(
                        'No Images For This Collection',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.5),
                            ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
