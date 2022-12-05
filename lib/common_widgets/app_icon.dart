import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';


class IconName{
  static String get home => 'Home';
  static String get homeStyle2 => 'Home Style 2';
  static String get camera => 'Camera';
  static String get category => 'Category';
  static String get show => 'Show';
  static String get hide => 'Hide';
  static String get profile => 'Profile';
  static String get password => 'password';
  static String get facebook => 'Facebook - Negative';
  static String get google => 'Google - Negative';
  static String get image => 'Image';
  static String get save => 'Tick Square';
  static String get paperPlus => 'Paper Plus';
  static String get search => 'Search2';
  static String get notification => 'Notification';
  static String get infoSquare => 'Info Square';
  static String get arrowLeftCircle => 'Arrow - Left Circle';
  static String get buy => 'Buy';
  static String get buyStyle2 => 'Buy Style 2';
  static String get buyFilled => 'Buy Filled';
  static String get profileFilled => 'Profile Filled';
  static String get heartFilled => 'Heart_filled';
  static String get searchFilled => 'Search Filled';
  static String get delete => 'Delete';
  static String get message => 'Message';
  static String get lock => 'Lock';
  static String get filter => 'Filter';
}
class AppIcon extends StatelessWidget {
  final String iconName;
  final Color? iconColor;
  final double size;

  const AppIcon({
    Key? key,
    required this.iconName,
    this.iconColor,
    this.size : 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      color: iconColor == null ? Theme.of(context).accentColor : iconColor,
      width: size.sp,
      height: size.sp,
    );
  }
}
