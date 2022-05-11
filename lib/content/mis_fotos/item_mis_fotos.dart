import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../rutinas/rutinaview.dart';
import 'bloc/misFotos_bloc.dart';

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
              child: GestureDetector(
                onTap: () async {
                  var _nombre = "${widget.nonPublicFData["nombre"]}";
                  var _descripcion = "${widget.nonPublicFData["descripcion"]}";
                  var _imagen = "${widget.nonPublicFData["imagen"]}";
                  //print("$_nombre $_descripcion $_imagen");
                  var _rutinaEjers = widget.nonPublicFData["ejercicios"];
                  //print("ejercicios en la rutina: $_rutinaEjers");
                  List<dynamic> _exercises = [];
                  //obtain the exercises from the database

                  var _collection =
                      FirebaseFirestore.instance.collection("gymEjercicio");
                  var _ejercicios = await _collection.get();
                  //print("numero de ejercicios: ${_ejercicios.docs.length}");
                  //add the exercises to the list
                  for (var item in _rutinaEjers) {
                    //print("checking for item: $item");
                    for (var query in _ejercicios.docs) {
                      //print("checking for query: ${query.id}");

                      if (query.id == item) {
                        _exercises.add(query.data());
                      }
                    }
                  }
//          print("ejercicios en la rutina: ${_exercises}");

                  // for (var query in _ejercicios.docs) {
                  //   Map<String, dynamic> data = query.data();
                  //   print("data in ${query.id}: $data");

                  // }

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RutinaPage(rutina: {
                      "nombre": _nombre,
                      "descripcion": _descripcion,
                      "imagen": _imagen,
                      "ejercicios": _exercises,
                    }),
                  ));
                },
                child: Image.network(
                  "${widget.nonPublicFData["imagen"]}",
                  fit: BoxFit.cover,
                ),
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
                                        BlocProvider.of<misFotosBloc>(context)
                                            .add(
                                          DestroyRoutineEvent(
                                              nombre: widget
                                                  .nonPublicFData["nombre"]),
                                        );
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
