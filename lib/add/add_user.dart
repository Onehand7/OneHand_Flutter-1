import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onehand_spa/add/card_foto.dart';
import 'package:onehand_spa/add/validate_text.dart';
import 'package:onehand_spa/list/user.dart';
import 'package:onehand_spa/main.dart';
import 'package:onehand_spa/menu/animation_route.dart';

import 'package:onehand_spa/pages/menu_page.dart';

import '../global.dart';

void main() => runApp(AddUser());

class AddUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Registrar",
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.cyan,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.cyan,
        ),
        home: HomePage(title: "Registro"),
        routes: <String, WidgetBuilder>{});
  }
}

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text(title)),
        actions: [
          //boton que permite regresar a la pestaña inicio
          InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffffffff),
            ),
            onTap: () {
              Navigator.push(context, Animation_route(UserApp()))
                  .whenComplete(() => Navigator.of(context).pop());
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: UserForm(),
      //drawer: MenuLateral(),
    );
  }
}

class UserForm extends StatefulWidget {
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
  List _roles = ["Cliente","Tecnico"];

  late List<DropdownMenuItem<String>> _dropDownRolesItems;
  late String _currentRole;
  bool _isEnable = true;
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
            child: CardFotos(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20.0),
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
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20.0),
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
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                labelText: "Ingresar email",
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide()),
              ),
              //validator: validateEmail,
              controller: email,
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: TextFormField(
              obscureText: true,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                labelText: "Ingresar contraseña",
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide()),
              ),
             // validator: validatePassword,
              controller: password,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: DropdownButton(
              value: _currentRole,
              hint: Text(_roles.toString()),
              items: _dropDownRolesItems,
              onChanged: changedDropDownItem,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),
            child: MaterialButton(
              minWidth: 200.0,
              height: 60.0,
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              child: setUpButtonChild(),
              onPressed: (){
                if(_formKey.currentState!.validate()){
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
  Widget setUpButtonChild(){
    if(_state == 0){
      return Text(
        "Registrar",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ) ,
      );
    }else if(_state ==1){
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }else{
      return Text(
          "Registrar",
          style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
      ) ,
    );
    }
  }
  /*
  String validateEmail(String value){
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty){
      return 'Por favor ingrese el email';
    }else{
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value)){
        return 'Enter Valid Email';
      }
    }
  }
  */
  /*
  String validatepassword(String value){
    if(value.isEmpty){
      return 'por favor ingrese el passwpord';
    }else{
      if(6 > value.length){
        return 'por favor ingrese un password de 6 caracteres';
      }
    }
  }
  */

  //metodo
  registrar(BuildContext context)async{

    final _auth = FirebaseAuth.instance;
    //final _firebaseStorageRef = FirebaseStorage.instance;
    final _db = FirebaseFirestore.instance;
    //var image = CardFoto;
    if(email.text !=null && password.text!=null){
      setState(() {
        if(_state==0){
          animateButton();
        }
      });
      await _auth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
      ).then((value){
        DocumentReference ref = _db.collection("users").doc(email.text);
        ref.set({
          "nombre":name.text,
          "apellido":lastname.text,
          "email": email.text,
          "rol": _currentRole,
          "active": "true",
        })
        .then((value){
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
      }).catchError((e)=>{
        ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.message))),

      });
    }
  }
  void animateButton(){
    setState(() {
      _state =1;
    });
    Timer(Duration(seconds: 60),(){
      setState(() {
        _state=2;
      });
    });
  }
  List<DropdownMenuItem<String>> getDropDownRolesItems(){
    List<DropdownMenuItem<String>> items = [];
    for(String item in _roles){
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
  void changedDropDownItem(String? selectedRole){
    setState(() {
      _currentRole = selectedRole!;
    });
  }
}
