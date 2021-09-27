import 'package:flutter/material.dart';
import 'package:onehand_app/constants.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

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
                          colors: [Colors.cyanAccent, Colors.cyan]))),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.all(
                        15.0 + MediaQuery.of(context).viewPadding.top),
                    child: Center(
                        child: Text("Ofertas", style: kGrabWhiteRegularSmall)))
              ]))
        ],
      )
    ]);
  }
}
