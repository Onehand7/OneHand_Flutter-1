import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onehand_app/list/list_user.dart';

import '../constants.dart';

class ScreenNewSolicitud extends StatefulWidget {
  //const ScreenNewSolicitud({Key? key}) : super(key: key);
  final String name;
  final String user;
  const ScreenNewSolicitud({Key? key, required this.name, required this.user})
      : super(key: key);
  @override
  _ScreenNewSolicitudState createState() => _ScreenNewSolicitudState();
}

class _ScreenNewSolicitudState extends State<ScreenNewSolicitud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            children: [
              Container(
                  height: 70,
                  child: Column(
                    children: [
                      Text(
                        "Nueva solicitud",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.settings,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  )),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 20,
              ),
              _textGeneral(
                labelText: "Título de la solicitud",
              ),
              _textFieldNuevaSolicitud(),
              SizedBox(
                height: 20,
              ),
              _textGeneral(
                labelText: "Detalles del servicio",
              ),
              _textFieldDetalleSolicitud(),
              SizedBox(
                height: 20,
              ),
              _textGeneral(
                labelText: "Fotos del servicio",
              ),
              Text(
                  "Puedes añadir fotos de tu galeria. esto ayudara a los técnicos a entender mejor tu problema."),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                child: Text("Añadir fotos"),
                onPressed: () {},
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                child: Text("Siguiente"),
                color: colorBlue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListUser(),
                      ));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget _textFieldNuevaSolicitud() {
  return _textFieldGeneral(
    labelText: "Nueva solicitud",
    icon: Icons.border_color,
    maxline: 1,
    onChanged: (value) {},
  );
}

Widget _textFieldDetalleSolicitud() {
  return _textFieldGeneral(
    labelText: "Escriba con detalle lo qué necesitas",
    icon: Icons.border_color,
    maxline: 2,
    onChanged: (value) {},
  );
}

// ignore: camel_case_types
class _textFieldGeneral extends StatelessWidget {
  final String labelText;
  final Function onChanged;
  final IconData icon;
  final int maxline;
  const _textFieldGeneral(
      {required this.labelText,
      required this.onChanged,
      required this.icon,
      required this.maxline});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        maxLines: maxline,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            prefixIcon: Icon(icon)),
        //onChanged: onChanged,
      ),
    );
  }
}

// ignore: camel_case_types
class _textGeneral extends StatelessWidget {
  final labelText;
  _textGeneral({this.labelText});

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: TextStyle(fontSize: 25.0),
    );
  }
}
