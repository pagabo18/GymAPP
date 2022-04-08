import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:foto_share/content/Ejercicios/item_Ejercicios.dart';

class Ejercicios extends StatelessWidget {
  const Ejercicios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
        query: FirebaseFirestore.instance.collection('gymEjercicioSelect'),
        itemBuilder: (BuildContext context,
            QueryDocumentSnapshot<Map<String, dynamic>> document) {
          return ItemExercise(publicFData: document.data());
        });
  }
}
