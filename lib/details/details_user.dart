import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onehand_spa/details/separator.dart';
import 'package:onehand_spa/details/user_summary.dart';
import 'package:onehand_spa/list/list_user.dart';
import 'package:onehand_spa/list/users.dart';
import 'package:onehand_spa/menu/animation_route.dart';
import 'package:onehand_spa/menu/menu_lateral.dart';

import '../global.dart';

class DetailsUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Detalles',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
      ),
      home: DetailUser(title: 'Detalles'),
    );
  }
}

class DetailUser extends StatelessWidget {
  final String title;
  DetailUser({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.push(context, Animation_route(ListUser()))
                  .whenComplete(() => Navigator.of(context).pop());
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Details(),
      drawer: MenuLateral(),
    );
  }
}

class Details extends StatefulWidget {
  @override
  DetailsFormState createState() {
    // TODO: implement createState
    return DetailsFormState();
  }
}

class DetailsFormState extends State<Details> {
  late Users _doc;
  DetailsFormState() {
    this._doc = Global.doc;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.black26,
        child: Stack(
          children: [_getBackground(), _getGradient(), _getContent()],
        ),
      ),
    );
  }

  Container _getBackground() {
    return Container(
      child: Image.network(
        "https://www.urgencias24h.net/wp-content/uploads/2019/12/electricista-urgente-24h-nou-barris-barcelona.jpg",
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: BoxConstraints.expand(height: 295.0),
    );
  }

  Container _getGradient() {
    return Container(
      margin: EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.black26, Colors.black38],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent() {
    final _overviewTitle = "información".toUpperCase();
    return Container(
      child: ListView(
        padding: EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: [
          UserSummary(
            horizontal: false,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _overviewTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Separator(),
                Text(
                  "Mi nombre es ${_doc.nombre} ${_doc.apellido} soy de Honduras La Ceiba y soy Programador"
                  " en los lenguajes de Java, C ++, C #, VB, Android, Python, UWP, Android,"
                  " Xamarin, Kotlin ,Dart y Web con html 5, PHP, ASP NET Core, jQuery, Css, "
                  "Node.Js, JavaScript, base de datos con MySQL y SQL Serve Soy YouTuber y "
                  "tengo un canal de YouTube donde publico videos tutoriales de programación "
                  "y desarrollo de aplicaciones saludos y bendiciones ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
