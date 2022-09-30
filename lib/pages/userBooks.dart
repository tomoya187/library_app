import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
Future<void> main() async {

  runApp(userBooks());
}

//https://www.youtube.com/watch?v=z05m8nlPRxk&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC&index=3

class userBooks extends StatefulWidget {
  const userBooks({Key? key}) : super(key: key);
  @override
  State<userBooks> createState() => _userBooksState();
}

class _userBooksState extends State<userBooks> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();

  MainPage({Key? key}) : super(key: key);

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
          backgroundColor: const Color(0xffBF9075),
        body: Container(
          padding: EdgeInsets.fromLTRB(10,10,10,0),
          height: 220,
          width: double.maxFinite,
          child: Card(
            //child: Image.network('https://covers.openlibrary.org/b/isbn/0385472579-M.jpg')
            elevation: 5,
            child: Row(
              children: [
                Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Image.network('https://covers.openlibrary.org/b/isbn/0385472579-M.jpg'))
                    ],
                ),
                Column(
                  children: [

                    StreamBuilder<QuerySnapshot>(
                        stream: users,
                        builder: (
                            BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot,
                        ){
                          if(snapshot.hasError){
                            return Text("Something went wrong");
                          }
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Text("Loading");
                          }
                          final data = snapshot.requireData;
                          return ListView.builder(
                            itemCount: data.size,
                            itemBuilder: (context, index){
                              return Text("Hello, Status : ${data.docs[index]['status']}");
                          },
                          );
                        },
                    ),

                    Text(
                      "Book Title",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Text("Book Info"),
                  ],
                )
              ],
            ),
          ),

        ),
      ),
    );
  }
}
