import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: 25,
      ),
      children: <TextSpan>[
        TextSpan(text: 'Quiz', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
        TextSpan(text: 'zes', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
      ],
    ),
  );
}

Widget Botao({BuildContext context, String texto, largura}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(30),
    ),
    alignment: Alignment.center,
    // escrito no centro
    width: largura != null ? largura : MediaQuery
        .of(context)
        .size
        .width - 48,
    child: Text(
      texto,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}