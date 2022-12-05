

import 'package:flutter/foundation.dart';

class ProductModal extends ChangeNotifier{
  String? name;
  String? price;
  String? oldPrice;
  String? discount;
  String? description;
  String? imageUrl;
  //bool? inFavorites;
  //Map<String?, List<String>?>? colorsAndImages;

  // void toggleInFavoriteStatus(){
  //   inFavorites = !inFavorites!;
  //   notifyListeners();
  // }
  ProductModal({
    this.name,
    this.price,
    this.oldPrice,
    this.discount,
    this.description,
    this.imageUrl,
    //this.inFavorites,
    //this.colorsAndImages,
  });

  ProductModal.fromJson(json) {
    name = json['name'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    //inFavorites = json['inFavorites'];
    //colorsAndImages = json['colorsAndImages'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'oldPrice': oldPrice,
      'discount': discount,
      'description': description,
      'imageUrl': imageUrl,
      //'inFavorites' : inFavorites,
      //'colorsAndImages': colorsAndImages,
    };
  }
}
