import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:foto_share/content/Suplementos/item_Sups.dart';

class Suplementos extends StatelessWidget {
  const Suplementos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
        query: FirebaseFirestore.instance.collection('gymSuplementos'),
        itemBuilder: (BuildContext context,
            QueryDocumentSnapshot<Map<String, dynamic>> document) {
          return ItemSups(publicFData: document.data());
        });
  }
}
