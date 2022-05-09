import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class RutinaPage extends StatefulWidget {
  final rutina;
  RutinaPage({Key? key, this.rutina}) : super(key: key);

  @override
  State<RutinaPage> createState() => _RutinaPageState();
}

class _RutinaPageState extends State<RutinaPage> {
  //List<dynamic> _exercises = widget.rutina["ejercicios"];
  // generateExerciseCard(List<dynamic> exercises) {
  //   for (var item in exercises) {
  //     return Card(child: ListTile(title: Text("${item["nombre"]}")));
  //   }
  // }

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
      body: SingleChildScrollView(
        // alignment: Alignment.center,
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
            //divider
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1,
              color: Colors.grey,
            ),

            Container(
                // container with the title for exercises
                padding: EdgeInsets.all(20),
                child: Text(
                  "Ejercicios",
                  style: TextStyle(fontSize: 20),
                )),
            //create a list of expanded cards with the exercises
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(20),
                shrinkWrap: true,
                itemCount: widget.rutina["ejercicios"].length,
                itemBuilder: (context, index) {
                  return ExpansionTileCard(
                      animateTrailing: true,
                      title: Text(
                          "${widget.rutina["ejercicios"][index]["titulo"]}",
                          style: TextStyle(
                            fontSize: 18,
                            //fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text(
                        "${widget.rutina["ejercicios"][index]["tipo"]}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      children: [
                        //show images and description of the exercises
                        Column(children: [
                          Image.network(
                            "${widget.rutina["ejercicios"][index]["imagen"]}",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "${widget.rutina["ejercicios"][index]["descripcion"]}",
                            ),
                          ),
                        ]),
                      ]);
                }),
          ]),
        ),
      ),
    );
  }
}
