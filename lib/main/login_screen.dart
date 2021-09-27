import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onehand_app/global.dart';
import 'package:onehand_app/main/register_screen.dart';
import 'package:onehand_app/main/reset_screen.dart';
import 'package:onehand_app/pages/menu_page.dart';
import 'package:onehand_app/panel/panel_main_screen.dart';
import 'package:onehand_app/utils/functions.dart';

import '../list/users.dart';
import '../menu/animation_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.lightBlue),
      darkTheme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.lightBlue),
      home: LoginUser(title: "Login"),
    );
  }
}

class LoginUser extends StatelessWidget {
  final String title;
  const LoginUser({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black26));
    return Scaffold(
      body: Loginform(),
    );
  }
}

class Loginform extends StatefulWidget {
  @override
  LoginformState createState() {
    return LoginformState();
  }
}

class LoginformState extends State<Loginform> {
  bool selectLogin = true;
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logoOnehand.png",
                  width: 180,
                  height: 180,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 15.0),
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
                    controller: email,
                    inputFormatters: [EmailTextFormatter()],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(
                        labelText: "Ingresar contraseña",
                        fillColor: Colors.lightBlue,
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        )),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "Por favor ingresar la contraseña";
                      }
                      return null;
                    },
                    controller: password,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 10.0),
                  child: MaterialButton(
                    minWidth: 500.0,
                    height: 60.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        signInWithCredentials(context);
                      }
                    },
                    child: setUpButtonChild(),
                    color: Colors.lightBlue,
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextButton(
                      child: Text("Olvidé mi clave",
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.white)),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ResetScreen())))
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 10.0),
                  child: MaterialButton(
                    minWidth: 500.0,
                    height: 60.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                    color: Colors.black26,
                    child: Text(
                      "Registrar",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _state = 0;
  Widget setUpButtonChild() {
    if (_state == 0) {
      return Text(
        "Iniciar Sesión",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Text(
        "Iniciar Sesión",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
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

  void inAnimateButton() {
    setState(() {
      _state = 2;
    });
  }

  void signInWithCredentials(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final _db = FirebaseFirestore.instance;
    String loginResultText = "";
    email.text = email.text.toLowerCase();
    animateButton();

    try {
      await _auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
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
          var ref =
              FirebaseStorage.instance.ref().child("user/profile/${user.id}");
          Global.avatarURL = await ref.getDownloadURL();
          print(Global.avatarURL);
          if (user['rol'] == "Cliente") {
            Navigator.push(context, Animation_route(PanelMainScreen()))
                .whenComplete(() => Navigator.of(context).pop());
          } else {
            Navigator.push(context, Animation_route(MenuPage(Global.user.rol)))
                .whenComplete(() => Navigator.of(context).pop());
          }

          /*
          Navigator.push(context, Animation_route(MenuPage(Global.user.rol)))
              .whenComplete(() => Navigator.of(context).pop());
              */
        });
      });
    } on FirebaseAuthException catch (e) {
      bool locked = false;
      if (e.code == 'user-not-found') {
        loginResultText = "Usuario no existe";
      } else if (e.code == 'wrong-password') {
        loginResultText = "Clave de acceso incorrecta";
      } else if (e.code == "too-may-request") {
        loginResultText = "Demasiado intentos. Bloqueado por 60 segundos";
        locked = true;
      }
      final snackBar = SnackBar(
          content: Text(loginResultText), backgroundColor: Colors.redAccent);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (!locked) {
        inAnimateButton();
      }
    } catch (xX) {
      print("Error desconocido");
    }
    /*
    try {
      _auth
          .signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((value) {
        Future<DocumentSnapshot> snapshot =
            _db.collection('users').doc(email.text).get();
        snapshot.then((DocumentSnapshot user) {
          Global.user = Users(
            user['nombre'],
            user['apellido'],
            user.id,
            user['rol'],
            user['active'],
          );
          Navigator.push(context, Animation_route(MenuPage(Global.user.rol)))
              .whenComplete(() => Navigator.of(context).pop());
        });
      });
      /*
      final User? user = ( await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text
      )).user;
      if(user!.emailVerified){
        await user.sendEmailVerification();

      }
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        print("AQUII ESTA EL USER:$user");
        return MenuPage(userText);
      }));
      
       */

    } catch (e) {
      setState(() {
        _state = 2;
      });
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    */
    /*
     _auth.signInWithEmailAndPassword(
        email: email.text, 
        password: password.text,
    ).then((value) {
      Future<DocumentSnapshot> snapshot = _db.collection("users").doc(email.text).get();
      snapshot.then((DocumentSnapshot user){
        Global.user = Users(
          user['nombre'] ,
          user['apellido'],
          user['email'],
          user.id,
        );
        Navigator.push(context, Animation_route(UserApp())).whenComplete(() => Navigator.of(context).pop());
      });
    }).catchError((e){
      setState(() {
        _state = 2;
      });
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    });
     */
  }
}
