import 'dart:io';

class ProductCollectionModal {
  String? color;
  dynamic imagesUrl;

  /// imagesPaths --> just for the admin
  List<File?>? imagesPaths;



  ProductCollectionModal({
    this.color,
    this.imagesPaths,
    this.imagesUrl,
  });

  ProductCollectionModal.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    imagesUrl = json['imagesUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'imagesUrl': imagesUrl,
    };
  }
}
