import 'package:flutter/material.dart';

import 'Pages/PaginaDeLogin.dart';

void main() {
  runApp(MaterialApp(
    title: 'Jogos',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.yellow,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white),
    home: PaginaDeLogin(),
  ));
}
