import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/helper/fun%C3%A7%C3%B5es.dart';
import 'package:quiz/telas/home.dart';
import 'package:quiz/telas/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseFirestore.instance.collection("Test").doc("usuário1").set({"Lauraaa": "estudantes", "Teste2": "função"});
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLogado = false;

  @override
  void initState() {
    verificarLogado();
    super.initState();
  }

  verificarLogado() async {
    HelperFunctions.getUserLogado().then((value) {
      setState(() {
        // tirar isso para logar de novo
        //isLogado = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (isLogado ?? false) ? Home() : LoginScreen(),
    );
  }
}
