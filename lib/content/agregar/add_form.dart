import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/content/agregar/bloc/create_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foto_share/content/mis_fotos/bloc/misFotos_bloc.dart';
import 'package:foto_share/content/mis_fotos/mis_fotos.dart';

class AddForm extends StatefulWidget {
  AddForm({Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  var _subtitulo = TextEditingController();
  var _description = TextEditingController();
  var _nombre = TextEditingController();

  List<dynamic> _ejerID = [
    '1ktApH0YFtIT09dIG40z',
    '8mjlSuqKb9PEK8jdbuuP',
    '9vBPjRqufwvTPecXfWP4',
    'DQdEOlbj0VreKZtZ0i8f',
    'GYM4PYyKhvwNSiZmNrbr',
    'GiwdKpTc8ftHcj8ZdKM8',
    'LgfWvfVnRWPB4wYGZMyU',
    'QPjReaF3py7H2tcXlOHs',
    'YvxaGa5b5JPcrxvtWvyk',
    'ZbSE05zcSP5Yes8ghqDE',
    'p2gILzxoM3NElEkrl9r7',
    'qhLtrbsY4dH2m5adhbXO',
    'rYskHhxNpM8OgiQ7x6pi',
    'tQYfgWUDBC5upvDwYMaB'
  ];

  List<dynamic> _ejercicios = [
    'Sukhasana',
    'Dips',
    'Barra de press de banca',
    'Curl de martillo',
    'Curl con mancuernas',
    'Dominadas',
    'Dwi Pada Pitham',
    'Curl con barra',
    'Aperturas con mancuernas',
    'Jalón con agarre neutral',
    'Abdominales',
    'Estiramiento de cuádriceps',
    'Estiramiento de trampas',
    'Elevaciones de piernas acostadas',
  ];

  //list of 14 boolean values
  List<bool> _ejerciciosSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  List<dynamic> _selectedEjer = [];

  File? image;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateBloc, CreateState>(listener: (context, state) {
      if (state is CreatePictureErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al elegir una imagen valida"),
          ),
        );
      } else if (state is CreateFshareErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al guardar el formulario. Intente de nuevo"),
          ),
        );
      } else if (state is CreateSuccessState) {
        _nombre.clear();
        _description.clear();
        _subtitulo.clear();
        _ejerciciosSelected = [
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false
        ];
        image = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Guardado exitosamente..."),
          ),
        );
        BlocProvider.of<misFotosBloc>(context).add(GetAllMyFotosEvent());
      } else if (state is CreatePictureChangedState) {
        image = state.picture;
      }
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(children: [
          SvgPicture.asset(
            'assets/icon/exerVector.svg',
            height: 200,
            semanticsLabel: 'Exercise vector',
          ),
          SizedBox(height: 20),

          image != null
              ? Image.file(
                  image!,
                  height: 120,
                )
              : Container(),
          SizedBox(height: 24),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.purple,
            child: IconButton(
              tooltip: 'Seleccionar imagen',
              onPressed: () {
                // BLoC tomar  foto
                BlocProvider.of<CreateBloc>(context)
                    .add(OnCreateTakePictureEvent());
              },
              color: Colors.white,
              icon: Icon(Icons.image),
            ),
          ),
          SizedBox(height: 24),
          TextField(
            maxLength: 30,
            controller: _nombre,
            decoration: InputDecoration(
              label: Text("Nombre"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24),
          TextField(
            maxLines: null,
            controller: _description,
            decoration: InputDecoration(
              label: Text("Descripcion"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24),
          TextField(
            maxLength: 60,
            maxLines: null,
            controller: _subtitulo,
            decoration: InputDecoration(
              label: Text("Subtitulo"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24),
          //divider
          Text(
            "Ejercicios",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Divider(
            color: Colors.black54,
          ),

          Column(
            children: _ejercicios.map((ejer) {
              int index = _ejercicios.indexOf(ejer);
              return CheckboxListTile(
                title: Text(ejer),
                value: _ejerciciosSelected[index],
                onChanged: (value) {
                  setState(() {
                    _ejerciciosSelected[index] = value!;
                  });
                },
              );
            }).toList(),
          ),

          MaterialButton(
            child: Text("Guardar"),
            onPressed: () {
              if (_nombre.text.isEmpty ||
                  _description.text.isEmpty ||
                  _subtitulo.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Por favor llene todos los campos"),
                  ),
                );
              } else {
                _selectedEjer = [];
                var index = 0;
                for (var bool in _ejerciciosSelected) {
                  if (bool) {
                    _selectedEjer.add(_ejerID[index]);
                  }
                  index++;
                }
                print("Selected ejer: $_selectedEjer");

                Map<String, dynamic> fshareData = {};
                fshareData = {
                  "nombre": _nombre.value.text,
                  "descripcion": _description.value.text,
                  "subtitulo": _subtitulo.value.text,
                  "ejercicios": _selectedEjer,
                };

                //print("fshareData: $fshareData");

                BlocProvider.of<CreateBloc>(context)
                    .add(OnCreateSaveDataEvent(dataToSave: fshareData));
              }
            },
            color: Colors.blue,
          ),
          SizedBox(height: 24),
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