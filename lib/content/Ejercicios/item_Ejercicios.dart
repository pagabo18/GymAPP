import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foto_share/content/Ejercicios/ejerciciosview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ItemExercise extends StatefulWidget {
  final Map<String, dynamic> ejercicioData;
  ItemExercise({Key? key, required this.ejercicioData}) : super(key: key);

  @override
  State<ItemExercise> createState() => _ItemExerciseState();
}

class _ItemExerciseState extends State<ItemExercise> {
  var selected = "yoga";
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                print("${widget.ejercicioData["titulo"]}");
//
                var _nombre = "${widget.ejercicioData["titulo"]}";
                var _descripcion = "${widget.ejercicioData["descripcion"]}";
                var _imagen = "${widget.ejercicioData["imagen"]}";
                var _tipo = "${widget.ejercicioData["tipo"]}";

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EjerciciosPage(ejercicio: {
                    "titulo": _nombre,
                    "descripcion": _descripcion,
                    "imagen": _imagen,
                    "tipo": _tipo
                  }),
                ));
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    //create a dropdown button
                    DropdownButton(
                      value: selected,
                      items: [
                        DropdownMenuItem(
                          child: Text("yoga"),
                          value: "yoga",
                        ),
                        DropdownMenuItem(
                          child: Text("Pecho"),
                          value: "Pecho",
                        ),
                        DropdownMenuItem(
                          child: Text("Biceps"),
                          value: "Bicep",
                        ),
                      ],
                      onChanged: (Object? value) {
                        setState(() {
                          // //add the value to the selected list
                          selected = value.toString();
                        });
                      },
                    ),

                    //create a button filter for widget.exercises by type selected and show only the ones that match
                    widget.ejercicioData["tipo"] == selected
                        ? Column(children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                "${widget.ejercicioData["imagen"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            ListTile(
                              title: Text("${widget.ejercicioData["titulo"]}"),
                              subtitle: Text("${widget.ejercicioData["tipo"]}"),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    tooltip: "Compartir",
                                    icon: Icon(Icons.share),
                                    onPressed: () async {
                                      final urlImage =
                                          widget.ejercicioData["imagen"];
                                      final url = Uri.parse(urlImage);
                                      final response = await http.get(url);
                                      final bytes = response.bodyBytes;

                                      final temp =
                                          await getTemporaryDirectory();
                                      final path = '${temp.path}/image.jpg';
                                      File(path).writeAsBytesSync(bytes);

                                      await Share.shareFiles([path],
                                          subject:
                                              widget.ejercicioData["titulo"],
                                          text: widget
                                              .ejercicioData["descripcion"]);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ])

                        //
                        //
                        // Container(
                        //     height: 200,
                        //     width: 200,
                        //     decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //         image: NetworkImage(
                        //             widget.ejercicioData["imagen"]),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     child: Container(
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Text(
                        //           widget.ejercicioData["titulo"],
                        //           style: TextStyle(fontSize: 20),
                        //         ),
                        //       ),
                        //     ),
                        //   )
                        : Container(),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     widget.ejercicioData["titulo"],
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     widget.ejercicioData["descripcion"],
                    //     style: TextStyle(fontSize: 15),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     widget.ejercicioData["tipo"],
                    //     style: TextStyle(fontSize: 15),
                    //   ),
                    // ),

                    // AspectRatio(
                    //   aspectRatio: 16 / 9,
                    //   child: Image.network(
                    //     "${widget.ejercicioData["imagen"]}",
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text("${widget.ejercicioData["titulo"]}"),
                    //   subtitle: Text("${widget.ejercicioData["tipo"]}"),
                    //   trailing: Wrap(
                    //     children: [
                    //       IconButton(
                    //         tooltip: "Compartir",
                    //         icon: Icon(Icons.share),
                    //         onPressed: () async {
                    //           final urlImage = widget.ejercicioData["imagen"];
                    //           final url = Uri.parse(urlImage);
                    //           final response = await http.get(url);
                    //           final bytes = response.bodyBytes;

                    //           final temp = await getTemporaryDirectory();
                    //           final path = '${temp.path}/image.jpg';
                    //           File(path).writeAsBytesSync(bytes);

                    //           await Share.shareFiles([path],
                    //               subject: widget.ejercicioData["titulo"],
                    //               text: widget.ejercicioData["descripcion"]);
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
