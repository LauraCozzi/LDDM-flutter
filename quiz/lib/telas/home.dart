import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/bancoDeDados.dart';
import 'package:quiz/widget/widgets.dart';

import 'criarQuiz.dart';
import 'jogar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream quizStream;
  BancoDados databaseServie = BancoDados();

  Widget quizLista() {
    return Container(
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null ? Container() :
          ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder:  (BuildContext context, int i) {
                var doc = snapshot.data.docs[i];
                var item = doc.data();
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ScreenJogar(
                        item['quizId']
                      )
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 24, right: 24, bottom: 8),
                    height: 150,
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(item['quizURL'], width: MediaQuery.of(context).size.width - 48, fit: BoxFit.cover,)),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black26,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item['quizTitulo'],  style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w500),),
                              SizedBox(height: 4,),
                              Text(item['quizDescricao'], style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                );
              });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseServie.getQuiz().then((val) {
      setState(() {
        quizStream = val;
      });
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
        brightness:
        Brightness.light, // volta com a cor original das horas e bateria
      ),
      body: quizLista(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // pode voltar a página
          Navigator.push(context, MaterialPageRoute(builder: (context) => CriarQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String quizURL;
  final String titulo;
  final String descricao;

  QuizTile({this.quizURL, this.titulo, this.descricao});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.network(quizURL),
          Container(
            child: Column(
              children: [
                Text(
                  titulo
                ),
                Text(
                  descricao
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

