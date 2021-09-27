import 'package:flutter/material.dart';
import 'package:onehand_app/constants.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

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
                          colors: [Colors.indigoAccent, Colors.indigo]))),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.all(
                        15.0 + MediaQuery.of(context).viewPadding.top),
                    child: Center(
                        child: Text("Historial de Servicios",
                            style: kGrabWhiteRegularSmall)))
              ]))
        ],
      )
    ]);
  }
}
