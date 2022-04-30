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
      imageUrl: 'https://m.media-amazon.com/images/I/71f+e1iBprL._AC_SY606_.jpg'
    ),
     Product(
      name: 'Legion Whey Protein',
      price: 9.99,
      imageUrl: 'https://m.media-amazon.com/images/I/71ygMyeEfuL._AC_SX569_.jpg'
    ),
     Product(
      name: 'Dymatize ISO 100 Protein',
      price: 5.00,
      imageUrl: 'https://m.media-amazon.com/images/I/616bK2U-6WL._AC_SX425_.jpg'
    )
  ];
}