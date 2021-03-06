import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onehand_app/add/view_perfil.dart';
import 'package:onehand_app/global.dart';
import 'package:onehand_app/main/login_screen.dart';
import 'package:onehand_app/menu/animation_route.dart';
import 'package:onehand_app/pages/menu_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuLateral extends StatefulWidget {
  @override
  Menu createState() => Menu();
}

class Menu extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              "${Global.user.nombre}    ${Global.user.apellido}     ${Global.user.email}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.rectangle,
              /*
              image: DecorationImage(
                image: NetworkImage(''),
                fit: BoxFit.cover,
              ),

               */
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Color(0xffffffff),
            ),
            title: Text("Inicio"),
            onTap: () {
              Navigator.push(
                      context, Animation_route(MenuPage(Global.user.rol)))
                  .whenComplete(() => Navigator.of(context).pop());
            },
          ),
          /*
          ListTile(
            leading: Icon(
              Icons.person,
              color: Color(0xffffffff),
            ),
            title: Text("Registrar"),
            onTap: () {
              Navigator.push(context, Animation_route(AddUser()))
                  .whenComplete(() => Navigator.of(context).pop());
            },
          ),
          */
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text('Mi perfil'),
            onTap: () {
              // Navegaci??n para el perfil del usuario con la intenci??n
              Navigator.push(context, Animation_route(ViewPerfil()))
                  .whenComplete(() => Navigator.of(context).pop());
            },
          ),
          ListTile(
            leading: Icon(Icons.wysiwyg),
            title: Text("Noticias"),
            onTap: () {
              launch("https://onehand.cl");
            },
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text("Atenci??n al cliente"),
            onTap: () {
              launch("https://onehand.cl");
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_rounded),
            title: Text("Acerca de OneHand"),
            onTap: () {
              launch("https://onehand.cl");
            },
          ),
          ListTile(
            leading: Icon(Icons.account_tree),
            title: Text("Compartir"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.close,
              color: Colors.white,
            ),
            title: Text("Salir"),
            onTap: () {
              signout();
              Navigator.push(context, Animation_route(Login()))
                  .whenComplete(() => Navigator.of(context).pop());
            },
          ),
        ],
      ),
    );
  }
}

Future<void> signout() async {
  await FirebaseAuth.instance.signOut();
}
