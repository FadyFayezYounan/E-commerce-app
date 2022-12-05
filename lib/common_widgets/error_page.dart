import 'package:flutter/material.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 64,
              backgroundColor: Color(0xFFE57373),
              child: Icon(
                Icons.cancel_rounded,
                color: Colors.white,
                size: 64,
              ),
            ),
            AppHSizedBox(),
            Text(
              'An error occurred.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
