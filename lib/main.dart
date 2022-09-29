import 'package:flutter/material.dart';
import 'pages/signIn.dart';
import 'pages/signUp.dart';
import 'pages/forgotPassword.dart';

void main() => runApp(MaterialApp(
    //home: signIn(),
  initialRoute: 'signIn',
    routes: {
      '/': (context) => signIn(),
      '/signUp' : (context) => signUp(),
      '/forgotPassword' : (context) => forgotPassword(),
    },
  ));




