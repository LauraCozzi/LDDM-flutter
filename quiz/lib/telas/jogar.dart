import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/pergunta_model.dart';
import 'package:quiz/services/bancoDeDados.dart';
import 'package:quiz/telas/resultado.dart';
import 'package:quiz/widget/jogoQuiz.dart';
import 'package:quiz/widget/widgets.dart';

class ScreenJogar extends StatefulWidget {
  final String quizID;

  ScreenJogar(this.quizID);

  @override
  _ScreenJogarState createState() => _ScreenJogarState();
}

int total = 0;
int _corretas = 0;
int _incorretas = 0;
int naoRespondidas = 0;

class _ScreenJogarState extends State<ScreenJogar> {
  BancoDados databaseServie = BancoDados();
  QuerySnapshot questionSnapshot;

  PerguntaModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    PerguntaModel perguntaModel = new PerguntaModel();

    perguntaModel.pergunta = questionSnapshot.data()["pergunta"];

    List<String> opcoes = [
      questionSnapshot.data()["opção1"],
      questionSnapshot.data()["opção2"],
      questionSnapshot.data()["opção3"],
      questionSnapshot.data()["opção4"],
    ];
    opcoes.shuffle();

    perguntaModel.opcao1 = opcoes[0];
    perguntaModel.opcao2 = opcoes[1];
    perguntaModel.opcao3 = opcoes[2];
    perguntaModel.opcao4 = opcoes[3];
    perguntaModel.opcaoCorreta = questionSnapshot.data()["opção1"];
    perguntaModel.respondida = false;

    return perguntaModel;
  }

  @override
  void initState() {
    print("${widget.quizID}");
    databaseServie.getQuizPerguntas(widget.quizID).then((value) {
      questionSnapshot = value;
      naoRespondidas = 0;
      _corretas = 0;
      _incorretas = 0;
      total = questionSnapshot.docs.length;

      print("$total esse é o total de pontos");
      setState(() {});
    });
    super.initState();
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
        iconTheme: IconThemeData(color: Colors.black87),
        // setinha para voltar
        brightness:
            Brightness.light, // volta com a cor original das horas e bateria
      ),
      body: Container(
        child: Column(
          children: [
            questionSnapshot == null
                ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: questionSnapshot.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return QuizPlayTile(perguntaModel: getQuestionModelFromDatasnapshot(questionSnapshot.docs[index],), index: index,
                      );
                    })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Resultado(
            corretas: _corretas,
            incorretas: _incorretas,
            total: total,
          )));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final PerguntaModel perguntaModel;
  final int index;

  QuizPlayTile({this.perguntaModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String opcaoSelecionada = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Q${widget.index + 1} ${widget.perguntaModel.pergunta}", style: TextStyle(fontSize: 17, color: Colors.black87),),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if(!widget.perguntaModel.respondida) {
                //correta
                if(widget.perguntaModel.opcao1 == widget.perguntaModel.opcaoCorreta) {
                  opcaoSelecionada = widget.perguntaModel.opcao1;
                  widget.perguntaModel.respondida = true;
                  _corretas++;
                  naoRespondidas--;
                  setState(() {

                  });
                } else {
                  opcaoSelecionada = widget.perguntaModel.opcao1;
                  widget.perguntaModel.respondida = true;
                  _incorretas++;
                  naoRespondidas--;
                  setState(() {

                  });
                }
              }
            },
            child: Opcoes(
              respostaCorreta: widget.perguntaModel.opcaoCorreta,
              opcaoSelecionada: opcaoSelecionada,
              resosta: widget.perguntaModel.opcao1,
              opcao: "A",
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if(!widget.perguntaModel.respondida) {
                //correta
                if(widget.perguntaModel.opcao2 == widget.perguntaModel.opcaoCorreta) {
                  opcaoSelecionada = widget.perguntaModel.opcao2;
                  widget.perguntaModel.respondida = true;
                  _corretas++;
                  naoRespondidas--;
                  setState(() {

                  });
                } else {
                  opcaoSelecionada = widget.perguntaModel.opcao2;
                  widget.perguntaModel.respondida = true;
                  _incorretas++;
                  naoRespondidas--;
                  setState(() {

                  });
                }
              }
            },
            child: Opcoes(
              respostaCorreta: widget.perguntaModel.opcaoCorreta,
              opcaoSelecionada: opcaoSelecionada,
              resosta: widget.perguntaModel.opcao2,
              opcao: "B",
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if(!widget.perguntaModel.respondida) {
                //correta
                if(widget.perguntaModel.opcao3 == widget.perguntaModel.opcaoCorreta) {
                  opcaoSelecionada = widget.perguntaModel.opcao3;
                  widget.perguntaModel.respondida = true;
                  _corretas++;
                  naoRespondidas--;
                  setState(() {

                  });
                } else {
                  opcaoSelecionada = widget.perguntaModel.opcao3;
                  widget.perguntaModel.respondida = true;
                  _incorretas++;
                  naoRespondidas--;
                  setState(() {

                  });
                }
              }
            },
            child: Opcoes(
              respostaCorreta: widget.perguntaModel.opcao1,
              opcaoSelecionada: opcaoSelecionada,
              resosta: widget.perguntaModel.opcao3,
              opcao: "C",
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if(!widget.perguntaModel.respondida) {
                //correta
                if(widget.perguntaModel.opcao4 == widget.perguntaModel.opcaoCorreta) {
                  opcaoSelecionada = widget.perguntaModel.opcao4;
                  widget.perguntaModel.respondida = true;
                  _corretas++;
                  naoRespondidas--;
                  setState(() {

                  });
                } else {
                  opcaoSelecionada = widget.perguntaModel.opcao4;
                  widget.perguntaModel.respondida = true;
                  _incorretas++;
                  naoRespondidas--;
                  setState(() {

                  });
                }
              }
            },
            child: Opcoes(
              respostaCorreta: widget.perguntaModel.opcaoCorreta,
              opcaoSelecionada: opcaoSelecionada,
              resosta: widget.perguntaModel.opcao4,
              opcao: "D",
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
