import 'package:flutter/material.dart';
import 'package:foto_share/content/Suplementos/controllers/cart_controller.dart';
import 'package:foto_share/content/Suplementos/controllers/product_controller.dart';
import 'package:foto_share/content/Suplementos/models/product_model.dart';
import 'package:get/get.dart';

class CatalogProducts extends StatelessWidget {

  CatalogProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      
        child: ListView.builder(
          
            itemCount: Product.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CatalogProductCard(index: index);
            }),
      );
  }
}

class CatalogProductCard extends StatelessWidget {
  final cartController = Get.put(CartController());
  final int index;

  CatalogProductCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              Product.products[index].imageUrl,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              Product.products[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Text('${Product.products[index].price}'),
          ),
          IconButton(
            onPressed: () {
              cartController.addProduct(Product.products[index]);
            },
            icon: Icon(
              Icons.add_circle,
            ),
          ),
        ],
      ),
    );
  }
}