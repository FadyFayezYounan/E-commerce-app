import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';
import 'package:sizer/sizer.dart';

class ImageName {
  static String get emptyCart => 'empty_cart';
  static String get noFavorites => 'no_favorites';
}

class EmptyPageWidget extends StatelessWidget {
  final String imageName;

  const EmptyPageWidget({
    Key? key,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/$imageName.svg',
            width: 50.w,
            height: 50.w,
          ),
          AppHSizedBox(),
          AppHSizedBox(),
          Text(
            'No products yet!!',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
