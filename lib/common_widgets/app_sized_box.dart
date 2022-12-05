import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class AppHSizedBox extends StatelessWidget {
  const AppHSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: KAppPadding);
  }
}

class AppWSizedBox extends StatelessWidget {
  const AppWSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: KAppPadding);
  }
}
