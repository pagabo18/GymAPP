import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'misFotos_event.dart';
part 'misFotos_state.dart';

class misFotosBloc extends Bloc<misFotosEvent, misFotosState> {
  misFotosBloc() : super(misFotosInitial()) {
    on<GetAllMyFotosEvent>(_getMyContent);
    on<DestroyRoutineEvent>(_destroyRoutine);
  }

  Future<void> _destroyRoutine(DestroyRoutineEvent event, emit) async {
    //emit(misFotosFotosDeletingState());
    print("event name: ${event.nombre}");
    //get id of document with name event.nombre

    DocumentReference<Map<String, dynamic>> userCollection =
        await FirebaseFirestore.instance
            .collection('gymUser')
            .doc(FirebaseAuth.instance.currentUser!.uid);

    var id = await FirebaseFirestore.instance
        .collection("gymRutinasDef")
        .where("nombre", isEqualTo: event.nombre)
        .get()
        .then((value) => value.docs[0].id);
    print("id: $id");

    //delete document from firebase collection "gymRutinasDef"
    await FirebaseFirestore.instance
        .collection("gymRutinasDef")
        .doc(id)
        .delete();

    //delete string with same id from array 'rutinas' in collection 'users'

    Map<String, dynamic>? collection = (await userCollection.get()).data();

    List<dynamic> routines = collection!['rutinas'];

    //print("rutinas: $routines");

    routines.remove(id);

    //print("rutinas: $routines");

    await userCollection.update(<String, dynamic>{'rutinas': routines});

    // await FirebaseFirestore.instance
    //     .collection("gymUser")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .update({"rutinas": FieldValue.arrayRemove(id)});
    emit(misFotosFotosDeleteSuccessState());
  }

  FutureOr<void> _getMyContent(event, emit) async {
    emit(misFotosFotosLoadingState());
    try {
      // query para traer el documento con el id del usuario autenticado
      var queryUser = await FirebaseFirestore.instance
          .collection("gymUser")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");

      // query para sacar la data del documento
      var docsRef = await queryUser.get();
      var listIds = docsRef.data()?["rutinas"];

      // query para sacar documentos de fshare
      var queryFotos =
          await FirebaseFirestore.instance.collection("gymRutinasDef").get();

      // query de Dart filtrando la info utilizando como referencia la lista de ids de docs del usuario actual
      var ListqueryFotos = queryFotos.docs
          .where((doc) => listIds.contains(doc.id))
          .map((doc) => doc.data().cast<String, dynamic>())
          .toList();

      print("List of query fotos: ${ListqueryFotos}");

      // lista de documentos filtrados del usuario con sus datos de fotos en espera
      if (ListqueryFotos.isEmpty)
        emit(misFotosFotosEmptyState());
      else
        emit(misFotosFotosSuccessState(myEnableData: ListqueryFotos));
    } catch (e) {
      print("Error al obtener items en espera: $e");
      emit(misFotosFotosErrorState());
      emit(misFotosFotosEmptyState());
    }
  }
}
