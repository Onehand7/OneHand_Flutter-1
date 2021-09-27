import 'package:flutter/material.dart';
import 'package:onehand_app/constants.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> messages = ["Hola", "Adios"];
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
                          colors: [Colors.blueGrey, Colors.grey]))),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.all(
                        15.0 + MediaQuery.of(context).viewPadding.top),
                    child: Center(
                        child: Text("Mensajes", style: kGrabWhiteRegularSmall)))
              ])),
          Scrollbar(
              showTrackOnHover: true,
              thickness: 5.0,
              child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(bottom: (index == 0) ? 5 : 0),
                        child: ListTile(
                            dense: true,
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Text("Titulo Mensaje")));
                  }))
        ],
      )
    ]);
  }
}
