
import 'package:foto_share/content/Suplementos/firebase/firestore_db.dart';
import 'package:foto_share/content/Suplementos/models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  // Add a list of Product objects.
  final products = <Product>[].obs;

  @override
  void onInit() {
    products.bindStream(FirestoreDB().getAllProducts());
    super.onInit();
  }
}
