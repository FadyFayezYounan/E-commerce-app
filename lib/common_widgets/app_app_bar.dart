import 'package:flutter/material.dart';

import 'app_icon.dart';
import 'app_icon_button.dart';

AppBar buildAppBar({required BuildContext context, required String title}) {
  return AppBar(
    leading: AppIconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      iconName: IconName.arrowLeftCircle,
    ),
    title: Text(title),
  );
}
