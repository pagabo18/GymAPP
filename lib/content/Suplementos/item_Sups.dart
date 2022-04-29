import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ItemSups extends StatefulWidget {
  final Map<String, dynamic> publicFData;
  ItemSups({Key? key, required this.publicFData}) : super(key: key);

  @override
  State<ItemSups> createState() => _ItemSupsState();
}

class _ItemSupsState extends State<ItemSups> {
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
