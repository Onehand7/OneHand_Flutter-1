import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onehand_spa/login.dart';
import 'dart:convert';

import 'package:onehand_spa/menu/animation_route.dart';

class ScreensElejir extends StatefulWidget {
  static String id = "Screend_Elejir";
  @override
  _ScreensElejirState createState() => _ScreensElejirState();
}

class _ScreensElejirState extends State<ScreensElejir> {
  @override
  void initState() {
    super.initState();
    //getUser();
  }

  // getUser() async {
  //   http.Response response = await http.get('http://192.168.1.93:3000/');
  //   debugPrint(response.body);
  //   data = json.decode(response.body);
  //   setState(() {
  //     return data;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.lightBlue,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "¿Que eres?",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        _iconsButtonCli(),
                        Text(
                          "Cliente",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        _iconsButtonPro(),
                        Text(
                          "Técnico",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _iconsButtonCli() {
    //Variables
    String _cli = "Cliente";

    return ClipOval(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/IconCliente.png"),
          ),
        ),
        child: FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Text(""),
          onPressed: () {
            print(_cli);
            Navigator.push(context, Animation_route(Login()));
            //Navegación a LoginScreen pestaña que permite registrar y iniciar sesión
           // Navigator.push(context,
               // MaterialPageRoute(builder: (context) => LoginScreen(_cli)));
          },
        ),
      ),
    );
  }

  Widget _iconsButtonPro() {
    //Variables
    String _tec = "Técnico";
    return ClipOval(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/IconTécnico.png"),
          ),
        ),
        child: FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Text(""),
          onPressed: () {
            print(_tec);
            Navigator.push(context,Animation_route(Login()));
            //Navegación a LoginScreen pestaña que permite registrar y iniciar sesión
            //Navigator.push(context,
            //  MaterialPageRoute(builder: (context) => LoginScreen(_tec)));
          },
        ),
      ),
    );
  }
}
