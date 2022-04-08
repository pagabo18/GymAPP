import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/auth/bloc/auth_bloc.dart';
import 'package:foto_share/content/agregar/add_form.dart';
import 'package:foto_share/content/espera/en_espera.dart';
import 'package:foto_share/content/RutinasDef/Rutinas_Def.dart';
import 'package:foto_share/content/foru/fotosforu.dart';
import 'package:foto_share/content/Suplementos/Suplementos.dart';
import 'package:foto_share/content/mis_fotos/mis_fotos.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 2;
  final _pagesNameList = [
    "Usuario",
    "Rutinas",
    "Suplementos",
    "editar",
    "MisRutinas",
    "Global"
  ];
  final _pagesList = [
    Container(
      child: Center(
        child: Text("Usuario"),
      ),
    ),
    FotosForU(),
    Suplementos(),
    AddForm(),
    MisFotos(),
    EnEspera(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(_pagesNameList[_currentPageIndex]),
        flexibleSpace: Container(
          height: 120,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.purple]),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: _pagesNameList[0],
            icon: Icon(Icons.person_rounded),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[1],
            icon: Icon(Icons.fitness_center_rounded),
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[2],
            icon: Icon(Icons.fastfood_rounded),
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[3],
            icon: Icon(Icons.mode_edit_outline_outlined),
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[4],
            icon: Icon(Icons.calendar_today_sharp),
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[5],
            icon: Icon(Icons.add_circle_outline_outlined),
          ),
        ],
      ),
    );
  }
}
