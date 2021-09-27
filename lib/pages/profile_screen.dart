import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onehand_app/main/login_screen.dart';
import 'package:onehand_app/menu/animation_route.dart';
import 'package:onehand_app/widgets/avatar_class.dart';

import '../global.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 130 + MediaQuery.of(context).viewPadding.top,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.greenAccent, Colors.green])))
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: Column(children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).viewPadding.top),
                  child: Center(child: Text("")),
                ),
                Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Global.avatarURL.isEmpty
                                    ? new AvatarClass(
                                            assetImage:
                                                'assets/images/avatar_user.png',
                                            size: 120,
                                            onClicked: (value) {})
                                        .buildAssetImage(context)
                                    : new AvatarClass(
                                            urlImage: Global.avatarURL,
                                            size: 120,
                                            onClicked: (value) {})
                                        .buildNetworkImage(context),
                                Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            Global.user.nombre +
                                                " " +
                                                Global.user.apellido,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 2)),
                                        SizedBox(height: 10),
                                        Text("Editar Perfil",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 15,
                                                color: Colors.grey[800])),
                                        TextButton(
                                          child: Text("Cerrar Sesión"),
                                          onPressed: () async {
                                            await FirebaseAuth.instance
                                                .signOut();
                                            Navigator.push(context,
                                                    Animation_route(Login()))
                                                .whenComplete(() =>
                                                    Navigator.of(context)
                                                        .pop());
                                          },
                                        )
                                      ],
                                    ))
                              ],
                            )
                          ],
                        )))
              ]))
        ],
      )
    ]);
  }

  Widget prefile() {
    return Container(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/avatar_user.png'),
              Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nombre usuario",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2)),
                      SizedBox(height: 10),
                      Text("Editar Perfil",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                              color: Colors.grey[800]))
                    ],
                  ))
            ],
          )),
    );
  }
}
