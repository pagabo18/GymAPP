import 'package:flutter/material.dart';
import 'package:foto_share/content/Suplementos/cart_products.dart';
import 'package:foto_share/content/Suplementos/cart_total.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        flexibleSpace: Container(
          height: 120,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.purple]),
          ),
        ),
      ),
      body: Column(
        children: [
          CartProducts(),
          CartTotal(),
        ],
      ),
    );
  }
}