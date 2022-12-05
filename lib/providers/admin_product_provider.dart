import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/helpers/firebase_storage_helper.dart';
import 'package:shop_app/helpers/pickImageHelper.dart';
import 'package:shop_app/modals/product_collection_modal.dart';
import 'package:shop_app/modals/product_modal.dart';


class AdminProductProvider extends ChangeNotifier {
  File? productImage;

  //String? collectionColor;
  List<ProductCollectionModal> collections = [];

  // bool loadingProduct = false;
  //
  // void changeLoadingProductValue(bool newValue){
  //   loadingProduct = newValue;
  //   notifyListeners();
  // }

  int uploadingCollectionNumber = 0;
  int uploadingImageNumber = 0;
  void changeUploadingCollectionNumber(int number){
    uploadingCollectionNumber = number;
    notifyListeners();
  }
  void changeUploadingImageNumber(int number){
    uploadingImageNumber = number;
    notifyListeners();
  }

  void addNewCollection(
      {required String hexColor, required List<File?>? collectionImages}) {
    collections.add(
        ProductCollectionModal(color: hexColor, imagesPaths: collectionImages));
    notifyListeners();
  }

  void pickSingleImage() async {
    productImage = await PickImageHelper.pickImage();
    notifyListeners();
  }

  void deleteProductImage() {
    productImage = null;
    notifyListeners();
  }
  void deletePickedCollections(){
    collections = [];
    notifyListeners();
  }

  Future<List<File>?>? pickCollectionImages() async {
    final images = await PickImageHelper.pickMultiImages();
    //colorsAndImages!.putIfAbsent(key, () => collectionImages);
    return images;
  }

  Future saveProductToFirebase({
    required String name,
    required String price,
    required String oldPrice,
    required String discount,
    required String description,
  }) async {
    try {
      //changeLoadingProductValue(true);
      final String productImageUrl = await uploadProductImage();
      // final Map<String?, List<String>?> colorsAndImages =
      //     await uploadProductCollectionImages();
      ProductModal product = ProductModal(
        imageUrl: productImageUrl,
        name: name,
        price: price,
        oldPrice: oldPrice,
        discount: discount,
        description: description,
        //colorsAndImages: {},
      );
      var documentReference = await FirebaseFirestore.instance
          .collection('products')
          .add(product.toJson());
      // await uploadProductCollectionImages2(productId: documentReference.id);
      //changeLoadingProductValue(false);
      return documentReference.id;


    } on FirebaseException catch (error) {
      throw error;
    }
  }

  Future uploadProductImage() async {
    var imageUrl = await FirebaseStorageHelper.saveImageToFirebaseFireStorage(
      pickedImage: productImage!,
      directoryName: 'productImage',
    );
    return imageUrl;
  }

  Future uploadProductCollectionImages({required String productId}) async {
    //<String?, List<String>?> colorsAndImages = {};
    List<String>? collectionImagesUrl = [];
    collections.forEach((currentCollection) async {
      for (int i = 0; i < currentCollection.imagesPaths!.length; i++) {
        var imageUrl =
            await FirebaseStorageHelper.saveImageToFirebaseFireStorage(
          pickedImage: currentCollection.imagesPaths![i]!,
          directoryName: 'collections',
        );
        collectionImagesUrl!.add(imageUrl);
      }
      print('------------------------------------------>${collectionImagesUrl!.length}');
      ProductCollectionModal collectionModal = ProductCollectionModal(
        color: currentCollection.color,
        imagesUrl: collectionImagesUrl,
      );
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .collection('colors_and_collections')
          .add(collectionModal.toJson());
      collectionImagesUrl = [];
    });

  }


  List<String>? _collectionImagesUrl = [];
  String imageUrl = '';

  Future uploadProductCollectionImages2({required String productId}) async {


    for(int i = 0 ; i< collections.length ;i++){
      print('Collection[$i]---------->');
      changeUploadingCollectionNumber(i);
      for(int j = 0 ; j<collections[i].imagesPaths!.length ; j++){
        imageUrl = await FirebaseStorageHelper.saveImageToFirebaseFireStorage(
            pickedImage: collections[i].imagesPaths![j]!,
          directoryName: 'collections',
        );
        _collectionImagesUrl!.add(imageUrl);
        print('image $j');
        changeUploadingImageNumber(j);
      }
      print('------------------------------------------>${_collectionImagesUrl!.length}');
        ProductCollectionModal collectionModal = ProductCollectionModal(
          color: collections[i].color,
          imagesUrl: _collectionImagesUrl,
        );
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .collection('colors_and_collections')
          .add(collectionModal.toJson());
        _collectionImagesUrl = [];
    }
    // collections.forEach((currentCollection) async {
    //   for (int i = 0; i < currentCollection.imagesPaths!.length; i++) {
    //     var imageUrl =
    //     await FirebaseStorageHelper.saveImageToFirebaseFireStorage(
    //       pickedImage: currentCollection.imagesPaths![i]!,
    //       directoryName: 'collections',
    //     );
    //     _collectionImagesUrl!.add(imageUrl);
    //   }
    //   print('------------------------------------------>${_collectionImagesUrl!.length}');
    //   ProductCollectionModal collectionModal = ProductCollectionModal(
    //     color: currentCollection.color,
    //     imagesUrl: _collectionImagesUrl,
    //   );
    //   await FirebaseFirestore.instance
    //       .collection('collection_test')
    //       .add(collectionModal.toJson());
    //   _collectionImagesUrl = [];
    // });

  }


}
