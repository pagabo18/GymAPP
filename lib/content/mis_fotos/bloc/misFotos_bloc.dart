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
  }

  FutureOr<void> _getMyContent(event, emit) async {
    emit(misFotosFotosLoadingState());
    try {
      // query para traer el documento con el id del usuario autenticado
      var queryUser = await FirebaseFirestore.instance
          .collection("user")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");

      // query para sacar la data del documento
      var docsRef = await queryUser.get();
      var listIds = docsRef.data()?["fotosListId"];

      // query para sacar documentos de fshare
      var queryFotos =
          await FirebaseFirestore.instance.collection("fshare").get();

      // query de Dart filtrando la info utilizando como referencia la lista de ids de docs del usuario actual
      var ListqueryFotos = queryFotos.docs
          .where((doc) =>
            listIds.contains(doc.id) )
          .map((doc) => doc.data().cast<String, dynamic>())
          .toList();

      // lista de documentos filtrados del usuario con sus datos de fotos en espera
      emit(misFotosFotosSuccessState(myEnableData: ListqueryFotos));
    } catch (e) {
      print("Error al obtener items en espera: $e");
      emit(misFotosFotosErrorState());
      emit(misFotosFotosEmptyState());
    }
  }
}