import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/content/agregar/bloc/create_bloc.dart';

class AddForm extends StatefulWidget {
  AddForm({Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  var _titleC = TextEditingController();
  var _imageLink = TextEditingController();
  var _description = TextEditingController();
  var _subtitulo = TextEditingController();
  bool _defaultSwitchValue = false;
  File? image;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateBloc, CreateState>(listener: (context, state) {
      if (state is CreatePictureErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al elegir imagen valida"),
          ),
        );
      } else if (state is CreateFshareErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al guardar Fshare"),
          ),
        );
      } else if (state is CreateSuccessState) {
        _titleC.clear();
        _defaultSwitchValue = false;
        image = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Guardado exitosamente..."),
          ),
        );
      } else if (state is CreatePictureChangedState) {
        image = state.picture;
      }
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(children: [
          image != null
              ? Image.file(
                  image!,
                  height: 120,
                )
              : Container(),
          SizedBox(height: 24),
          MaterialButton(
            child: Text("Agregar una rutina"),
            onPressed: () {
              // // BLoC tomar  foto
              // BlocProvider.of<CreateBloc>(context)
              //     .add(OnCreateTakePictureEvent());
            },
          ),
          SizedBox(height: 24),
          TextField(
              maxLength: 30,
              controller: _titleC,
              decoration: InputDecoration(
                focusColor: Colors.black,
                label: Text("Title", style: TextStyle(color: Colors.black)),
                border: OutlineInputBorder(),
              )),
          SizedBox(height: 24),
          TextField(
              controller: _subtitulo,
              decoration: InputDecoration(
                focusColor: Colors.black,
                label: Text("Subtitulo", style: TextStyle(color: Colors.black)),
                border: OutlineInputBorder(),
              )),
          SizedBox(height: 24),
          TextField(
              controller: _imageLink,
              decoration: InputDecoration(
                focusColor: Colors.black,
                label: Text("Link to image",
                    style: TextStyle(color: Colors.black)),
                border: OutlineInputBorder(),
              )),
          SizedBox(height: 24),
          TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _description,
              decoration: InputDecoration(
                focusColor: Colors.black,
                label:
                    Text("Description", style: TextStyle(color: Colors.black)),
                border: OutlineInputBorder(),
              )),
          SizedBox(height: 24),
          SwitchListTile(
            title: Text("Hacer publico"),
            value: _defaultSwitchValue,
            onChanged: (newValue) {
              _defaultSwitchValue = newValue;
              setState(() {});
            },
          ),
          SizedBox(height: 24),
          MaterialButton(
            child: Text("Guardar"),
            onPressed: () {
              Map<String, dynamic> fshareData = {};
              fshareData = {
                "title": _titleC.value.text,
                "public": _defaultSwitchValue,
              };
              BlocProvider.of<CreateBloc>(context)
                  .add(OnCreateSaveDataEvent(dataToSave: fshareData));
            },
          ),
        ]),
      );
    });
  }
}
