import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:library_app/pages/userBooks.dart';
import 'package:email_validator/email_validator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();




  runApp(const signUp());
}

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
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
      MediaQuery.of(context).size.width * 2 / 3;

  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailControllerConfirm = TextEditingController();
  TextEditingController _passwordControllerConfirm = TextEditingController();


  @override
  Widget build(BuildContext context) {
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
                    children:  <Widget>[
                      Form(
                        autovalidateMode: AutovalidateMode.always,

                        child: TextFormField(
                          validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                          controller: _emailController,
                          decoration: InputDecoration(
                              icon: const Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade100 )),
                              labelText: "Email",
                              enabledBorder: InputBorder.none,
                              labelStyle: const TextStyle(color: Colors.black)),
                        ),
                      ),
                      Form(
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                          controller: _emailControllerConfirm,
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: const Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 3,color: Colors.grey.shade100)),
                              labelText: "Confirm Email",
                              enabledBorder: InputBorder.none,
                              labelStyle: const TextStyle(color: Colors.black)),

                        ),
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
                                BorderSide(width: 3,color: Colors.grey.shade100)),
                            labelText: "Password",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.black)),

                      ),
                      TextField(
                        controller: _passwordControllerConfirm,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(width: 3,color: Colors.grey.shade100)),
                            labelText: "Confirm Password",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.black)),

                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [
                                    Colors.black,//Come back to this
                                    Colors.black
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () {//Confirm that both email and password fields match and then do firebase
                                if(_emailController.text == _emailControllerConfirm.text && _passwordController.text == _passwordControllerConfirm.text){
                                  if(_emailController.text.isNotEmpty || _passwordController.text.isNotEmpty) {//ensure fields arent empty
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text);

                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) => userBooks()));
                                  }
                                }

                              },
                              child: const Center(
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
