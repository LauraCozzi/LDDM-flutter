import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController valorContaController = TextEditingController();
  TextEditingController quantidadePessoasController = TextEditingController();
  TextEditingController quantPessoasNotBebem = TextEditingController();
  TextEditingController valorContaBebidasController = TextEditingController();
  double porcentagem = 0.0;
  String escrita = "Porcentagem da Gorjeta";
  String _infoText = "Valor Gargom: R\$ \nValor Total: R\$ \nValor Individual(Bebida): R\$  \nValor Individual(S/ Bebida): R\$ ";

  void _resetFields() {
    valorContaController.text = "";
    quantidadePessoasController.text = "";
    quantPessoasNotBebem.text = "";
    valorContaBebidasController.text = "";
    porcentagem = 0.0;
    setState(() {
      _infoText = "Valor Gargom: R\$ \nValor Total: R\$ \nValor Individual(Bebida): R\$  \nValor Individual(S/ Bebida): R\$ ";
    });
  }

  void calcula() {
    setState(() {
      double valor = double.parse(valorContaController.text);
      double valorBebida = double.parse(valorContaBebidasController.text);
      int quantPessoas = int.parse(quantidadePessoasController.text);
      int quantPessoasNBebem = int.parse(quantPessoasNotBebem.text);
      double porcentagemGarcom = porcentagem;
      double valorTotal = 0;
      double valorIndividual = 0;
      double valorIndivisualSemBebida = 0.0;
      double valorGarcom = valor * (porcentagemGarcom/100);

      valorTotal = valorGarcom + valor;
      valorIndivisualSemBebida = (valorTotal - valorBebida)/quantPessoas;
      valorIndividual = valorIndivisualSemBebida + valorBebida/(quantPessoas - quantPessoasNBebem);

      _infoText = "Valor Gargom: R\$ ${valorGarcom.toStringAsPrecision(4)}\nValor Total: R\$ ${valorTotal.toStringAsPrecision(4)}\nValor Individual: R\$ ${valorIndividual.toStringAsPrecision(4)}\nValor Individual(S/ Bebida): R\$ ${valorIndivisualSemBebida.toStringAsPrecision(4)} ";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha Conta"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money),
                    labelText: "Valor da Conta: ",
                    labelStyle: TextStyle(color: Colors.cyan, fontSize: 20.0)),
                style: TextStyle(fontSize: 20, color: Colors.black),
                controller: valorContaController,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 15.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money),
                    labelText: "Valor Somente das Bebidas: ",
                    labelStyle: TextStyle(color: Colors.cyan, fontSize: 20.0)),
                style: TextStyle(fontSize: 20, color: Colors.black),
                controller: valorContaBebidasController,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 15.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.group),
                    labelText: "N° total de Pessoas: ",
                    labelStyle: TextStyle(color: Colors.cyan, fontSize: 20.0)),
                style: TextStyle(fontSize: 20, color: Colors.black),
                controller: quantidadePessoasController,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 15.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.group),
                    labelText: "N° de Pessoas que não bebem: ",
                    labelStyle: TextStyle(color: Colors.cyan, fontSize: 20.0)),
                style: TextStyle(fontSize: 20, color: Colors.black),
                controller: quantPessoasNotBebem,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 15.0),
              child: Text(
                "Porcentagem para o Garçom: ",
                style: TextStyle(color: Colors.cyan, fontSize: 20.0),
              ),
            ),
            Slider(
              value: porcentagem,
              min: 0,
              max: 100,
              label: escrita,
              divisions: 10,
              activeColor: Colors.cyan,
              inactiveColor: Colors.blueGrey,
              onChanged: (double valorPorcentagem) {
                setState(() {
                  porcentagem = valorPorcentagem;
                  escrita = valorPorcentagem.toString();
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: calcula,
                  child: Text("Calcular a divisão!",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  color: Colors.cyan,
                ),
              ),
            ),
            Text(
              _infoText,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.cyan, fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
