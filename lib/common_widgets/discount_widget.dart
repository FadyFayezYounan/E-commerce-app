import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:sizer/sizer.dart';

class DiscountWidget extends StatelessWidget {
  final String discountAmount;
  final double topRightBorderRadius;

  const DiscountWidget({
    Key? key,
    required this.discountAmount,
    this.topRightBorderRadius : 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ClipPath(
        clipper: PointsClipper(),
        child: Container(
          margin: EdgeInsets.only(left: 8.sp),
          height: 5.h,
          width: 6.w,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(16.0)),
            color: Color(0xFFE57373),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(topRightBorderRadius),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDiscountText(text: '$discountAmount%'),
              buildDiscountText(text: 'off'),
            ],
          ),
        ),
      ),
    );
  }

  FittedBox buildDiscountText({required String text}) {
    return FittedBox(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 8.sp,
        ),
      ),
    );
  }
}
