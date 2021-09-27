// sign in
import 'package:flutter/material.dart';
import 'package:quiz/helper/fun%C3%A7%C3%B5es.dart';
import 'package:quiz/services/auth.dart';
import 'package:quiz/widget/widgets.dart';

import 'cadastro.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email,senha;
  final _formKey = GlobalKey<FormState>();
  AuthService authService = new AuthService();

  bool isCarregando = false;

  login() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isCarregando = true;
      });
      await authService.loginEmailESenha(
          email, senha).then((value) {
        if (value != null) {
          setState(() {
            isCarregando = false;
          });
          HelperFunctions.salvarUserLogado(estaLogado: true);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Home()
          ));
        }});
    }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: appBar(context),
      centerTitle: true,
      // titulo centralizado
      backgroundColor: Colors.transparent,
      // sem cor o appbar
      elevation: 0.0,
      // tira o cinza
      brightness:
      Brightness.light, // volta com a cor original das horas e bateria
    ),
    body: isCarregando ? Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ) : Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.only(top: 30, left: 24, right: 24),
        children: <Widget>[
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset("assets/Images/quiz.png"),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            child: Column(
              children: <Widget>[
                // Spacer(),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty ? "Campo vazio" : null;
                  },
                  decoration: InputDecoration(hintText: "E-mail"),
                  onChanged: (val) {
                    email = val;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) {
                    return val.isEmpty ? "Campo vazio" : null;
                  },
                  decoration: InputDecoration(hintText: "Senha"),
                  onChanged: (val) {
                    senha = val;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: Botao(context: context, texto: "Login")
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Não possui uma conta? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => TelaCadastro()
                          ));
                        },
                        child: Text(
                          "Cadastre-se!",
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}}
