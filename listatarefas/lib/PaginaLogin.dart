import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PaginaLista.dart';

class PaginaDeLogin extends StatefulWidget {
  @override
  _PaginaDeLoginState createState() => _PaginaDeLoginState();
}

class _PaginaDeLoginState extends State<PaginaDeLogin> {
  TextEditingController _controllerUserName = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  var _infoText = "Cadastre-se";
  final _formKey = GlobalKey<FormState>();

  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 15),
    );
  }

  void _resetFields() {
    _controllerUserName.text = "";
    _controllerPassword.text = "";
    setState(() {
      _infoText = "Cadastre-se";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // pega toda a página
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Login',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        key: _formKey, //estado do formulário
        padding: EdgeInsets.only(top: 50, left: 40, right: 40),
        color: Colors.white,
        // teclado não ficar em cima dos itens
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 250,
              child: Image.asset('assets/Images/toDo.jpg'),
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
              validator: (String text) {
                if (text.isEmpty) {
                  return "Digite a senha ";
                } //fim if
                if (text.length < 4) {
                  return "A senha tem pelo menos 4 dígitos";
                } //fim if
                return null;
              },
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
                    Color(0xFF0404B4),
                    Color(0xFF0080FF),
                    Color(0xFF013ADF),
                    Color(0xFF0040FF),
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
                            Icons.done,
                            color: Colors.white,
                          )
                        ],
                      ))
                    ],
                  ),
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final String login =
                        await prefs.getString("_controllerUserName");
                    final String senha =
                        await prefs.getString("_controllerPassword");
                    //bool formOk = _formKey.currentState.validate();
                      if (login == _controllerUserName.text &&
                          senha == _controllerPassword.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaginaLista()),
                        );
                      } else {
                        setState(() {
                          _infoText =
                              "Usuário não enontrado.\n Tente novamente!";
                          _textInfo();
                        });
                      } //fim if

                    print("Login " + _controllerUserName.text);
                    print("Senha " + _controllerPassword.text);
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
              // bordas redondas
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.4, 0.7, 1],
                  colors: [
                    Color(0xFF013ADF),
                    Color(0xFF0080FF),
                    Color(0xFF013ADF),
                    Color(0xFF2E9AFE),
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
                        "Cadastrar Novo Usuário",
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
                            Icons.person_add,
                            color: Colors.white,
                          )
                        ],
                      ))
                    ],
                  ),
                  onPressed: () async {
                    String entrada = _controllerUserName.text;
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString("_controllerUserName", entrada);
                    entrada = _controllerPassword.text;
                    await prefs.setString("_controllerPassword", entrada);
                    setState(() {
                      _infoText = "Cadastro realizado!";
                      _textInfo();
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _textInfo(),
          ],
        ),
      ),
    );
  }
}
