import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_app/pages/SignUp.dart';
import 'package:library_app/pages/ForgotPassword.dart';


void main() {
  runApp(const signIn());
}

class signIn extends StatefulWidget {
  const signIn({Key? key}) : super(key: key);

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {

  //Initialize Firebase App
  //https://www.youtube.com/watch?v=aKgEEnVhU1I
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MainPage();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery
          .of(context)
          .size
          .width * 2 / 3;

  double getBigDiameter(BuildContext context) =>
      MediaQuery
          .of(context)
          .size
          .width * 7 / 8;



  //Login Function
  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        print("No user found for that email");
      }
    }
    return user;
  }
  @override
  Widget build(BuildContext context) {
    //create the textfield controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xffBF9075),
      body: Stack(
        children: <Widget>[
          Image.asset("assets/book2.jpg"),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                            labelText: "Email",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(
                                    width: 3, color: Colors.grey.shade100)),
                            labelText: "Password",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.black)),

                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                    child: TextButton(style: TextButton.styleFrom(
                      textStyle: TextStyle(fontSize: 15),
                      foregroundColor: Colors.black,
                    ),
                      onPressed: () {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) => new forgotPassword()));
                      },
                      child: const Text('Forgot Password'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.5,
                        height: 40,
                        child: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () async{

                                //test app
                                User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                                print(user);
                                if(user != null){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> signUp()));
                                }


                              },
                              child: const Center(
                                child: Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [
                                    Colors.black, //Come back to this
                                    Colors.black
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        mini: true,
                        backgroundColor: Colors.white,
                        //elevation: 0,
                        child: const Image(
                          image: AssetImage("assets/facebook.png"),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        mini: true,
                        backgroundColor: Colors.white,
                        //elevation: 0,
                        child: const Image(
                          image: AssetImage("assets/google.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "DON'T HAVE AN ACCOUNT ? ",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: TextButton(style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: 15),
                        foregroundColor: Colors.black,
                      ),
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new signUp()));
                        },
                        //https://dev.to/zeeshanmehdi/flutter-could-not-find-a-generator-for-route-routesettings-somepage-null-in-the-widgetsappstate-2pcp
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
