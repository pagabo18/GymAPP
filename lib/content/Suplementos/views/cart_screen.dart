import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foto_share/content/Suplementos/cart_products.dart';
import 'package:foto_share/content/Suplementos/cart_total.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';


class CartScreen extends StatelessWidget {
  
  CartScreen({Key? key}) : super(key: key);
  ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Your Cart"),
        flexibleSpace: Container(
          height: 120,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.purple]),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _tomarScreenshotyCompartir();
              print("take screen");
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              CartProducts(),
              CartTotal(),
            ],
          ),
        ),
      ),
    );
  }
  void _tomarScreenshotyCompartir() async {
	final uint8List = await _screenshotController.capture();
	String tempPath = (await getTemporaryDirectory()).path;
	File file = File('$tempPath/image.png');
	await file.writeAsBytes(uint8List!);
	await Share.shareFiles([file.path]);
  }
}