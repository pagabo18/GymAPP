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
    _switchValue = widget.nonPublicFData["public"];
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
                "${widget.nonPublicFData["picture"]}",
                fit: BoxFit.cover,
              ),
            ),
            SwitchListTile(
              title: Text("${widget.nonPublicFData["title"]}"),
              subtitle:
                  Text("${widget.nonPublicFData["publishedAt"].toDate()}"),
              value: _switchValue,
              onChanged: (newVal) {
                setState(() {
                  _switchValue = newVal;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Text("${widget.nonPublicFData["public"]}"),
                  onPressed: () {
                    // editDialog(
                    //     widget.nonPublicFData['title'],
                    //     widget.nonPublicFData['description'],
                    //     widget.nonPublicFData['public'],
                    //     widget.nonPublicFData['id']);
                    // Navigator.of(context).push(value: widget.nonPublicFData['id']);
                  },
                ),
                MaterialButton(child: Icon(Icons.star), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future editDialog(
          String title, String description, bool publico, String uid) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Editar"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Título",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Descripción",
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Aceptar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
}
