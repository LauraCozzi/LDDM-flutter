import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PaginaDeMenu.dart';

class PaginaDeLogin extends StatefulWidget {
  @override
  _PaginaDeLoginState createState() => _PaginaDeLoginState();
}

class _PaginaDeLoginState extends State<PaginaDeLogin> {
  TextEditingController _controllerUserName = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // pega toda a página
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Jogos',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Container(
        key: _formKey, //estado do formulário
        padding: EdgeInsets.only(top: 50, left: 40, right: 40),
        color: Colors.white24,
        // teclado não ficar em cima dos itens
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 250,
              child: Image.asset("assets/Images/controllerLogin.png"),
            ),
            // Espaço entre campos
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              controller: _controllerUserName,
              validator: (String text) {
                if (text.isEmpty) {
                  return "Digite o E-mail";
                }
                return null;
              },
              //dentro da caixa de texto
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              controller: _controllerPassword,
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Recuperar Senha",
                  style: TextStyle(color: Colors.black54),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              // bordas redondas
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.4, 0.7, 1],
                  colors: [
                    Color(0xFFFACC2E),
                    Color(0xFFF7FE2E),
                    Color(0xFFFFFF00),
                    Color(0xFFFACC2E),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaginaDeMenu()),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Color(0xFF3C5A99),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login com Facebook",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          child: Image.asset("assets/Images/fb-icon.png"),
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: FlatButton(
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
