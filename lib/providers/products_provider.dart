import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/helpers/end_points.dart';
import 'package:shop_app/modals/product_collection_modal.dart';
import 'package:shop_app/modals/product_modal.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModal> _products = [];
  List<String> _productsIds = [];
  List<ProductCollectionModal> productCollections = [];

  List<ProductModal> get allProducts => [..._products];
  List<String> get productsIds => [..._productsIds];

  final _firestore = FirebaseFirestore.instance;

  Future<void> getAllProducts() async {
    ///get all products
    _products = [];
    _productsIds = [];
    final allProducts = await _firestore.collection(PRODUCTS).get();
    allProducts.docs.forEach((currentProduct) async {
      _productsIds.add(currentProduct.id);
      _products.add(ProductModal.fromJson(currentProduct.data()));
    });
    notifyListeners();
  }

  /// used in product details page to get product images
  Future getProductCollectionsById({required productId}) async {
    try {
      productCollections = [];
      final collections = await _firestore
          .collection(PRODUCTS)
          .doc(productId)
          .collection(PRODUCTCOLORSANDCOLLECTIONS)
          .get();
      collections.docs.forEach((currentCollection) {
        productCollections
            .add(ProductCollectionModal.fromJson(currentCollection.data()));
        //productCollections.reversed;
        //print(convertCollectionFromJson(json: currentCollection.data()).color);
      });

      //print('----------------------->${collections.docs.length}');
      //print('----------------------->${_productCollections.length}');
    } on FirebaseException catch (error) {
      print(error);
    }
    notifyListeners();
  }

  /// to change the selected color for the product
  int selectedColor = 0;

  void changeSelectedColorValue(int newValue) {
    selectedColor = newValue;
    notifyListeners();
  }


  List<ProductModal> womenProducts = [];
  List<String> womenProductIds = [];
  Future getWomenProducts()async{
    womenProductIds = [];
    womenProductIds =[];
    final allWomenProducts = await _firestore.collection(PRODUCTS).where('category',isEqualTo: 'women').get();
    allWomenProducts.docs.forEach((currentWomenProduct) async {
      womenProductIds.add(currentWomenProduct.id);
      womenProducts.add(ProductModal.fromJson(currentWomenProduct.data()));
    });
    notifyListeners();
  }

}



// Map<String, bool> favoritesProducts = {};
//   Map<String, bool> cartProducts = {};
//final userId = AuthHelper.userId;
//int getCartProductsLength() {
//     int cartProductsLength = 0;
//     cartProducts.forEach((key, value) {
//       if (value == true) {
//         cartProductsLength++;
//       }
//     });
//     return cartProductsLength;
//   }
//
//   ///get user favorites products
//   Future getAllFavoritesProducts() async {
//     final allFavoriteProducts = await _firestore
//         .collection(USERS)
//         .doc(userId)
//         .collection(FAVORITES)
//         .get();
//     allFavoriteProducts.docs.forEach((currentFavoriteProducts) {
//       favoritesProducts.putIfAbsent(
//         currentFavoriteProducts.id,
//         () => currentFavoriteProducts['inFavorites'],
//       );
//     });
//     //print(favoritesProducts);
//     notifyListeners();
//   }
//
//   /// change product favorite state {add to Favorites or remove form favorites}
//   Future toggleProductFavoriteValue({
//     required String productId,
//     //required String userId,
//   }) async {
//     if (favoritesProducts.containsKey(productId) == false) {
//       favoritesProducts.putIfAbsent(productId, () => true);
//       notifyListeners();
//       try {
//         await _firestore
//             .collection(USERS)
//             .doc(userId)
//             .collection(FAVORITES)
//             .doc(productId)
//             .set({
//           'inFavorites': true,
//         });
//       } on FirebaseException catch (e) {
//         favoritesProducts.putIfAbsent(productId, () => false);
//         notifyListeners();
//         throw e;
//       }
//     } else {
//       favoritesProducts[productId] = !favoritesProducts[productId]!;
//       notifyListeners();
//       try {
//         await _firestore
//             .collection(USERS)
//             .doc(userId)
//             .collection(FAVORITES)
//             .doc(productId)
//             .update({
//           'inFavorites': favoritesProducts[productId]!,
//         });
//       } on FirebaseException catch (e) {
//         favoritesProducts[productId] = !favoritesProducts[productId]!;
//         notifyListeners();
//         throw e;
//       }
//     }
//   }
//
//   ///get user cart products
//   Future getAllCartProducts() async {
//     final allCartProducts =
//         await _firestore.collection(USERS).doc(userId).collection(CART).get();
//     allCartProducts.docs.forEach((currentCartProducts) {
//       cartProducts.putIfAbsent(
//         currentCartProducts.id,
//         () => currentCartProducts['inCart'],
//       );
//     });
//     //print(cartProducts);
//     notifyListeners();
//   }
//
//   /// change product cart state {add to cart or remove form cart}
//   Future toggleProductCartValue({
//     required String productId,
//   }) async {
//     if (cartProducts.containsKey(productId) == false) {
//       cartProducts.putIfAbsent(productId, () => true);
//       notifyListeners();
//       try {
//         await _firestore
//             .collection(USERS)
//             .doc(userId)
//             .collection(CART)
//             .doc(productId)
//             .set({
//           'inCart': true,
//           'amount': 0,
//         });
//       } on FirebaseException catch (e) {
//         cartProducts.putIfAbsent(productId, () => false);
//         notifyListeners();
//         throw e;
//       }
//     } else {
//       cartProducts[productId] = !cartProducts[productId]!;
//       notifyListeners();
//       try {
//         await _firestore
//             .collection(USERS)
//             .doc(userId)
//             .collection(CART)
//             .doc(productId)
//             .update({
//               'inCart': cartProducts[productId]!,
//             });
//       } on FirebaseException catch (e) {
//         cartProducts[productId] = !cartProducts[productId]!;
//         notifyListeners();
//         throw e;
//       }
//     }
//   }