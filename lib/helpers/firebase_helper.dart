import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/modals/user_modal.dart';

import 'end_points.dart';

class FirebaseHelper {
  static final _firestore = FirebaseFirestore.instance;

  static Future getProductById({required String productId}) async {
    var product = _firestore.collection(PRODUCTS).doc(productId).get();
    return product;
  }

  static Future getUserData({required String userId})async{

    final userData  = await _firestore.collection(USERS).doc(userId).get();


    return UserModal.fromJson(userData.data());

  }
}
