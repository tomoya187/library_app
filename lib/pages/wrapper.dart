import 'package:flutter/material.dart';
import 'package:library_app/pages/signIn.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Return either Sign in or userBooks widget
    return signIn();
  }
}

