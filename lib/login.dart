
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onehand_spa/add/add_user.dart';
import 'package:onehand_spa/global.dart';
import 'package:onehand_spa/pages/menu_page.dart';


import 'list/user.dart';
import 'menu/animation_route.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Login());

}

class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue
      ),
      home: LoginUser(title:"Login"),
    );
  }

}
class LoginUser extends StatelessWidget {
  final String title;
  const LoginUser({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black26
    ));
    return Scaffold(
        body: LoginFrom(),
    );
  }
}
class LoginFrom extends StatefulWidget{
  @override
  loginFromState createState(){
    return loginFromState();
  }
}
class loginFromState extends State<LoginFrom>{
  bool selectLogin=true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
                  "assets/logoOnehand.png",
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
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
                      )
                    ),
                    validator: (String? val){
                      if(val!.isEmpty){
                        return "Por favor ingresar el correo";
                      }return null;
                    },
                    controller: email,
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                child: TextFormField(
                  obscureText: true,
                  style: TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                      labelText: "Ingresar contraseña",
                      fillColor: Colors.lightBlue,
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      )
                  ),
                  validator: (String? val){
                    if(val!.isEmpty){
                      return "Por favor ingresar la contraseña";
                    }return null;
                  },
                  controller: password,
                ),
                ),Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),
                  child: MaterialButton(
                    minWidth: 500.0,
                    height: 60.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    onPressed: () async{
                      if(_formKey.currentState!.validate()){
                        signInWithCredentials(context);
                      }
                    },
                    child: setUpButtonChild(),
                    color: Colors.lightBlue,
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),
                  child: MaterialButton(
                    minWidth: 500.0,
                    height: 60.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    onPressed: (){
                      Navigator.push(context, Animation_route(AddUser()));
                    },
                    color: Colors.black26,
                    child: Text("Registrar",style: const TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  int _state =0;
  Widget setUpButtonChild(){
    if(_state==0){
      return Text(
        "Iniciar Sesión",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    }else if(_state == 1){
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }else{
      return Text(
          "Iniciar Sesión",
          style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
      ),);
    }
  }
  void animateButton(){
    setState(() {
      _state=1;
    });
    Timer(Duration(seconds: 60),(){
      setState(() {
        _state= 2;
      });
    });
  }
  void signInWithCredentials(BuildContext context) async{
    final _auth = FirebaseAuth.instance;
    final _db = FirebaseFirestore.instance;
    String userText = "Cliente";
    animateButton();
    try{
      _auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
      ).then((value){
        Future<DocumentSnapshot> snapshot = _db.collection('users').doc(email.text).get();
        snapshot.then((DocumentSnapshot user){
          Global.user = Users(
            user['nombre'],
            user['apellido'],
            user.id,
            user['rol'],
            user['active'],
          );
          Navigator.push(context, Animation_route(MenuPage(Global.user.rol))).whenComplete(() => Navigator.of(context).pop());
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
      
    }catch(e){
      setState(() {
        _state=2;
      });
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
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

