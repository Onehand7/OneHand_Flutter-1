

import 'package:flutter/material.dart';
import 'package:onehand_spa/global.dart';
import 'package:onehand_spa/menu/animation_route.dart';
import 'package:onehand_spa/menu/menu_lateral.dart';
class ViewPerfil extends StatelessWidget {
  const ViewPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Perfil"),),
        backgroundColor: Color(0xFF292926),
        leading: IconButton(
        icon: Icon(
        Icons.arrow_back,
        size: 30,
        ),
        onPressed: () {}
        ),
      ),
      body: BuildPerfil(context),
    );
  }
  Widget BuildPerfil(BuildContext context){
    //var size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xFFb2b2b2),
          ),
          child: IconButton(
              icon: Icon(
                Icons.account_circle,
                size: 150,
              ),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MenuLateral(
                  ),
                ));
              }
          ),
        ),
        Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${Global.user.nombre} ${Global.user.apellido}",
                style: TextStyle(fontSize: 27),
              ),
            )),
        ListTile(
          title: Text("Correo electrónico"),
          subtitle: Text("${Global.user.email}"),
        ),
        Divider(),
        ListTile(
          title: Text("Rol"),
          subtitle: Text("${Global.user.rol}"),
        ),
        Divider(),
        ListTile(
          title: Text("Contraseña"),
          subtitle: Text("**********"),
          trailing: IconButton(icon: Icon(Icons.edit), onPressed: null),
        ),
      ],
    );
  }
}

