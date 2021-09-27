import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class cadastroScreen extends StatefulWidget {
  @override
  _cadastroScreenState createState() => _cadastroScreenState();
}

class _cadastroScreenState extends State<cadastroScreen> {
  var form = GlobalKey<FormState>();
  var produto = TextEditingController();
  var marca = TextEditingController();
  var detalhamento = TextEditingController();

  void _resetFields() {
    produto.text = "";
    marca.text = "";
    detalhamento.text = '';
    _image = Image.asset("assets/Images/carrinho.png") as File;
  }

  final picker = ImagePicker();

  File _image;

  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      final pickedImage = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(pickedImage.path);
      });
    }

    Future uploadPic(BuildContext context) async {
      String documento = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(documento);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Imagem salva'),));
      });
    }

    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Adicionar',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.lightGreen[500],
        centerTitle: true,
      ),
      //backgroundColor: Colors.purpleAccent[400],
      body: Form(
        //consegue armazenar o estado dos campos de texto e além disso, fazer a validação
        key: form, //estado do formulário
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Align(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.lightGreen,
                  child: ClipOval(
                    child: SizedBox(
                      width: 140.0,
                      height: 140,
                      // tirar essa linha
                      child: (_image != null)?Image.file(_image, fit: BoxFit.fill,)
                      :Image.asset("assets/Images/carrinho.png"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 30.0,
                  ),
                  onPressed: () {
                    getImage();
                  },
                ),
              ),
            ]),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  labelText: "Produto:", hintText: "Digite o nome do produto"),
              controller: produto,
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  labelText: "Marca:", hintText: "Digite a marca do produto"),
              controller: marca,
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
                  labelText: "Detalhamento:", hintText: "Digite mais detelhes"),
              controller: detalhamento,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 46,
              child: RaisedButton(
                  color: Colors.lightGreen[500],
                  child: Text(
                    "Adicionar produto em lista",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('Produtos')
                        .add({
                      'Produto': produto.text,
                      'Marca': marca.text,
                      'Detalhamento': detalhamento.text,
                      'Excluido': false,
                      'Caminho': _image.path
                    });
                    _resetFields();
                    uploadPic(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }



}
