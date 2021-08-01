import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onehand_spa/login.dart';

void main() async {
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
      home: LoginUser(title: "Login"),
      routes: <String, WidgetBuilder>{},
    );
  }
}
