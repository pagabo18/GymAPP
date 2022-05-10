import 'package:foto_share/content/Suplementos/models/product_model.dart';
import 'package:get/get.dart';
class CartController extends GetxController {
  // Add a dict to store the products in the cart.
  var _products = {}.obs;
  
  get products => _products;
  // create a getter if the total is null or 0, show 0
  get total => _products.isEmpty ? 0 : _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  get productSubtotal => _products.entries.isEmpty ? 0 : _products.entries	
      .map((product) => product.key.price * product.value)
      .toList();

  

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }



    Get.snackbar(
      "Product Added",
      "You have added the ${product.name} to the cart",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
    if (_products[product] == 0) {
      _products.removeWhere((key, value) => key == product);
    }
  }

  
}