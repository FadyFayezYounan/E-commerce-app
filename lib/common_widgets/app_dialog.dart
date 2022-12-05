import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:sizer/sizer.dart';

enum AppDialogType {
  ERROR,
  WARNING,
  INFO,
}

void showAppDialog({
  required BuildContext context,
  required String title,
  required content,
  AppDialogType appDialogType: AppDialogType.ERROR,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: appDialogType == AppDialogType.ERROR
                  ? Color(0xFFE57373)
                  : appDialogType == AppDialogType.WARNING
                      ? Color(0xFFFDA900)
                      : Colors.teal,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
            ),
            width: 100.w,
            height: SizerUtil.orientation == Orientation.portrait ? 22.h : 16.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  appDialogType == AppDialogType.ERROR
                      ? Icons.cancel_rounded
                      : appDialogType == AppDialogType.WARNING
                          ? Icons.error_outline_rounded
                          : Icons.help_outline_rounded,
                  color: Colors.white,
                  size: 64.sp,
                ),
                Text(
                  '$title',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
          Container(
            width: 100.w,
            padding: const EdgeInsets.all(KAppPadding),
            height: SizerUtil.orientation == Orientation.portrait ? 14.h : 8.h,
            child: Text(
              '$content',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(KAppPadding / 2),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFE57373),
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 1.6.h,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ); // end of showDialog
}
