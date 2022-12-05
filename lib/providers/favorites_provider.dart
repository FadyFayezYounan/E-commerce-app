import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/helpers/auth_helper.dart';
import 'package:shop_app/helpers/end_points.dart';
import 'package:shop_app/modals/favorite_product_modal.dart';
import 'package:shop_app/modals/product_modal.dart';

class FavoritesProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<FavoriteProductModal> favoritesProductsAsList = [];
  late Map<String, FavoriteProductModal> favoritesProductsAsMap;


  final userId = AuthHelper.userId;
  Future fetchAndSetUserFavoritesProducts() async {
    favoritesProductsAsMap = {};
    final allFavoriteProducts = await _firestore
        .collection(USERS)
        .doc(userId)
        .collection(FAVORITES)
        .get();
    allFavoriteProducts.docs.forEach((currentFavoriteProducts) {
      favoritesProductsAsMap.putIfAbsent(
        currentFavoriteProducts.id,
        () => FavoriteProductModal.fromJson(currentFavoriteProducts.data()),
      );
    });
    notifyListeners();
  }

  List<FavoriteProductModal> get getCartProducts =>
      favoritesProductsAsList = favoritesProductsAsMap.values.toList();

  int get favoritesItemsLength => favoritesProductsAsMap.length;

  // ///get user favorites products ids
  // Future getAllFavoritesProductsIds() async {
  //   final allFavoriteProducts = await _firestore
  //       .collection(USERS)
  //       .doc(userId)
  //       .collection(FAVORITES)
  //       .get();
  //   allFavoriteProducts.docs.forEach((currentFavoriteProducts) {
  //     favoritesProductsAsList.add(currentFavoriteProducts.id);
  //   });
  //
  //   notifyListeners();
  // }

  /// change product favorite state {add to Favorites or remove form favorites}
  Future toggleProductFavoriteValue({
    required String productId,
    required ProductModal productModal,
  }) async {
    FavoriteProductModal _favoriteProductModal = FavoriteProductModal(
      productModal: productModal,
      productId: productId,
    );
    if (favoritesProductsAsMap.containsKey(productId) == false) {
      //favoritesProductsAsList.add(productId);
      favoritesProductsAsMap.putIfAbsent(productId, () => _favoriteProductModal);
      notifyListeners();
      try {
        await _firestore
            .collection(USERS)
            .doc(userId)
            .collection(FAVORITES)
            .doc(productId)
            .set(_favoriteProductModal.toJson());
      } on FirebaseException catch (e) {
        //favoritesProductsAsList.remove(productId);
        favoritesProductsAsMap.remove(productId);
        notifyListeners();
        throw e;
      }
    } else {
      //favoritesProductsAsList.remove(productId);
      favoritesProductsAsMap.remove(productId);
      notifyListeners();
      try {
        await _firestore
            .collection(USERS)
            .doc(userId)
            .collection(FAVORITES)
            .doc(productId)
            .delete();
      } on FirebaseException catch (e) {
        // favoritesProductsAsList.add(productId);
        favoritesProductsAsMap.putIfAbsent(productId, () => _favoriteProductModal);
        notifyListeners();
        throw e;
      }
    }
  }

  Future removeFavoriteItem({required String productId}) async {
   favoritesProductsAsMap.remove(productId);
    notifyListeners();
    try {
      await _firestore
          .collection(USERS)
          .doc(userId)
          .collection(FAVORITES)
          .doc(productId)
          .delete();
    } on FirebaseException catch (e) {
      // cartProductsAsMap.putIfAbsent(productId, () => cartProductModal);
      // notifyListeners();
      throw e;
    }
  }
}
