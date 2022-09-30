import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  //sign in anon - www.youtube.com/watch?v=mZYuuGAIwe4&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;

    }
  }
  //sign email password

  //register email password

  //sign out

}