import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/helpers/auth_helper.dart';
import 'package:shop_app/helpers/end_points.dart';
import 'package:shop_app/modals/cart_product_modal.dart';
import 'package:shop_app/modals/product_modal.dart';

class CartProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<CartProductModal> cartProducts = [];
  late Map<String, CartProductModal> cartProductsAsMap;

  List<CartProductModal> get getCartProducts =>
      cartProducts = cartProductsAsMap.values.toList();
  final userId = AuthHelper.userId;

  Future fetchAndSetUserCartProducts() async {
    cartProductsAsMap = {};
    final userCartProducts =
        await _firestore.collection(USERS).doc(userId).collection(CART).get();

    userCartProducts.docs.forEach((currentCartProduct) {
      cartProductsAsMap.putIfAbsent(currentCartProduct.id,
          () => CartProductModal.fromJson(currentCartProduct.data()));
    });

    notifyListeners();
  }

  Future toggleProductCartValue({
    required String productId,
    required ProductModal productModal,
  }) async {
    CartProductModal cartProductModal = CartProductModal(
      productModal: productModal,
      amount: 1,
      productId: productId,
    );
    if (cartProductsAsMap.containsKey(productId) == false) {
      cartProductsAsMap.putIfAbsent(productId, () => cartProductModal);
      notifyListeners();
      try {
        await _firestore
            .collection(USERS)
            .doc(userId)
            .collection(CART)
            .doc(productId)
            .set(cartProductModal.toJson());
      } on FirebaseException catch (e) {
        cartProductsAsMap.remove(productId);
        notifyListeners();
        throw e;
      }
    } else {
      cartProductsAsMap.remove(productId);
      notifyListeners();
      try {
        await _firestore
            .collection(USERS)
            .doc(userId)
            .collection(CART)
            .doc(productId)
            .delete();
      } on FirebaseException catch (e) {
        //cartProductsIds.add(productId);
        cartProductsAsMap.putIfAbsent(productId, () => cartProductModal);
        notifyListeners();
        throw e;
      }
    }
  }
  void increaseAmount({required String productId})async{
    cartProductsAsMap[productId]!.amount = cartProductsAsMap[productId]!.amount+1;
    notifyListeners();
    try {
      await _firestore
          .collection(USERS)
          .doc(userId)
          .collection(CART)
          .doc(productId)
          .update({
        'amount' : cartProductsAsMap[productId]!.amount,
      });
    } on FirebaseException catch (e) {
      cartProductsAsMap[productId]!.amount = cartProductsAsMap[productId]!.amount-1;
      notifyListeners();
      throw e;
    }
  }
  void decreaseAmount({required String productId})async{
    if(cartProductsAsMap[productId]!.amount != 1){
      cartProductsAsMap[productId]!.amount = cartProductsAsMap[productId]!.amount - 1;
      notifyListeners();
      try {
        await _firestore
            .collection(USERS)
            .doc(userId)
            .collection(CART)
            .doc(productId)
            .update({
          'amount' : cartProductsAsMap[productId]!.amount,
        });
      } on FirebaseException catch (e) {
        cartProductsAsMap[productId]!.amount = cartProductsAsMap[productId]!.amount + 1;
        notifyListeners();
        throw e;
      }
    }
  }

  Future removeCartItem({required String productId}) async {
    cartProductsAsMap.remove(productId);
    notifyListeners();
    try {
      await _firestore
          .collection(USERS)
          .doc(userId)
          .collection(CART)
          .doc(productId)
          .delete();
    } on FirebaseException catch (e) {
      // cartProductsAsMap.putIfAbsent(productId, () => cartProductModal);
      // notifyListeners();
      throw e;
    }
  }

  int get cartItemsLength => cartProductsAsMap.length;

  double get getTotalPayment {
    double total = 0.0;
    cartProductsAsMap.forEach((productId, currentCartProduct) {
      total += currentCartProduct.amount *
          double.parse(currentCartProduct.productModal.price!);
    });
    return total;
  }

// double get getTotalPayment{
//   double total = 0.0;
//  cartProducts.forEach((currentCartProduct) {
//    total += currentCartProduct.amount * double.parse(currentCartProduct.productModal.price!);
//
//  });
//   return total;
// }
}
