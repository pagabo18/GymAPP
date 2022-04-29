import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:foto_share/content/Suplementos/models/product_model.dart';

class FirestoreDB{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Product>> getAllProducts(){
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot){
          return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
        });
  }

}