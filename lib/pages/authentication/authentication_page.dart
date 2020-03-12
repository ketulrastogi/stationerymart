import 'package:flutter/material.dart';
import 'package:stationerymart/pages/authentication/signin_page/signin_page.dart';
import 'package:stationerymart/pages/authentication/signup_page/signup_page.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  bool _signIn = true;

  void toggelSignIn(){
    setState(() {
     _signIn = !_signIn; 
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: (_signIn) ? SignInPage(toggelSignIn: toggelSignIn,) : SignUpPage(toggelSignIn: toggelSignIn,),
      ),
    );
  }
}