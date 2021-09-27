import 'package:flutter/material.dart';
import 'package:onehand_app/global.dart';
import 'package:onehand_app/widgets/icon_menu.dart';
import 'package:onehand_app/widgets/more_icon_menu.dart';
import 'package:onehand_app/constants.dart';

class PanelClientScreen extends StatefulWidget {
  @override
  _PanelClientScreenState createState() => _PanelClientScreenState();
}

class _PanelClientScreenState extends State<PanelClientScreen> {
  late String greetings;
  @override
  Widget build(BuildContext context) {
    greetings = getGreetings();
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 130 + MediaQuery.of(context).viewPadding.top,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.blueAccent,
                        Colors.blue,
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 140,
                  color: Colors.white,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                        15.0 + MediaQuery.of(context).viewPadding.top),
                    child: Center(
                      child: Text(
                        greetings + ", " + Global.user.nombre,
                        style: kGrabWhiteRegularSmall,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Balance",
                                style:
                                    kGrabBlackBoldMedium.copyWith(fontSize: 20),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text("\$",
                                    style: kGrabBlackRegularSmall.copyWith(
                                        color: Colors.grey)),
                              ),
                              Text(
                                "0",
                                style: kGrabBlackBoldMedium.copyWith(
                                    color: Colors.black, fontSize: 20),
                              ),
                              SizedBox(width: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconMenu(
                                image: "assets/images/pay/pay.png",
                                title: "  Pagar  ",
                              ),
                              IconMenu(
                                image: "assets/images/pay/topu.png",
                                title: "Recargar",
                              ),
                              IconMenu(
                                image: "assets/images/pay/reward.png",
                                title: "Recompensas",
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconMenu(
                    image: "assets/images/oficios/cuidadora.png",
                    title: "Niñera",
                  ),
                  IconMenu(
                    image: "assets/images/oficios/electrico.png",
                    title: "Eléctrico",
                  ),
                  IconMenu(
                    image: "assets/images/oficios/mecanico.png",
                    title: "Mecánico",
                  ),
                  IconMenu(
                    image: "assets/images/oficios/enfermera.png",
                    title: "Enfermera",
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconMenu(
                    image: "assets/images/oficios/informatico.png",
                    title: "Informático",
                  ),
                  IconMenu(
                    image: "assets/images/oficios/kinesiologo.png",
                    title: "Kinesiólogo",
                  ),
                  IconMenu(
                    image: "assets/images/oficios/gasfiter.png",
                    title: "Gasfiter",
                  ),
                  MoreIconMenu(),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 8,
          color: Colors.grey[300],
        ) /*,
        GridView.count(
          padding: EdgeInsets.all(5),
          childAspectRatio: .75,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(
            10,
            (index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  borderRadius: BorderRadiusDirectional.circular(15),
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            "https://image.freepik.com/free-vector/square-food-banner-with-photo_23-2148118766.jpg",
                            fit: BoxFit.cover,
                            // height: 150,
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text("Article Title Here",
                                style: kGrabBlackRegularSmall.copyWith(
                                    fontSize: 15)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Text("1 min read",
                                  style: kGrabBlackRegularSmall.copyWith(
                                      fontSize: 15)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      */
      ],
    );
  }

  String getGreetings() {
    DateTime now = new DateTime.now();
    if (now.hour > 0 && now.hour < 12) {
      return "Buenos días";
    } else if (now.hour >= 12 && now.hour < 21) {
      return "Buenas tardes";
    } else {
      return "Buenas noches";
    }
  }
}
