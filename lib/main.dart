import 'package:flutter/material.dart';
import 'package:library_app/pages/authenticate.dart';
import 'pages/signIn.dart';
import 'pages/signUp.dart';
import 'pages/userBooks.dart';
import 'pages/forgotPassword.dart';

void main() => runApp(MaterialApp(
    //home: signIn(),
  initialRoute: 'authenticate',
    routes: {
      '/': (context) => Authenticate(),
      '/signIn': (context) => signIn(),
      '/signUp' : (context) => signUp(),
      '/forgotPassword' : (context) => forgotPassword(),
      '/userBooks' : (context) => userBooks(),
    },
  ));




