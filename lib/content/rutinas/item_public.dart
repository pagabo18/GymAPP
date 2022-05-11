import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foto_share/content/rutinas/rutinaview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ItemPublic extends StatefulWidget {
  final Map<String, dynamic> publicFData;
  ItemPublic({Key? key, required this.publicFData}) : super(key: key);

  @override
  State<ItemPublic> createState() => _ItemPublicState();
}

class _ItemPublicState extends State<ItemPublic> {
  //future _getExercises async {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () async {
// get the document id from the map
          var _nombre = "${widget.publicFData["nombre"]}";
          var _descripcion = "${widget.publicFData["descripcion"]}";
          var _imagen = "${widget.publicFData["imagen"]}";
          //print("$_nombre $_descripcion $_imagen");
          var _rutinaEjers = widget.publicFData["ejercicios"];
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
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  "${widget.publicFData["imagen"]}",
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text("${widget.publicFData["nombre"]}"),
                subtitle: Text("${widget.publicFData["subtitulo"]}"),
                //trailing: Wrap(
                // children: [
                //   IconButton(
                //     tooltip: "Compartir",
                //     icon: Icon(Icons.share),
                //     onPressed: () async {
                //       final urlImage = widget.publicFData["picture"];
                //       final url = Uri.parse(urlImage);
                //       final response = await http.get(url);
                //       final bytes = response.bodyBytes;

                //       final temp = await getTemporaryDirectory();
                //       final path = '${temp.path}/image.jpg';
                //       File(path).writeAsBytesSync(bytes);

                //       final date = widget.publicFData["publishedAt"].toDate();

                //       await Share.shareFiles(
                //         [path],
                //         subject: widget.publicFData["title"],
                //         text: widget.publicFData["publishedAt"]
                //             .toDate()
                //             .toString(),
                //       );
                //     },
                //   ),
                // ],
                //),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
