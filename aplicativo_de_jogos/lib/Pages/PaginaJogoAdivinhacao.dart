import 'dart:math';

import 'package:flutter/material.dart';

class PaginaJogoAdivinhacao extends StatefulWidget {
  @override
  _PaginaJogoAdivinhacaoState createState() => _PaginaJogoAdivinhacaoState();
}

class _PaginaJogoAdivinhacaoState extends State<PaginaJogoAdivinhacao> {
  TextEditingController numeroInseridoUsuario = TextEditingController();
  String _infoText =
      "Clique em Verificar para conferir se você acertou ou não!";
  Random random = new Random();
  int numeroAleatorio = 0;

  int _inicioJogo() {
    int numeroAleatorio = random.nextInt(50);
    print(numeroAleatorio);
    return numeroAleatorio;
  }

  void verificaValores(int numeroAleatorio) {
    setState(() {
      int valorUsuario = int.parse(numeroInseridoUsuario.text);

      if (numeroAleatorio < valorUsuario)
        _infoText = "O número gerado é MENOR";
      else if (numeroAleatorio > valorUsuario)
        _infoText = "O número gerado é MAIOR";
      else
        _infoText = "Você acertou!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Jogo Adivinhação',
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
              width: 120,
              height: 120,
              child: Image.asset("assets/Images/marioInterrogacao.png"),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Neste Jogo, geraremos um número aleatório entre 0 e 50!",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
            Text("E você terá que descobrir qual é esse número!",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
            Text("Ao longo de suas tentativas daremos algumas dicas!",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Vamos lá?",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 20,
              height: 60,
              alignment: Alignment.centerLeft,
              // bordas redondas
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.7],
                  colors: [
                    Color(0xFFFFD700),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Gerar Valor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                          child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.videogame_asset,
                            color: Colors.white,
                          )
                        ],
                      ))
                    ],
                  ),
                  onPressed: () => {numeroAleatorio = _inicioJogo()},
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Qual foi o número sorteado?",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              controller: numeroInseridoUsuario,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              // bordas redondas
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.7],
                  colors: [
                    Color(0xFFFFD700),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Verificar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    onPressed: () => {verificaValores(numeroAleatorio)}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
