import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onehand_spa/pages/page_elejir.dart';

void main()async{
  //inicializar firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(UserApp());
}

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OneHand",
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
      ),
      home: HomePageMain(),
      routes: <String, WidgetBuilder>{},
    );
  }
}

class HomePageMain extends StatefulWidget {
  @override
  _SearchListState createState() => new _SearchListState();
}

class _SearchListState extends State<HomePageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreensElejir(),
    );
  }
}
