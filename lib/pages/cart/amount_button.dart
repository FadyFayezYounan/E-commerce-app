import 'package:flutter/material.dart';

class AmountButton extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color? splashColor;
  final VoidCallback onPress;
  const AmountButton({
    Key? key,
    required this.iconData,
    required this.iconColor,
    required this.onPress,
    this.splashColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    return SizedBox(
      width: 32,
      height: 32,
      child: OutlinedButton(
        onPressed: onPress,
        child: Icon(
          iconData,
          size: 16,
          color: iconColor,
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: BorderSide(
            color: appTheme.accentColor.withOpacity(0.1),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          primary: splashColor??appTheme.primaryColor,
        ),
      ),
    );
  }
}