
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FilledIconButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double iconSize;
  final VoidCallback onPressed;

  const FilledIconButton({
    Key? key,
    required this.icon,
    this.iconColor,
    this.iconSize :14.0,
    required this.onPressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      width: 32.sp,
      height: 32.sp,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: iconSize.sp,
          color: iconColor == null ? Theme.of(context).accentColor: iconColor,
        ),
        splashRadius: 16.sp,
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// import '../constants.dart';
// import 'package:sizer/sizer.dart';
//
// class FilledIconButton extends StatelessWidget {
//   final double width;
//   final double height;
//   final IconData icon;
//   final VoidCallback onPressed;
//   const FilledIconButton({
//     Key? key,
//     this.width :24,
//     this.height : 24,
//     required this.icon,
//     required this.onPressed,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return RawMaterialButton(onPressed: onPressed,
//       child: Icon(
//         icon,
//         color: Color(0xFFE57373),
//         size: 14.sp,
//       ),
//       fillColor: Colors.white,
//       elevation: 0.0,
//       shape: StadiumBorder(),
//       constraints: BoxConstraints.tightFor(
//         width: width.sp,
//         height: height.sp,
//       ),
//     );
//   }
// }