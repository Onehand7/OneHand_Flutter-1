import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:onehand_app/menu/menu_lateral.dart';

import '../constants.dart';
import 'newsolicitud_page.dart';

class MenuPage extends StatefulWidget {
  final String user;
  const MenuPage(this.user, {Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int pageIndex = 1;

  _pageCurveNavigationBar(int page) {
    switch (page) {
      case 0:
        return _listSolicitudes(context);
      case 1:
        return (widget.user) == "Cliente"
            ? _menuCliente(context, widget.user.toString())
            : _menuTecnico(context);
      case 2:
        return _listChat(context);
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text("Menu")),
      ),
      drawer: MenuLateral(),
      body: _pageCurveNavigationBar(pageIndex),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        items: [
          Icon(
            Icons.book,
            size: 33.0,
          ),
          Icon(
            Icons.home,
            size: 33.0,
          ),
          Icon(
            Icons.forum,
            size: 33.0,
          ),
        ],
        color: Colors.black87,
        buttonBackgroundColor: Colors.black87,
        backgroundColor: colorBlue,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (tappedIndex) {
          setState(() {
            pageIndex = tappedIndex;
            //_pageCurveNavigationBar(pageIndex);
          });
        },
      ),
    );
  }
}

Widget _menuCliente(BuildContext context, String user) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: <Widget>[
      Container(
        height: size.height,
        decoration: BoxDecoration(
          color: colorBlue,
          //borderRadius: BorderRadius.circular(30),
        ),
      ),

      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget>[
            _buttonServicios(
                "Baby Sister", AssetImage("assets/icono_babySister.jpg"), user),
            _buttonServicios(
                "Eléctrico", AssetImage("assets/icono_electrico.png"), user),
            _buttonServicios("Electromecánico",
                AssetImage("assets/icono_electromecanico.png"), user),
            _buttonServicios(
                "Enfermería", AssetImage("assets/icono_enfermera.png"), user),
            _buttonServicios(
                "Gásfiter", AssetImage("assets/icono_plomero.png"), user),
            _buttonServicios("Informática",
                AssetImage("assets/icono_informatica.png"), user),
            _buttonServicios("Kinesiólogo",
                AssetImage("assets/icono_kinesiologo.jpg"), user),
            _buttonServicios(
                "Mecánico", AssetImage("assets/icono_mecanica.png"), user),
            _buttonServicios("Pedagogía básica",
                AssetImage("assets/icono_pedagogia.png"), user),
            _buttonServicios(
                "Turismo", AssetImage("assets/icono_turismo.png"), user),
          ],
        ),
      ),
      //_getDrawerItemWidget(_selectDrawerItem),
    ],
  );
}

Widget _menuTecnico(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: <Widget>[
      Container(
        height: size.height,
        decoration: BoxDecoration(
          color: colorBlue,
          //borderRadius: BorderRadius.circular(30),
        ),
      ),
      ListView(
        children: <Widget>[
          _buttonSelectTecnico(
              Icon(Icons.brightness_auto_rounded),
              Text("Certificación"),
              Text("Consigue el certificado de seguridad de forma gratuita")),
          _buttonSelectTecnico(Icon(Icons.chat_bubble), Text("Chat"),
              Text("Revisa tus conversaciones pendientes")),
          _buttonSelectTecnico(
              Icon(Icons.article_outlined),
              Text("Solicitudes"),
              Text("Se mostraran tus solicitudes a responder")),
          _buttonSelectTecnico(
            Icon(Icons.auto_awesome),
            Text("Premium"),
            Text("Hazte premium y obtendrás mas beneficios."),
          ),
        ],
      )
      //_getDrawerItemWidget(_selectDrawerItem),
    ],
  );
}

Widget _listSolicitudes(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: [
      Container(
        height: size.height,
        decoration: BoxDecoration(color: colorBlue),
      ),
      ListView(
        children: [
          _buttonListSolicitud(
              Text("Arreglo de cañeria"),
              Text("Tengo mala la cañeria de mi baño. aiuda"),
              Icon(Icons.photo_camera)),
          _buttonListSolicitud(
              Text("Reparación de pc"),
              Text("Necesito que se pueda reparar mi computadora"),
              Icon(Icons.photo_camera))
        ],
      )
    ],
  );
}

Widget _listChat(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: [
      Container(
        height: size.height,
        decoration: BoxDecoration(
          color: colorBlue,
          //borderRadius: BorderRadius.circular(30),
        ),
      ),
      ListView(
        children: [
          _buttonListChat(
              Icon(Icons.account_circle_outlined),
              Text("Jose Perez Villalobos"),
              Text("oka, Gracias!"),
              Text("10-06-2021")),
          _buttonListChat(
              Icon(Icons.account_circle_outlined),
              Text("Andrea Rojas Monje"),
              Text("Necesito el arreglo ahorita"),
              Text("02-07-2021")),
        ],
      )
    ],
  );
}

// ignore: camel_case_types
class _buttonSelectTecnico extends StatelessWidget {
  final Icon icons;
  final Text label;
  final Text subtitle;

  _buttonSelectTecnico(this.icons, this.label, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
              title: label,
              subtitle: subtitle,
              leading: icons,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(child: Text("Entrar"), onPressed: () => {}),
              ],
            )
          ],
        ));
  }
}

// ignore: camel_case_types
class _buttonServicios extends StatelessWidget {
  final String label;
  final AssetImage iconosService;
  final String user;

  _buttonServicios(this.label, this.iconosService, this.user);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: iconosService,
          ),
        ),
        child: TextButton(
            child: Text(""),
            onPressed: () {
              switch (label) {
                case "Baby Sister":
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenNewSolicitud(name: label, user: user),
                  ));
                  break;
                case "Eléctrico":
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenNewSolicitud(name: label, user: user),
                  ));
                  break;
                case "Electromecánico":
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenNewSolicitud(name: label, user: user),
                  ));
                  break;
                case "Enfermería":
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenNewSolicitud(name: label, user: user),
                  ));
                  break;
                case "Gásfiter":
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenNewSolicitud(name: label, user: user),
                  ));
                  break;
                case "Informática":
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenNewSolicitud(name: label, user: user),
                  ));
                  break;
                case "Kinesiólogo":
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenNewSolicitud(name: label, user: user),
                  ));
                  break;
                case "Mecánico":
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenNewSolicitud(name: label, user: user),
                  ));
                  break;
                case "Pedagogía básica":
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenNewSolicitud(name: label, user: user),
                  ));
                  break;
                case "Turismo":
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenNewSolicitud(name: label, user: user),
                  ));
                  break;

                default:
              }
            }),
      ),
    );
  }
}

// ignore: camel_case_types
class _buttonListSolicitud extends StatelessWidget {
  final Text label, subtitle;
  final Icon icon;

  _buttonListSolicitud(this.label, this.subtitle, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: label,
            subtitle: subtitle,
            trailing: icon,
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _buttonListChat extends StatelessWidget {
  final Icon icon;
  final Text label, subtitle, fecha;

  _buttonListChat(this.icon, this.label, this.subtitle, this.fecha);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            leading: icon,
            title: label,
            subtitle: subtitle,
            trailing: fecha,
          )
        ],
      ),
    );
  }
}
