import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_button.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_icon_button.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';
import 'package:shop_app/common_widgets/app_text_field.dart';
import 'package:shop_app/constants.dart';

import 'package:shop_app/pages/admin_products/product_collection.dart';
import 'package:shop_app/pages/admin_products/product_image.dart';
import 'package:shop_app/providers/admin_product_provider.dart';


import 'admin_loading_page.dart';

class AdminProductsPage extends StatefulWidget {
  const AdminProductsPage({Key? key}) : super(key: key);

  @override
  _AdminProductsPageState createState() => _AdminProductsPageState();
}

class _AdminProductsPageState extends State<AdminProductsPage> {
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController productDescriptionController;
  late TextEditingController productOldPriceController;
  late TextEditingController productDiscountController;
  late TextEditingController hexColorController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController();
    productPriceController = TextEditingController();
    productDescriptionController = TextEditingController();
    productOldPriceController = TextEditingController();
    productDiscountController = TextEditingController();
    hexColorController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    List<File?>? images = [];
    return _isLoading == true
        ? AdminLoadingPage()
        : Consumer<AdminProductProvider>(
            builder: (context, adminProductProvider, child) => Scaffold(
              appBar: AppBar(
                title: Text('Add Products'),
                actions: [
                  AppIconButton(
                    iconName: IconName.save,
                    onPressed: () async {
                      // EasyLoading.show(
                      //   status: 'loading...',
                      //   dismissOnTap: false,
                      //   maskType: EasyLoadingMaskType.black,
                      //   indicator: CircularProgressIndicator(),
                      // );
                      // await adminProductProvider.saveProductToFirebase(
                      //   name: productNameController.text,
                      //   price: productPriceController.text,
                      //   oldPrice: productOldPriceController.text.isEmpty
                      //       ? '0.0'
                      //       : productOldPriceController.text,
                      //   discount: productDiscountController.text.isEmpty
                      //       ? '0.0'
                      //       : productDiscountController.text,
                      //   description: productDescriptionController.text,
                      // );
                      // if (adminProductProvider.loadingProduct == false) {
                      //   EasyLoading.dismiss();
                      //   EasyLoading.showToast(
                      //     'Product Added Successfully',
                      //     toastPosition: EasyLoadingToastPosition.bottom,
                      //   );
                      // }
                      //
                      // productNameController.clear();
                      // productPriceController.clear();
                      // productDiscountController.clear();
                      // productOldPriceController.clear();
                      // productDescriptionController.clear();
                      // adminProductProvider.deleteProductImage();
                      // adminProductProvider.deletePickedCollections();

                      //await adminProductProvider.uploadProductCollectionImages2(productId: '');

                      // print('------------------------------->${adminProductProvider.collections[0].imagesPaths!.length}');
                      // print('------------------------------->${adminProductProvider.collections[1].imagesPaths!.length}');
                      //await adminProductProvider.uploadProductCollectionImages2(productId: '');

                      setState(() {
                        _isLoading = true;
                      });
                      var productId =
                          await adminProductProvider.saveProductToFirebase(
                        name: productNameController.text,
                        price: productPriceController.text,
                        oldPrice: productOldPriceController.text.isEmpty
                            ? '0.0'
                            : productOldPriceController.text,
                        discount: productDiscountController.text.isEmpty
                            ? '0.0'
                            : productDiscountController.text,
                        description: productDescriptionController.text,
                      );
                      await adminProductProvider.uploadProductCollectionImages2(
                          productId: productId);

                      setState(() {
                        _isLoading = false;
                      });

                      productNameController.clear();
                      productPriceController.clear();
                      productDiscountController.clear();
                      productOldPriceController.clear();
                      productDescriptionController.clear();
                      adminProductProvider.deleteProductImage();
                      adminProductProvider.deletePickedCollections();
                    },
                  ),
                ],
              ),
              body: Scrollbar(
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppTextFiled(
                        hintText: 'Product Name',
                        controller: productNameController,
                        textInputAction: TextInputAction.next,
                      ),
                      AppTextFiled(
                        hintText: 'Price',
                        controller: productPriceController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextFiled(
                              hintText: 'Discount = 0\$',
                              controller: productDiscountController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Expanded(
                            child: AppTextFiled(
                              hintText: 'Old Price = 0\$',
                              controller: productOldPriceController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      AppTextFiled(
                        hintText: 'Description',
                        controller: productDescriptionController,
                        textInputAction: TextInputAction.done,
                        maxLines: 4,
                      ),

                      //buildUpload(adminProductProvider.uploadTaskProductImage),
                      ProductImage(),
                      ...adminProductProvider.collections.map(
                        (currentCollection) => ProductCollection(
                          productCollectionModal: currentCollection,
                        ),
                      ),
                      buildAddNewCollection(
                          context, adminProductProvider, images),
                      //buildProductCollections(productAvailableColors: 3),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget buildAddNewCollection(
    BuildContext context,
    AdminProductProvider adminProductProvider,
    List<File?>? images,
  ) {
    return Padding(
      padding: const EdgeInsets.all(KAppPadding),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Collection HexColor:',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              AppWSizedBox(),
              Expanded(
                child: AppTextFiled(
                  controller: hexColorController,
                  hintText: 'hexColor',
                  vContentPadding: 0.0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Select Collection Images:',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              AppWSizedBox(),
              TextButton(
                onPressed: () async {
                  images = await adminProductProvider.pickCollectionImages();
                },
                child: Text('Select'),
              ),
            ],
          ),
          AppButton(
            text: 'Add',
            onPressed: () {
              adminProductProvider.addNewCollection(
                collectionImages: images,
                hexColor: hexColorController.text,
              );
              images = [];
              hexColorController.clear();
            },
            buttonHeight: 6.0,
            vPadding: 0.0,
          ),
        ],
      ),
    );
  }

}





// Widget buildProductCollections({required int productAvailableColors}){
//   List<Widget> _collections  = [];
//   for(int i=0 ; i<productAvailableColors ; i++){
//     _collections.add(ProductCollection());
//   }
//
//   return Column(
//     children: _collections,
//   );
// }


// class ProductCollection extends StatelessWidget {
//   const ProductCollection({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProductProvider>(
//       builder: (context, productProvider, child) =>
//           Padding(
//             padding: const EdgeInsets.all(KAppPadding),
//             child: Column(
//               children: [
//                 Divider(),
//                 Row(
//                   children: [
//                     Text('Collection Color : ', style: Theme
//                         .of(context)
//                         .textTheme
//                         .subtitle1,),
//                     CircleAvatar(
//                       radius: 12.sp,
//                     ),
//                     Spacer(),
//                     if(productProvider.collectionImages!.length != 0)
//                     TextButton(
//                       onPressed: () {},
//                       child: Text('Add new collection'),
//                     ),
//                   ],
//                 ),
//                 AppHSizedBox(),
//                 DottedBorder(
//                   borderType: BorderType.RRect,
//                   radius: const Radius.circular(12.0),
//                   padding: const EdgeInsets.all(6.0),
//                   color: Theme.of(context).accentColor.withOpacity(0.5),
//                   child: SizedBox(
//                     width: 100.w,
//                     height: 64.h,
//                     child: productProvider.collectionImages!.length != 0
//                         ? GridView.builder(
//                       //shrinkWrap: true,
//                       //physics: NeverScrollableScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 3 / 4,
//                       ),
//                       itemBuilder: (context, index) {
//                         return Image.file(
//                             productProvider.collectionImages![index]!);
//                       },
//                       itemCount: productProvider.collectionImages!.length,
//                     )
//                         : TextButton(
//                       onPressed: () {
//                         productProvider.pickCollectionImages(key: '');
//                       },
//                       child: Text('pick Collection images'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//     );
//   }
// }
