import 'package:flutter/material.dart';

class PaginaTicTacToe extends StatefulWidget {
  @override
  _PaginaTicTacToeState createState() => _PaginaTicTacToeState();
}

class _PaginaTicTacToeState extends State<PaginaTicTacToe> {
  List<List> _matrix;

  _PaginaTicTacToeState() {
    _initMatrix();
  }

  _initMatrix() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix.length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Jogo da Velha',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min, // Alinha para o centro
            children: [
              _buildElement(0, 0),
              _buildElement(0, 1),
              _buildElement(0, 2),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildElement(1, 0),
              _buildElement(1, 1),
              _buildElement(1, 2),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildElement(2, 0),
              _buildElement(2, 1),
              _buildElement(2, 2),
            ],
          ),
        ],
      )),
    );
  }

  String _lastChar = 'O';

  _buildElement(int i, int j) {
    return GestureDetector(
      onTap: () {
        // Coloca x ou o
        _adicionaXouO(i, j);

        if (_VerificaVencedor(i, j)) {
          _mostraAvisos(_matrix[i][j]);
        } else {
          // Se jogo acabou, mas sem vencedor
          if (_verificaMatriz()) {
            _mostraAvisos(null);
          }
        }
      },
      child: Container(
        width: 90.0,
        // Cria o desenho do jogo da velha
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, border: Border.all(color: Colors.black)),
        child: Center(
          child: Text(
            _matrix[i][j],
            style: TextStyle(fontSize: 92.0),
          ),
        ),
      ),
    );
  }

  _adicionaXouO(int i, int j) {
    setState(() {
      if (_matrix[i][j] == ' ') {
        if (_lastChar == 'O')
          _matrix[i][j] = 'X';
        else
          _matrix[i][j] = 'O';

        _lastChar = _matrix[i][j];
      }
    });
  }

  // Verifica se o jogo acabou ou não
  _verificaMatriz() {
    var espacosOcupado = true;
    _matrix.forEach((i) {
      i.forEach((j) {
        if (j == ' ') espacosOcupado = false;
      });
    });
    return espacosOcupado;
  }

  _VerificaVencedor(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length - 1; // 2
    var player = _matrix[x][y]; // X ou O

    for (int i = 0; i < _matrix.length; i++) {
      // Verifica x linha
      if (_matrix[x][i] == player) row++;
      // Verifica y coluna
      if (_matrix[i][y] == player) col++;
      // Verifica diagonal principal
      if (_matrix[i][i] == player) diag++;
      // Verifica diagonal secundária
      if (_matrix[i][n - i] == player) rdiag++;
    }
    // Verifica se alguém venceu
    if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      return true;
    }
    return false;
  }

  _mostraAvisos(String winner) {
    String aviso;
    if (winner == null) {
      aviso = 'Deu velha!\nNinguém ganhou!';
    } else {
      aviso = 'Jogador $winner venceu';
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Game over'),
            content: Text(aviso),
            actions: <Widget>[
              FlatButton(
                child: Text('Reiniciar o Jogo'),
                onPressed: () {
                  // tira o AlertDialog
                  Navigator.of(context).pop();
                  setState(() {
                    _initMatrix();
                  });
                },
              )
            ],
          );
        });
  }
}
