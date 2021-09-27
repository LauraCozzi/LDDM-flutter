import 'package:flutter/material.dart';

import 'PaginaLogin.dart';

void main() {
  runApp(MaterialApp(
    title: 'Lista de Tarefas',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white),
    home: PaginaDeLogin(),
  ));
}
