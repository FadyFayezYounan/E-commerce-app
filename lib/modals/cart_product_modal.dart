import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/helpers/auth_helper.dart';
import 'package:shop_app/helpers/end_points.dart';
import 'package:shop_app/modals/product_modal.dart';
import 'package:flutter/foundation.dart';

class CartProductModal extends ChangeNotifier{
  late ProductModal productModal;
  late int amount;
  late String productId;

  CartProductModal({
    required this.productModal,
    required this.amount,
    required this.productId,
  });

  CartProductModal.fromJson(json) {
    productModal = ProductModal.fromJson(json['productModal']);
    amount = json['amount'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final jsonProduct = ProductModal(
      name: productModal.name,
      price: productModal.price,
      oldPrice: productModal.oldPrice,
      discount: productModal.discount,
      description: productModal.description,
      imageUrl: productModal.imageUrl,
    );
    return {
      'productModal': jsonProduct.toJson(),
      'amount': amount,
      'productId': productId,
    };
  }


  final _firestore = FirebaseFirestore.instance;
  final userId = AuthHelper.userId;

  void increaseAmount({required String productId})async{
    amount = amount + 1;
    notifyListeners();
    try {
      await _firestore
          .collection(USERS)
          .doc(userId)
          .collection(CART)
          .doc(productId)
          .update({
        'amount' : amount,
      });
    } on FirebaseException catch (e) {
      amount = amount - 1;
      notifyListeners();
      throw e;
    }
  }
  void decreaseAmount({required String productId})async{
    if(amount != 1){
      amount = amount - 1;
      notifyListeners();
      try {
        await _firestore
            .collection(USERS)
            .doc(userId)
            .collection(CART)
            .doc(productId)
            .update({
          'amount' : amount,
        });
      } on FirebaseException catch (e) {
        amount = amount + 1;
        notifyListeners();
        throw e;
      }
    }
  }
}
