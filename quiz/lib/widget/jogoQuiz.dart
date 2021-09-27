import 'package:flutter/material.dart';

class Opcoes extends StatefulWidget {

  final String opcao, resosta, respostaCorreta, opcaoSelecionada;
  Opcoes({@required this.opcao, @required this.resosta, @required this.respostaCorreta, @required this.opcaoSelecionada});

  @override
  _OpcoesState createState() => _OpcoesState();
}

class _OpcoesState extends State<Opcoes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: widget.resosta == widget.opcaoSelecionada ? widget.opcaoSelecionada == widget.respostaCorreta ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7) : Colors.grey, width: 1.4),
              borderRadius: BorderRadius.circular(30)
            ),
            alignment: Alignment.center,
            child: Text("${widget.opcao}", style: TextStyle(
              color: widget.opcaoSelecionada == widget.resosta ? widget.respostaCorreta == widget.opcaoSelecionada ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7) : Colors.black54,
            ),),
          ),
          SizedBox(
            width: 8,
          ),
          Text(widget.resosta, style: TextStyle(
            fontSize: 16, color: Colors.black54
          ),),
        ],
      ),
    );
  }
}
