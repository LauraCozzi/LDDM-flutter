import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz/models/user.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Usuario _userFromFirebaseUser(User user) {
    return user != null ? Usuario(uid: user.uid) : null;
  }

  Future loginEmailESenha(String email, String senha) async{
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: senha);
      User firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString());
    }
  }

  Future cadastroEmailSenha(String email, String senha) async{
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      User firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future deslogar() async{
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}