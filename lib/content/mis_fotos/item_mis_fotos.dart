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
              subtitle: Text(
                "${widget.nonPublicFData["subtitulo"]}",
              ),
              //add a trailing delete icon to the ListTile
              trailing: Wrap(children: [
                IconButton(
                    onPressed: () {
                      //show confirmation dialogue
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text("Eliminar"),
                                content: Text(
                                    "¿Estás seguro de que quieres eliminar la rutina '${widget.nonPublicFData["nombre"]}'?"),
                                actions: [
                                  TextButton(
                                    child: Text("Cancelar",
                                        style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                      child: Text(
                                        "Eliminar",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onPressed: () {
                                        //delete the item
                                        Navigator.of(context).pop();
                                      })
                                ]);
                          });
                    },
                    icon: Icon(Icons.delete)),
              ]),
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
