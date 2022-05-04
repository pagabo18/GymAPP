import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foto_share/content/nutricion/nutricionview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;


class ItemNutricion extends StatefulWidget {

  final Map<String, dynamic> nutricionFData;

  ItemNutricion({Key? key, required this.nutricionFData}) : super(key: key);

  @override
  State<ItemNutricion> createState() => _ItemNutricionState();
}

class _ItemNutricionState extends State<ItemNutricion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () {
          print("${widget.nutricionFData["nombre"]}");
//
          var _nombre = "${widget.nutricionFData["nombre"]}";
          var _descripcion = "${widget.nutricionFData["descripcion"]}";
          var _imagen = "${widget.nutricionFData["imagen"]}";
          var _cuando = "${widget.nutricionFData["cuando"]}";

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NutricionPage(nutricion: {
              "nombre": _nombre,
              "descripcion": _descripcion,
              "imagen": _imagen,
              "cuando": _cuando
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
                  "${widget.nutricionFData["imagen"]}",
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text("${widget.nutricionFData["nombre"]}"),
                trailing: Wrap(
                    children: [
                      IconButton(
                        tooltip: "Compartir",
                        icon: Icon(Icons.share),
                        onPressed: () async {
                          final urlImage = widget.nutricionFData["imagen"];
                          final url = Uri.parse(urlImage);
                          final response = await http.get(url);
                          final bytes = response.bodyBytes;

                          final temp = await getTemporaryDirectory();
                          final path = '${temp.path}/image.jpg';
                          File(path).writeAsBytesSync(bytes);

                          await Share.shareFiles(
                            [path],
                            subject: widget.nutricionFData["nombre"],
                            text: widget.nutricionFData["descripcion"]
                          );
                        },
                      ),
                    ],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}