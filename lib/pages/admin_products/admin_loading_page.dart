import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';
import 'package:shop_app/providers/admin_product_provider.dart';

class AdminLoadingPage extends StatelessWidget {
  const AdminLoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminProductProvider>(
        builder: (context, adminProductProvider, child) {
          int collectionImagesLength = adminProductProvider.collections[adminProductProvider.uploadingCollectionNumber].imagesPaths!.length ;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                AppHSizedBox(),
                Text(
                  'Uploading Collection ${adminProductProvider.uploadingCollectionNumber+1} From ${adminProductProvider.collections.length}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                AppHSizedBox(),
                Text(
                  'Uploading Image ${adminProductProvider.uploadingImageNumber +1} From $collectionImagesLength',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}