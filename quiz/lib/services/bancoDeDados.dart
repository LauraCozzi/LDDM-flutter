import 'package:cloud_firestore/cloud_firestore.dart';

class BancoDados {
  Future<void> adicionarQuiz(Map quiz, String quizID) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizID)
        .set(quiz)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> adicionarPergunta(Map pergunta, String quizID) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizID)
        .collection("PR")
        .add(pergunta)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuiz() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  // pega os dados, as opções e as perguntas
  getQuizPerguntas(String quizID) async{
    return await FirebaseFirestore.instance.collection("Quiz").doc(quizID).collection("PR").get();
  }
}
