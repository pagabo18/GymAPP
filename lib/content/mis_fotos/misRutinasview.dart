import 'package:flutter/material.dart';

class MisRutinasPage extends StatefulWidget {
  final rutina;
  MisRutinasPage({Key? key, this.rutina}) : super(key: key);

  @override
  State<MisRutinasPage> createState() => _MisRutinasPageState();
}

class _MisRutinasPageState extends State<MisRutinasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("${widget.rutina["nombre"]}"),
        flexibleSpace: Container(
          height: 120,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.purple]),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network("${widget.rutina["imagen"]}"),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "${widget.rutina["descripcion"]}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}