import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foto_share/content/Suplementos/api/google_auth_api.dart';
import 'package:foto_share/content/Suplementos/cart_products.dart';
import 'package:foto_share/content/Suplementos/cart_total.dart';
import 'package:foto_share/content/Suplementos/controllers/cart_controller.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final CartController controller = Get.find();
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
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                primary: Colors.deepPurple,
              ),
              onPressed: () => controller.total == 0 ? null : sendEmail(),
              child: Text('Confirmar Pago'),
            ),
            SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
    
  }
  
  Future sendEmail() async{
    final user = await GoogleAuthApi.signIn();
    final auth = await GoogleAuthApi.authU();

    if(user == null) return;

    final email = user.email;
    //final auth = await user!.authentication;
    final token = auth.accessToken!;

    final uint8List = await _screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/image.png');
    await file.writeAsBytes(uint8List!);

    final sntpServer = gmailSaslXoauth2(email, token);
    final message = Message()
      ..from = Address('diegolepel@gmail.com', 'GymApp')
      ..recipients = [email] //A quien le quieres manndar (destino)
      //..recipients = ['alvinsaurhq@gmail.com'] //A quien le quieres manndar (destino)
      ..subject = 'Confirmation'
      ..text = 'Monto Total : ${controller.total}'
      ..html = '<h1>Your Purchase Confirmation</h1>\n<p>Here are the list of products </p><img src="cid:myimg@3.141"/>'
      ..attachments = [
      FileAttachment(File('$tempPath/image.png'))
        //..location = Location.inline
        ..cid = '<myimg@3.141>'
    ];
    try{
      await send(message, sntpServer);
      
      Get.snackbar(
      "Pedido creado exitosamente!",
      "Tu pedido ha sido creado exitosamente, se envio confirmación a su corrreo",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
    }on MailerException catch(e){
      print(e);
    }
  }
  void _tomarScreenshotyCompartir() async {
	final uint8List = await _screenshotController.capture();
	String tempPath = (await getTemporaryDirectory()).path;
	File file = File('$tempPath/image.png');
	await file.writeAsBytes(uint8List!);
	await Share.shareFiles([file.path]);
  }
  
}