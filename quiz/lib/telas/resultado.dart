import 'package:flutter/material.dart';
import 'package:quiz/widget/widgets.dart';

class Resultado extends StatefulWidget {

  final int corretas, incorretas, total;
  Resultado({@required this.corretas, @required this.incorretas, @required this.total});

  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.corretas}/${widget.total}", style: TextStyle(fontSize: 17),),
              SizedBox(height: 8,),
              Text("Você respondeu ${widget.corretas} respostas corretas e ${widget.incorretas} respostas incorretas!", style: TextStyle(fontSize: 15, color: Colors.grey), textAlign: TextAlign.center,),
              SizedBox(
                height: 14,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Botao(context: context, texto: "Ir para os Quizzes", largura: MediaQuery.of(context).size.width/2))
            ],
          ),
        ),
      ),
    );
  }
}
