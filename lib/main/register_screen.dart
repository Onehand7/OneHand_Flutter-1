import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onehand_app/panel/panel_main_screen.dart';
import 'package:onehand_app/utils/functions.dart';
import 'package:onehand_app/widgets/card_photo.dart';
import 'package:onehand_app/add/validate_text.dart';
import 'package:onehand_app/list/users.dart';
import 'package:onehand_app/menu/animation_route.dart';

import 'package:onehand_app/pages/menu_page.dart';

import '../global.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    Global.avatarURL = "";
    return Scaffold(
      appBar: AppBar(title: Text("Registro")),
      body: UserForm(),
      //drawer: MenuLateral(),
    );
  }
}

class UserForm extends StatefulWidget {
  UserForm({Key? key}) : super(key: key);

  @override
  UserFormState createState() {
    return UserFormState();
  }
}

class UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var lastname = TextEditingController();
  List _roles = ["Cliente", "Prestador de Servicio"];

  late List<DropdownMenuItem<String>> _dropDownRolesItems;
  late String _currentRole;
  late ValidateText validate;
  @override
  void initState() {
    _dropDownRolesItems = getDropDownRolesItems();
    _currentRole = _dropDownRolesItems[0].value!;

    validate = ValidateText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            child: CardPhoto(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 15.0),
              decoration: InputDecoration(
                labelText: "Ingresar nombre",
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide()),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Por favor ingrese el nombre";
                }
              },
              controller: name,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 15.0),
              decoration: InputDecoration(
                labelText: "Ingresar apellido",
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide()),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Por favor ingrese el apellido";
                }
              },
              controller: lastname,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 15.0),
              decoration: InputDecoration(
                labelText: "Ingresar email",
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide()),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Por favor ingrese la dirección de correo";
                }
                if (!Func.validateEmail(value)) {
                  return "Ingrese una dirección de correo válida";
                }
              },
              controller: email,
              inputFormatters: [EmailTextFormatter()],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            child: TextFormField(
              obscureText: true,
              style: TextStyle(fontSize: 15.0),
              decoration: InputDecoration(
                labelText: "Ingresar contraseña",
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide()),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Por favor ingrese una clave";
                }
              },
              controller: password,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: DropdownButton(
              isExpanded: true,
              value: _currentRole,
              hint: Text(_roles.toString()),
              items: _dropDownRolesItems,
              onChanged: changedDropDownItem,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
            child: MaterialButton(
              minWidth: 200.0,
              height: 60.0,
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: setUpButtonChild(),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  registrar(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

//funcion para el boton registrar
  int _state = 0;
  Widget setUpButtonChild() {
    if (_state == 0) {
      return Text(
        "Registrar",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Text(
        "Registrar",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
      );
    }
  }

  registrar(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    //final _firebaseStorageRef = FirebaseStorage.instance;
    final _db = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;

    //var image = CardFoto;
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      setState(() {
        if (_state == 0) {
          animateButton();
        }
      });
      await _auth
          .createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((value) {
        DocumentReference ref = _db.collection("users").doc(email.text);
        ref.set({
          "nombre": name.text,
          "apellido": lastname.text,
          "email": email.text,
          "rol": _currentRole,
          "active": "true",
        }).then((value) {
          Future<DocumentSnapshot> snapshot =
              _db.collection('users').doc(email.text).get();
          snapshot.then((DocumentSnapshot user) async {
            Global.user = Users(
              user['nombre'],
              user['apellido'],
              user.id,
              user['rol'],
              user['active'],
            );
            //Creamos la imagen en la base de datos, si es que existe
            if (Global.avatarURL.isNotEmpty) {
              var storageRef = storage.ref().child("user/profile/${user.id}");
              await storageRef.putFile(File(Global.avatarURL));
            }
            SnackBar snackBar = SnackBar(
                content: Text("Su cuenta se ha creado exitosamente."),
                backgroundColor: Colors.lightGreen);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            sleep(Duration(seconds: 5));
            if (_currentRole == "Cliente") {
              Navigator.push(context, Animation_route(PanelMainScreen()))
                  .whenComplete(() => Navigator.of(context).pop());
            } else {
              Navigator.push(
                      context, Animation_route(MenuPage(Global.user.rol)))
                  .whenComplete(() => Navigator.of(context).pop());
            }
          });
        });
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      });
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });
    Timer(Duration(seconds: 60), () {
      setState(() {
        _state = 2;
      });
    });
  }

  List<DropdownMenuItem<String>> getDropDownRolesItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _roles) {
      items.add(DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ));
    }
    return items;
  }

  void changedDropDownItem(String? selectedRole) {
    setState(() {
      _currentRole = selectedRole!;
    });
  }
}
