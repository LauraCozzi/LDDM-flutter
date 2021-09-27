import 'package:flutter/material.dart';
import 'package:quiz/services/bancoDeDados.dart';
import 'package:quiz/widget/widgets.dart';
import 'package:random_string/random_string.dart';

import 'adicionarPergunta.dart';

class CriarQuiz extends StatefulWidget {
  @override
  _CriarQuizState createState() => _CriarQuizState();
}

class _CriarQuizState extends State<CriarQuiz> {

  final _formKey = GlobalKey<FormState>();
  String urlImagem, titulo, descricao, quizID;
  BancoDados databaseServie = BancoDados();

  bool isCarregando = false;

  criarQuiz() async {
    if(_formKey.currentState.validate()) {

      setState(() {
        isCarregando = true;
      });

      quizID = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        "quizId" : quizID,
        "quizURL" : urlImagem,
        "quizTitulo" : titulo,
        "quizDescricao" : descricao,
      };

      await databaseServie.adicionarQuiz(quizMap, quizID).then((value) {
        setState(() {
          isCarregando = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => adicionarQuestao(
            quizID
          )));
        });
      });
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
        iconTheme: IconThemeData(color: Colors.black87), // setinha para voltar
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
          padding: EdgeInsets.only(top: 20, left: 24, right: 24),
          children: [
            Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset("assets/Images/cerebro.png"),
                ),
                SizedBox(
                  height: 60,
                ),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty ? "Campo vazio" : null;
                  },
                  decoration: InputDecoration(hintText: "URL de uma imagem para o Quiz"),
                  onChanged: (val) {
                    urlImagem = val;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty ? "Campo vazio" : null;
                  },
                  decoration: InputDecoration(hintText: "Título do Quiz"),
                  onChanged: (val) {
                    titulo = val;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty ? "Campo vazio" : null;
                  },
                  decoration: InputDecoration(hintText: "Descrição do Quiz"),
                  onChanged: (val) {
                    descricao = val;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    criarQuiz();
                  },
                    child: Botao(context: context, texto: "Criar Quiz"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
