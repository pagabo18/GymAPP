import 'package:flutter/material.dart';
import 'package:foto_share/content/nutricion/nutricion.dart';

class NutricionPage extends StatefulWidget {
  final nutricion;
  NutricionPage({Key? key, this.nutricion}) : super(key: key);

  @override
  State<NutricionPage> createState() => _NutricionPageState();
}

class _NutricionPageState extends State<NutricionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("${widget.nutricion["nombre"]}"),
        flexibleSpace: Container(
          height: 120,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.purple]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network("${widget.nutricion["imagen"]}"),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "${widget.nutricion["descripcion"]} ",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Uso: ${widget.nutricion["cuando"]}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
