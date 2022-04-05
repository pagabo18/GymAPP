import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


part 'create_event.dart';
part 'create_state.dart';


class CreateBloc extends Bloc<CreateEvent, CreateState>{
  File? _selectedPicture;

  CreateBloc() :super(CreateInitial()){
    on<OnCreateTakePictureEvent>(_takePicture);
    on<OnCreateSaveDataEvent>(_saveData);
  }

  FutureOr<void> _saveData(OnCreateSaveDataEvent event, emit) async{
    emit(CreateLoadingState());
    bool saved = await _saveFshare(event.dataToSave);
    emit(saved ? CreateSuccessState() : CreateFshareErrorState());
  }
  Future<bool> _saveFshare(Map<String, dynamic> dataToSave) async{
    try{
      String _imageUrl = await _uploadPictureToStorage();
      if(_imageUrl != ""){
        dataToSave["picture"] = _imageUrl;
        dataToSave["publishedAt"] = Timestamp.fromDate(DateTime.now());
        dataToSave ["stars"]=0;
        dataToSave["username"]=FirebaseAuth.instance.currentUser!.displayName;
      }else {
        return false;
      }

      // Guardar Fshare en cloud Firestore
      var docRef =
        await FirebaseFirestore.instance.collection("fshare").add(dataToSave);
      // Actualizar lista de fotoShare en collections users
      return await _updateUserDocumentrReference(docRef.id);

    } catch (e){
      print("Error al crear Fshare: $e");
      return false;
    }
  }

  Future<String> _uploadPictureToStorage() async{
    try{
      var stamp = DateTime.now();
      if(_selectedPicture == null){
        return "";
      }

      // definir upload task
      UploadTask task = FirebaseStorage.instance
          .ref("fshares/imagen_${stamp}.png")
          .putFile(_selectedPicture!);
      // ejecutar la tasks
      await task;
      // Recuperar la Url del archivo
      return await task.storage
      .ref("fshares/imagen_${stamp}.png")
      .getDownloadURL();

    } catch (e){
      return "";
    }
  }

  Future<bool>_updateUserDocumentrReference(String fshareId) async {
    try{
      // query para traer el documento con el id del usuario autenticado
      var queryUser = await FirebaseFirestore.instance
          .collection("user")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");

      // query para sacar la data del documento
      var docsRef = await queryUser.get();
      List<dynamic> listIds = docsRef.data()?["fotosListId"];

      // Agregamos nuevo ID 
      listIds.add(fshareId);

      // Guardar
      await queryUser.update({"fotosListId": listIds});
      return true;
    }catch (e){
      print("Error al actualizar Users Collection: $e");
      return false;
    }
  }
  FutureOr<void> _takePicture(event, emit) async {
    emit(CreateLoadingState());
    await _getImage();

    if(_selectedPicture != null)
      emit(CreatePictureChangedState(picture: _selectedPicture!));
    else
      emit(CreatePictureErrorState());
  }

  Future<void> _getImage() async{
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    if(pickedFile != null ){
      _selectedPicture = File(pickedFile.path);
    }else{
      print('No image selected');
      _selectedPicture = null;
    }

  }

}
