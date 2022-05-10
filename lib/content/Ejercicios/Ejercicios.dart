import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:foto_share/content/Ejercicios/item_Ejercicios.dart';
import 'package:get/get.dart';

import 'ejerciciosview.dart';

class Ejercicios extends StatelessWidget {
  const Ejercicios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        lista(context),
        FirestoreListView(
            shrinkWrap: true,
            query: FirebaseFirestore.instance.collection('gymEjercicio'),
            itemBuilder: (BuildContext context,
                QueryDocumentSnapshot<Map<String, dynamic>> document) {
              return ItemExercise(
                ejercicioData: document.data(),
              );
            })
      ]),
    );

    // FirestoreListView(
    //     query: FirebaseFirestore.instance.collection('gymEjercicio'),
    //     itemBuilder: (BuildContext context,
    //         QueryDocumentSnapshot<Map<String, dynamic>> document) {
    //       return ItemExercise(ejercicioData: document.data());
    //     });
  }
}

class lista extends StatefulWidget {
  lista(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<lista> createState() => _listaState();
}

class _listaState extends State<lista> {
  var selected = "Yoga";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DropdownButton(
            value: selected,
            items: [
              DropdownMenuItem(
                child: Text("Yoga"),
                value: "Yoga",
              ),
              DropdownMenuItem(
                child: Text("Pecho"),
                value: "Pecho",
              ),
              DropdownMenuItem(
                child: Text("Biceps"),
                value: "Bicep",
              ),
              DropdownMenuItem(
                child: Text("Abdomen"),
                value: "Abdomen",
              ),
              DropdownMenuItem(
                child: Text("Estiramiento"),
                value: "Estiramiento",
              ),
              DropdownMenuItem(
                child: Text("Espalda"),
                value: "Espalda",
              ),
            ],
            onChanged: (Object? value) {
              setState(() {
                // //add the value to the selected list
                selected = value.toString();
              });
            },
          ),
          Container(
            child: FirestoreListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                query: FirebaseFirestore.instance.collection('gymEjercicio'),
                itemBuilder: (BuildContext context,
                    QueryDocumentSnapshot<Map<String, dynamic>> document) {
                  return ItemExercise(
                    ejercicioData: document.data(),
                    selected: selected,
                  );
                }),
          )
        ],
      ),
    );
  }
}

// FirestoreListView(
//         query: FirebaseFirestore.instance.collection('gymEjercicio'),
//         itemBuilder: (BuildContext context,
//             QueryDocumentSnapshot<Map<String, dynamic>> document) {
//           return ItemExercise(ejercicioData: document.data());
//         });

          // DropdownButton(
          //   value: selected,
          //   items: [
          //     DropdownMenuItem(
          //       child: Text("yoga"),
          //       value: "yoga",
          //     ),
          //     DropdownMenuItem(
          //       child: Text("Pecho"),
          //       value: "Pecho",
          //     ),
          //     DropdownMenuItem(
          //       child: Text("Biceps"),
          //       value: "Bicep",
          //     ),
          //   ],
          //   onChanged: (Object? value) {
          //     setState(() {
          //       // //add the value to the selected list
          //       selected = value.toString();
          //     });
          //   },
          // ),