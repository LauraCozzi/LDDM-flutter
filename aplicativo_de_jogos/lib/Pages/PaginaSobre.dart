import 'package:flutter/material.dart';

class PaginaSobre extends StatefulWidget {
  @override
  _PaginaSobreState createState() => _PaginaSobreState();
}

class _PaginaSobreState extends State<PaginaSobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Sobre',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        color: Colors.white24,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset("assets/Images/home.png"),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
                "Este é um aplicativo feito para a disciplina de LDDM no curso de Ciência da Computação da PUC Minas.\n",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                )),
            Text("Temos neste aplicativo:",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                )),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset("assets/Images/marioInterrogacao.png"),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
                "Este é um jogo de adivinhação!\nSortearemos números de 1 a 50 e você terá que descobrir o valor gerado!",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                )),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset("assets/Images/manete.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                "Este é o famoso Jogo da Velha!\nTente completar uma linha, coluna ou diagonal com X ou O!",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                )),
          ],
        ),
      ),
    );
  }
}
