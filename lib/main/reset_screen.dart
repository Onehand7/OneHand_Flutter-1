import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onehand_app/utils/functions.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _auth = FirebaseAuth.instance;
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var _state = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recuperar clave")),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logoOnehand.png",
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                        labelText: "Ingresar correo",
                        fillColor: Colors.lightBlue,
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        )),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "Por favor ingresar el correo";
                      }
                      return null;
                    },
                    controller: _email,
                    inputFormatters: [EmailTextFormatter()],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  child: MaterialButton(
                    minWidth: 500.0,
                    height: 60.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    onPressed: () {
                      _state = 1;
                      var _emailText = _email.text;
                      SnackBar snackBar;
                      _auth
                          .sendPasswordResetEmail(email: _emailText)
                          .then((void v) {
                        _state = 0;
                        snackBar = SnackBar(
                            content: Text(
                                "Se envió un correo a $_emailText para recuperar la clave de acceso."),
                            backgroundColor: Colors.lightGreen);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        sleep(Duration(seconds: 5));
                        Navigator.of(context).pop();
                      }).catchError((e) {
                        if (e.code == 'user-not-found') {
                          snackBar = SnackBar(
                              content: Text(
                                  "La dirección $_emailText no pertence a ninguna cuenta. Intente nuevamente."),
                              backgroundColor: Colors.red);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        if (e.code == 'invalid-email') {
                          snackBar = SnackBar(
                              content: Text(
                                  "La dirección $_emailText está mal escrita."),
                              backgroundColor: Colors.red);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        _state = 0;
                      });
                    },
                    color: Colors.black26,
                    child: buttonRegister(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonRegister() {
    if (_state == 0) {
      return Text("Recuperar",
          style: const TextStyle(color: Colors.white, fontSize: 20));
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }
}
