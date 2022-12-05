import 'package:shop_app/modals/product_modal.dart';

class FavoriteProductModal {
  late ProductModal productModal;
  late String productId;

  FavoriteProductModal({
    required this.productModal,
    required this.productId,
  });

  FavoriteProductModal.fromJson(json) {
    productModal = ProductModal.fromJson(json['productModal']);
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
      'productId': productId,
    };
  }
}
