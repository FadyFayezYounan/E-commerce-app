
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/helpers/end_points.dart';
import 'package:shop_app/modals/product_modal.dart';
class CategoriesProvider extends ChangeNotifier{

  final _firestore = FirebaseFirestore.instance;

  /// get women products
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


  /// get men products
  List<ProductModal> menProducts = [];
  List<String> menProductIds = [];
  Future getMenProducts()async{
    menProducts = [];
    menProductIds =[];
    final allMenProducts = await _firestore.collection(PRODUCTS).where('category',isEqualTo: 'men').get();
    allMenProducts.docs.forEach((currentMenProduct) async {
      menProductIds.add(currentMenProduct.id);
      menProducts.add(ProductModal.fromJson(currentMenProduct.data()));
    });
    notifyListeners();
  }


  /// get teen products
  List<ProductModal> teenProducts = [];
  List<String> teenProductIds = [];
  Future getTeenProducts()async{
    teenProducts = [];
    teenProductIds =[];
    final allTeenProducts = await _firestore.collection(PRODUCTS).where('category',isEqualTo: 'teen').get();
    allTeenProducts.docs.forEach((currentTeenProduct) async {
      teenProductIds.add(currentTeenProduct.id);
      teenProducts.add(ProductModal.fromJson(currentTeenProduct.data()));
    });
    notifyListeners();
  }


  /// get kids products
  List<ProductModal> kidsProducts = [];
  List<String> kidsProductIds = [];
  Future getKidsProducts()async{
    kidsProducts = [];
    kidsProductIds =[];
    final allKidsProducts = await _firestore.collection(PRODUCTS).where('category',isEqualTo: 'kids').get();
    allKidsProducts.docs.forEach((currentKidProduct) async {
      kidsProductIds.add(currentKidProduct.id);
      kidsProducts.add(ProductModal.fromJson(currentKidProduct.data()));
    });
    notifyListeners();
  }
}