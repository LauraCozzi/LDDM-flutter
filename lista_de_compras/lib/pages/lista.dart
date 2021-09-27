import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class listaScreen extends StatefulWidget {
  @override
  _listaScreenState createState() => _listaScreenState();
}

class _listaScreenState extends State<listaScreen> {

  var snapshots = FirebaseFirestore.instance.collection('Produtos').where('Excluido', isEqualTo: false).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Produtos',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.lightGreen[500],
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: snapshots,
        builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              // widget que fica carregando
                child: CircularProgressIndicator());
          }

          if (snapshot.data.docs.length == 0) {
            return Center(child: Text('Nenhum produto na lista') // lista vazia
            );
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder:  (BuildContext context, int i) {
                var doc = snapshot.data.docs[i];
                var item = doc.data();

                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Column(
                    children: <Widget>[
                      Image.file(File(item['Caminho']), fit: BoxFit.fill,height: 200,),
                      Text(item['Produto'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                      Text(item['Detalhamento']),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                //  CircleAvatar(
                 //   radius: 80,
                 //   backgroundColor: Colors.lightGreen,
                 //   child: ClipOval(
                  //    child: SizedBox(
                  //      width: 140.0,
                  //      height: 140,
                  //      // tirar essa linha
                  //      child: Image.file(File(item['Caminho']), fit: BoxFit.fill,)
                  //    ),
                   // ),
                 // ),
                );
              });
        },
      ),
    );
  }
}

Future<Widget> _getImage(BuildContext context, String imageName) async{
  Image image;
  await FireStorageService.loadImage(context, imageName).then((value) {
    image = Image.network(value.toString(), fit: BoxFit.scaleDown,);
  });
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}

