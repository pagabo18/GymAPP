import 'package:flutter/material.dart';

class ItemEspera extends StatefulWidget {
  final Map<String, dynamic> nonPublicFData;
  ItemEspera({Key? key, required this.nonPublicFData}) : super(key: key);

  @override
  State<ItemEspera> createState() => _ItemEsperaState();
}

class _ItemEsperaState extends State<ItemEspera> {
  bool _switchValue = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                "${widget.nonPublicFData["imagen"]}",
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text("${widget.nonPublicFData["nombre"]}"),
              subtitle: Text("${widget.nonPublicFData["subtitulo"]}"),
             
            ),
          ],
        ),
      ),
    );
  }

  // Future editDialog(
  //         String title, String description, bool publico, String uid) =>
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text("Editar"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               decoration: InputDecoration(
  //                 labelText: "Título",
  //               ),
  //             ),
  //             TextField(
  //               decoration: InputDecoration(
  //                 labelText: "Descripción",
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           FlatButton(
  //             child: Text("Cancelar"),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //           FlatButton(
  //             child: Text("Aceptar"),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //         ],
  //       ),
  //     );
}
