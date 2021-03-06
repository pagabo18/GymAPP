import 'package:flutter/material.dart';
import 'package:foto_share/content/Ejercicios/Ejercicios.dart';

class EjerciciosPage extends StatefulWidget {
 //create a filter for the list of exercises
  
  
  final ejercicio;
  EjerciciosPage({Key? key, this.ejercicio}) : super(key: key);

  @override
  State<EjerciciosPage> createState() => _EjerciciosPageState();
}



class _EjerciciosPageState extends State<EjerciciosPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("${widget.ejercicio["titulo"]}"),
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
              Image.network("${widget.ejercicio["imagen"]}"),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "${widget.ejercicio["descripcion"]} ",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Tipo de ejercico: ${widget.ejercicio["tipo"]}",
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
