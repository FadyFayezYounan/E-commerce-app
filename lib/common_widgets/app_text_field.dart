import 'package:flutter/material.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_icon_button.dart';

import '../constants.dart';
enum TextFiledStyle {
  OutlineBorder,
  UnderlineBorder,
}

class AppTextFiled extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final double? height;
  final double hPadding;
  final double vPadding;
  final double borderRadius;
  final double vContentPadding;
  final double hContentPadding;
  final int? maxLines;
  final bool isPasswordTextFiled;
  final TextFiledStyle textFiledStyle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  const AppTextFiled({
    Key? key,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.height,
    this.hPadding: KAppPadding,
    this.vPadding: KAppPadding / 2,
    this.borderRadius : KAppPadding / 2,
    this.vContentPadding : 20,
    this.hContentPadding : KAppPadding,
    this.maxLines : 1,
    this.isPasswordTextFiled: false,
    this.textFiledStyle: TextFiledStyle.OutlineBorder,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  _AppTextFiledState createState() => _AppTextFiledState();
}

class _AppTextFiledState extends State<AppTextFiled> {
  bool showPassword = true;

  void toggleShowPasswordValue() {
    setState(() {
      showPassword = !showPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    return Container(
      height: widget.height,
      margin: EdgeInsets.symmetric(
        horizontal: widget.hPadding,
        vertical: widget.vPadding,
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: widget.vContentPadding,horizontal: widget.hContentPadding),
          border: widget.textFiledStyle == TextFiledStyle.OutlineBorder
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          )
              : UnderlineInputBorder(),
          enabledBorder: widget.textFiledStyle == TextFiledStyle.OutlineBorder
              ? OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: appTheme.accentColor.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          )
              : UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor.withOpacity(0.1),
            ),
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          //   borderSide: BorderSide(
          //     width: 0.7,
          //     color: appTheme.primaryColor,
          //   ),
          // ),
          hintText: widget.hintText,
          hintStyle: appTheme.textTheme.subtitle2,
          labelText: widget.labelText,
          labelStyle: appTheme.textTheme.subtitle1,
          //contentPadding: EdgeInsets.all(0.0),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPasswordTextFiled == true
              ? AppIconButton(
            iconName: showPassword == true ? IconName.show : IconName.hide,
            onPressed: toggleShowPasswordValue,
            iconColor: appTheme.accentColor,
          )
              : null,
        ),
        obscureText: widget.isPasswordTextFiled == false ? false : showPassword,
        style: appTheme.textTheme.subtitle1,
        maxLines: widget.maxLines,
        // validator: widget.validator,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
      ),
    );
  }
}
