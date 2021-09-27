import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class edicaoScreen extends StatefulWidget {
  @override
  _edicaoScreenState createState() => _edicaoScreenState();
}

class _edicaoScreenState extends State<edicaoScreen> {

  var nome = TextEditingController();
  var nomeNovo = TextEditingController();
  var detalhamentoNovo = TextEditingController();
  final db = FirebaseFirestore.instance;

  void _resetFields() {
    nome.text = "";
    nomeNovo.text = "";
    detalhamentoNovo.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Edição',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.lightGreen[500],
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Produto:",
                    hintText: "Digite o nome do produto que deseja alterar"
                ),
                controller: nome,
                validator: (String text){
                  if(text.isEmpty){
                    return "Digite o texto";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Novo produto:",
                    hintText: "Digite o novo nome do produto"
                ),
                controller: nomeNovo,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Novo Detalhamento:",
                    hintText: "Digite o novo detalhamento do produto"
                ),
                controller: detalhamentoNovo,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 46,
                child: RaisedButton(

                    color: Colors.lightGreen[500],
                    child: Text("Alterar",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),),
                    onPressed: () async {
                      QuerySnapshot resultado = await db.collection('Produtos').get();

                      resultado.docs.forEach((d) {
                        if(d.get('Produto').toLowerCase() == (nome.text).toLowerCase()) {
                          print('Achou');
                          if(detalhamentoNovo.text.isEmpty) detalhamentoNovo.text = d.get('Detalhamento');
                          if(nomeNovo.text.isEmpty) nomeNovo.text = d.get('Produto');

                          d.reference.update({
                            'Produto': nomeNovo.text,
                            'Detalhamento': detalhamentoNovo.text
                          });
                          _resetFields();
                        }
                      });
                    }
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 46,
                child: RaisedButton(
                    color: Colors.lightGreen[500],
                    child: Text("Deletar",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),),
                    onPressed: () async {
                      QuerySnapshot resultado = await db.collection('Produtos').get();
                      resultado.docs.forEach((d) {
                        if(d.get('Produto').toLowerCase() == (nome.text).toLowerCase()) {
                          print('Deletando');
                          d.reference.delete();
                          _resetFields();
                        }
                      });
                    }
                ),
              ),
            ]
        ),
      ),
    );
  }
}
