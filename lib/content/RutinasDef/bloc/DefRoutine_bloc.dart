import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'DefRoutine_event.dart';
part 'DefRoutine_state.dart';

class DefRoutineBloc extends Bloc<DefRoutineEvent, DefRoutineState> {
  DefRoutineBloc() : super(DefRoutineInitial()) {
    on<GetAllMyDisabledEvent>(_getMyDisabledContent);
  }

  FutureOr<void> _getMyDisabledContent(event, emit) async {
    emit(DefRoutineLoadingState());
    try {
      // query para traer el documento con el id del usuario autenticado
      // var queryUser = await FirebaseFirestore.instance
      //     .collection("user")
      //     .doc("${FirebaseAuth.instance.currentUser!.uid}");

      // // query para sacar la data del documento
      // var docsRef = await queryUser.get();
      // var listIds = docsRef.data()?["ListId"];

      // query para sacar documentos de fshare
      var query =
          await FirebaseFirestore.instance.collection("gymRutinasDef").get();

      // query de Dart filtrando la info utilizando como referencia la lista de ids de docs del usuario actual
      var myDisabledContentList =
          query.docs.map((doc) => doc.data().cast<String, dynamic>()).toList();

      // lista de documentos filtrados del usuario con sus datos de  en espera
      emit(DefRoutineSuccessState(myDisabledData: myDisabledContentList));
    } catch (e) {
      print("Error al obtener items en espera: $e");
      emit(DefRoutineErrorState());
      emit(DefRoutineEmptyState());
    }
  }
}
