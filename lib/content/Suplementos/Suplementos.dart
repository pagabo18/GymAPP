import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:foto_share/content/Suplementos/catalog_products.dart';
import 'package:foto_share/content/Suplementos/item_Sups.dart';
import 'package:foto_share/content/Suplementos/views/cart_screen.dart';
import 'package:get/get.dart';

class Suplementos extends StatelessWidget {
  const Suplementos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Catalog")),
      body: SafeArea(
        child: Column(
          children: [
            CatalogProducts(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                primary: Colors.deepPurple,
              ),
              onPressed: () => Get.to(() => CartScreen()),
              child: Text('Go to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
