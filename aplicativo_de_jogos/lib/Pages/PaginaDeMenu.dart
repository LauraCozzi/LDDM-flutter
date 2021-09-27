import 'package:aplicativo_de_jogos/Pages/PaginaJogoAdivinhacao.dart';
import 'package:aplicativo_de_jogos/Pages/PaginaSobre.dart';
import 'package:aplicativo_de_jogos/Pages/PaginaTicTacToe.dart';
import 'package:flutter/material.dart';

class PaginaDeMenu extends StatefulWidget {
  @override
  _PaginaDeMenuState createState() => _PaginaDeMenuState();
}

class _PaginaDeMenuState extends State<PaginaDeMenu> {

  void _abrirPaginaSobre() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaginaSobre()
        ));
  }

  void _abrirPaginaAdivinhacao() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaginaJogoAdivinhacao()
        ));
  }

  void _abrirPaginaTicTacToe() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaginaTicTacToe()
        ));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: const Text('Jogos',
              style: TextStyle(color: Colors.white, fontSize: 25)),
          backgroundColor: Colors.yellow,
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 50),
          color: Colors.white24,
          child: ListView(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _abrirPaginaSobre,
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset("assets/Images/home.png"),
                        )
                    )
                  ],
              ),),
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: _abrirPaginaAdivinhacao,
                        child: SizedBox(
                          width: 160,
                          height: 160,
                          child: Image.asset("assets/Images/marioInterrogacao.png"),
                        )
                    )
                  ],
                ),),
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: _abrirPaginaTicTacToe,
                        child: SizedBox(
                          width: 180,
                          height: 180,
                          child: Image.asset("assets/Images/manete.png"),
                        )
                    )
                  ],
                ),),
            ],
          ),
        )
    );
  }
}
