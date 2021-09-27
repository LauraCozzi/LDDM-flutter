import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //Tela inicial, na qual iremos interagir Stateful
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  //Validação
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);

      if (imc < 16) {
        _infoText = "Magreza Grave\n ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 16 && imc < 17) {
        _infoText = "Magreza Moderada\n ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 17 && imc < 18.5) {
        _infoText = "Magreza Leve\n ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.5 && imc < 25) {
        _infoText = "Saudável\n ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 25 && imc < 30) {
        _infoText = "Sobrepeso\n ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 30 && imc < 35) {
        _infoText = "Obesidade Grau I\n ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 35 && imc < 40) {
        _infoText = "Obesidade Grau II\n ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III\n ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.red),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.red)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 25.0),
                  controller: weightController,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Insira seu Peso!";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.red)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 25.0),
                  controller: heightController,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Insira sua Altura!";
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.red,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
