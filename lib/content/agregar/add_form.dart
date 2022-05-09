

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
  var _subtitulo = TextEditingController();
  var _description = TextEditingController();
  var _nombre = TextEditingController();

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
        _nombre.clear();
        _description.clear();
        _subtitulo.clear();
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
            child: Text("Foto"),
            onPressed: () {
              // BLoC tomar  foto
              BlocProvider.of<CreateBloc>(context)
                  .add(OnCreateTakePictureEvent());
            },
          ),
          SizedBox(height: 24),
          TextField(
            controller: _nombre,
            decoration: InputDecoration(
              label: Text("Nombre"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24),
          TextField(
            controller: _description,
            decoration: InputDecoration(
              label: Text("descripcion"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24),
          TextField(
            controller: _subtitulo,
            decoration: InputDecoration(
              label: Text("subtitulo"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24),
          MaterialButton(
            child: Text("Guardar"),
            onPressed: () {
              Map<String, dynamic> fshareData = {};
              fshareData = {
                "nombre": _nombre.value.text,
                "descripcion": _description.value.text,
                "subtitulo": _subtitulo.value.text,
                "ejercicios": ["1ktApH0YFtIT09dIG40z", "LgfWvfVnRWPB4wYGZMyU"],
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





// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foto_share/content/agregar/bloc/create_bloc.dart';

// class AddForm extends StatefulWidget {
//   AddForm({Key? key}) : super(key: key);
//   @override
//   State<AddForm> createState() => _AddFormState();
// }
// class _AddFormState extends State<AddForm> {
//   var _titleC = TextEditingController();
//   var _imageLink = TextEditingController();
//   var _description = TextEditingController();
//   var _subtitulo = TextEditingController();
//   bool _defaultSwitchValue = false;
//   File? image;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CreateBloc, CreateState>(listener: (context, state) {
//       if (state is CreatePictureErrorState) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Error al elegir imagen valida"),
//           ),
//         );
//       } else if (state is CreateFshareErrorState) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Error al guardar Fshare"),
//           ),
//         );
//       } else if (state is CreateSuccessState) {
//         _titleC.clear();
//         _defaultSwitchValue = false;
//         image = null;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Guardado exitosamente..."),
//           ),
//         );
//       } else if (state is CreatePictureChangedState) {
//         image = state.picture;
//       }
//     }, builder: (context, state) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: ListView(children: [
//           image != null
//               ? Image.file(
//                   image!,
//                   height: 120,
//                 )
//               : Container(),
//           SizedBox(height: 24),
//           MaterialButton(
//             child: Text("Agregar una rutina"),
//             onPressed: () {
//               // // BLoC tomar  foto
//               // BlocProvider.of<CreateBloc>(context)
//               //     .add(OnCreateTakePictureEvent());
//             },
//           ),
//           SizedBox(height: 24),
//           TextField(
//               maxLength: 30,
//               controller: _titleC,
//               decoration: InputDecoration(
//                 focusColor: Colors.black,
//                 label: Text("Title", style: TextStyle(color: Colors.black)),
//                 border: OutlineInputBorder(),
//               )),
//           SizedBox(height: 24),
//           TextField(
//               controller: _subtitulo,
//               decoration: InputDecoration(
//                 focusColor: Colors.black,
//                 label: Text("Subtitulo", style: TextStyle(color: Colors.black)),
//                 border: OutlineInputBorder(),
//               )),
//           SizedBox(height: 24),
//           TextField(
//               controller: _imageLink,
//               decoration: InputDecoration(
//                 focusColor: Colors.black,
//                 label: Text("Link to image",
//                     style: TextStyle(color: Colors.black)),
//                 border: OutlineInputBorder(),
//               )),
//           SizedBox(height: 24),
//           TextField(
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//               controller: _description,
//               decoration: InputDecoration(
//                 focusColor: Colors.black,
//                 label:
//                     Text("Description", style: TextStyle(color: Colors.black)),
//                 border: OutlineInputBorder(),
//               )),
//           SizedBox(height: 24),
//           SwitchListTile(
//             title: Text("Hacer publico"),
//             value: _defaultSwitchValue,
//             onChanged: (newValue) {
//               _defaultSwitchValue = newValue;
//               setState(() {});
//             },
//           ),
//           SizedBox(height: 24),
//           MaterialButton(
//             child: Text("Guardar"),
//             onPressed: () {
//               Map<String, dynamic> fshareData = {};
//               fshareData = {
//                 "title": _titleC.value.text,
//                 "public": _defaultSwitchValue,
//               };
//               BlocProvider.of<CreateBloc>(context)
//                   .add(OnCreateSaveDataEvent(dataToSave: fshareData));
//             },
//           ),
//         ]),
//       );
//     });
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foto_share/content/agregar/bloc/create_bloc.dart';

// class AddForm extends StatefulWidget {
//   AddForm({Key? key}) : super(key: key);

//   @override
//   State<AddForm> createState() => _AddFormState();
// }

// class _AddFormState extends State<AddForm> {
//   var _titleC = TextEditingController();
//   var _description = TextEditingController();
//   var _subtitulo = TextEditingController();
//   var _ejercicios = [];

//   File? image;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CreateBloc, CreateState>(listener: (context, state) {
//       if (state is CreatePictureErrorState) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Error al elegir imagen valida"),
//           ),
//         );
//       } else if (state is CreateFshareErrorState) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Error al guardar en la base"),
//           ),
//         );
//       } else if (state is CreateSuccessState) {
//         _titleC.clear();
//         _description.clear();
//         _subtitulo.clear();
//         _ejercicios.clear();
//         image = null;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Guardado exitosamente..."),
//           ),
//         );
//       } else if (state is CreatePictureChangedState) {
//         image = state.picture;
//       }
//     }, builder: (context, state) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: ListView(children: [
//           image != null
//               ? Image.file(
//                   image!,
//                   height: 120,
//                 )
//               : Container(),
//           SizedBox(height: 24),
//           MaterialButton(
//             child: Text("Foto"),
//             onPressed: () {
//               // BLoC tomar  foto
//               BlocProvider.of<CreateBloc>(context)
//                   .add(OnCreateTakePictureEvent());
//             },
//           ),
//           SizedBox(height: 24),
//           TextField(
//             controller: _titleC,
//             decoration: InputDecoration(
//               label: Text("Title"),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 24),
//           TextField(
//             controller: _description,
//             decoration: InputDecoration(
//               label: Text("Descripcion"),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 24),
//           TextField(
//             controller: _subtitulo,
//             decoration: InputDecoration(
//               label: Text("Subtitulo"),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 24),
//           MaterialButton(
//             child: Text("Guardar"),
//             onPressed: () {
//               Map<String, dynamic> fshareData = {};
//               fshareData = {
//                 "image": image,
//                 "titulo": _titleC.value.text,
//                 "descripcion": _description.value.text,
//                 "subtitulo": _subtitulo.value.text,
//                 "ejercicios": [],
//               };
//               BlocProvider.of<CreateBloc>(context)
//                   .add(OnCreateSaveDataEvent(dataToSave: fshareData));
//             },
//           ),
//         ]),
//       );
//     });
//   }
// }