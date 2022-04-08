import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ItemExercise extends StatefulWidget {
  final Map<String, dynamic> publicFData;
  ItemExercise({Key? key, required this.publicFData}) : super(key: key);

  @override
  State<ItemExercise> createState() => _ItemExerciseState();
}

class _ItemExerciseState extends State<ItemExercise> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
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
              subtitle: Text("${widget.publicFData["tipo"]}"),
              trailing: Wrap(
                children: [
                  IconButton(
                    tooltip: "Compartir",
                    icon: Icon(Icons.share),
                    onPressed: () async {
                      final urlImage = widget.publicFData["picture"];
                      final url = Uri.parse(urlImage);
                      final response = await http.get(url);
                      final bytes = response.bodyBytes;

                      final temp = await getTemporaryDirectory();
                      final path = '${temp.path}/image.jpg';
                      File(path).writeAsBytesSync(bytes);

                      final date = widget.publicFData["publishedAt"].toDate();

                      await Share.shareFiles([path],
                          subject: widget.publicFData["title"],
                          text: widget.publicFData["Descripcion"]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
