import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_icon_button.dart';
import 'package:shop_app/providers/admin_product_provider.dart';

import '../../constants.dart';
import 'package:sizer/sizer.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(KAppPadding),
      child: Consumer<AdminProductProvider>(
        builder: (context, adminProductProvider, child) => DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12.0),
          padding: const EdgeInsets.all(6.0),
          color: appTheme.accentColor.withOpacity(0.5),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              width: 100.w,
              height: 50.h,
              child: adminProductProvider.productImage == null
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Product Image',
                    style: appTheme.textTheme.subtitle1,
                  ),
                  AppIconButton(
                    onPressed: () {
                      adminProductProvider.pickSingleImage();
                    },
                    iconName: IconName.paperPlus,
                    iconSize: 48,
                  ),
                ],
              )
                  : buildProductPickedImage(adminProductProvider),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProductPickedImage(AdminProductProvider adminProductProvider) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.file(
            adminProductProvider.productImage!,
            fit: BoxFit.contain,
          ),
          Positioned(
            top: -8.sp,
            right: -8.sp,
            child: CircleAvatar(
              backgroundColor: Color(0xFFE57373),
              radius: 8.sp,
              child: InkWell(
                onTap: () {
                  adminProductProvider.deleteProductImage();
                },
                child: Icon(
                  Icons.clear_outlined,
                  color: Colors.white,
                  size: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}