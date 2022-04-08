import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("GYMAPP",
                  style: TextStyle(
                    fontSize: 49,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  )),
            ),
            Image.asset(
              "assets/icon/dumbbell.png",
              height: 100,
            ),
            SizedBox(height: 200),
            Text(
              "Utiliza un red social",
            ),
            MaterialButton(
              child: Text("Iniciar con Google"),
              color: Colors.lightBlue,
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
