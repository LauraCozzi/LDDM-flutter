import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_de_compras/pages/tabBar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseFirestore.instance.collection("Test").doc("usuário1").set({"Lauraaa": "estudantes", "Teste2": "função"});
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TabbedAppBarDemo(),
  ));
}
