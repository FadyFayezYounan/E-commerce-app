import 'package:flutter/material.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:sizer/sizer.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final String iconName;
  final Color buttonColor;
  final VoidCallback onPressed;

  const SocialButton({
    Key? key,
    required this.text,
    required this.iconName,
    required this.buttonColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16.w,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: AppIcon(
          iconName: iconName,
          iconColor: Colors.white,
        ),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          elevation: 0.0,
          shape: StadiumBorder(),
          //padding: EdgeInsets.symmetric(vertical: 1.6.h,horizontal: 16)
        ),
      ),
    );
  }
}
