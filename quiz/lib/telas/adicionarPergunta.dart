import 'package:flutter/material.dart';
import 'package:quiz/services/bancoDeDados.dart';
import 'package:quiz/widget/widgets.dart';

class adicionarQuestao extends StatefulWidget {

 final String quizID;
 adicionarQuestao(this.quizID);

  @override
  _adicionarQuestaoState createState() => _adicionarQuestaoState();
}

class _adicionarQuestaoState extends State<adicionarQuestao> {

  String pergunta, opcao1, opcao2, opcao3, opcao4;
  final _formKey = GlobalKey<FormState>();
  bool isCarregando = false;
  BancoDados databaseServie = BancoDados();

  uploadPergunta() async{
    if(_formKey.currentState.validate()) {

      setState(() {
        isCarregando = true;
      });

      Map<String, String> perguntaMap = {
        "pergunta": pergunta,
        "opção1" : opcao1,
        "opção2" : opcao2,
        "opção3" : opcao3,
        "opção4" : opcao4,
      };

      await databaseServie.adicionarPergunta(perguntaMap, widget.quizID).then((value) {
        setState(() {
          isCarregando = false;
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
            Container(
              child: Column(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset("assets/Images/question.png", color: Colors.black54,),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty ? "Campo vazio" : null;
                    },
                    decoration: InputDecoration(hintText: "Pergunta"),
                    onChanged: (val) {
                      pergunta = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty ? "Campo vazio" : null;
                    },
                    decoration: InputDecoration(hintText: "Opção 1 (Correta)"),
                    onChanged: (val) {
                      opcao1 = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty ? "Campo vazio" : null;
                    },
                    decoration: InputDecoration(hintText: "Opção 2"),
                    onChanged: (val) {
                      opcao2 = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty ? "Campo vazio" : null;
                    },
                    decoration: InputDecoration(hintText: "Opção 3"),
                    onChanged: (val) {
                      opcao3 = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty ? "Campo vazio" : null;
                    },
                    decoration: InputDecoration(hintText: "Opção 4"),
                    onChanged: (val) {
                      opcao4 = val;
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // fecha janela
                          Navigator.pop(context);
                        },
                        child: Botao(context: context, texto: "Enviar", largura: MediaQuery.of(context).size.width/2 - 30),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          uploadPergunta();
                        },
                        child: Botao(context: context, texto: "Adicionar", largura: MediaQuery.of(context).size.width/2 - 30),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
