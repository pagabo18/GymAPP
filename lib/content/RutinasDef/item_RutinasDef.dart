import 'package:flutter/material.dart';

class ItemRutinasDef extends StatefulWidget {
  final Map<String, dynamic> nonPublicFData;
  ItemRutinasDef({Key? key, required this.nonPublicFData}) : super(key: key);

  @override
  State<ItemRutinasDef> createState() => _ItemRutinasDefState();
}

class _ItemRutinasDefState extends State<ItemRutinasDef> {
  bool _switchValue = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
            SwitchListTile(
              title: Text("${widget.nonPublicFData["Nombre"]}"),
              subtitle: Text("${widget.nonPublicFData["Descripcion"]}"),
              value: _switchValue,
              onChanged: (newVal) {
                setState(() {
                  _switchValue = newVal;
                  widget.nonPublicFData["public"] = newVal;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
