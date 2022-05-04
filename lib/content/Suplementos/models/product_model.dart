import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  // Product's variables: name, price, imageUrl. All required.
  final String name;
  final double price;
  final String imageUrl;

  const Product({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
  static const List<Product> products = [
    Product(
        name: 'Nutricost Whey Protein',
        price: 2.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71f+e1iBprL._AC_SY606_.jpg'),
    Product(
        name: 'Legion Whey Protein',
        price: 9.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71ygMyeEfuL._AC_SX569_.jpg'),
    Product(
        name: 'Dymatize ISO 100 Protein',
        price: 5.00,
        imageUrl:
            'https://m.media-amazon.com/images/I/616bK2U-6WL._AC_SX425_.jpg'),
    Product(
        name: 'Evolution WP100 Protein',
        price: 10.00,
        imageUrl:
            'https://www.evolutionenc.com/wp-content/uploads/2022/03/WP100-Chocolate-800-g-600x600.png'),
    Product(
        name: 'L-glutamina HighPower',
        price: 7.50,
        imageUrl:
            'https://cdn.shopify.com/s/files/1/0276/2063/8800/products/17407_2e030afe-8394-4754-8e6f-a77a9230f6a4_643x643.jpg')
  ];
}
