import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/authentication/phone_otp_page/phone_otp_page.dart';
import 'package:stationerymart/pages/authentication/signin_page/signin_page.dart';
import 'package:stationerymart/pages/authentication/signup_page/signup_page.dart';
import 'package:stationerymart/pages/home_page/home_page.dart';
import 'package:stationerymart/services/auth_service.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _signIn = true;

  void toggelSignIn() {
    setState(() {
      _signIn = !_signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);

    return WillPopScope(
      onWillPop: () {
        exit(0);
        return;
      },
      child: FutureBuilder<Map<String, dynamic>>(
          future: authService.getUserDetails(),
          builder: (context, snapshot) {
            print(snapshot.hasData);
            print(snapshot.data);
            print('Snapshot.data : ${snapshot.data}');
            if (snapshot.hasData) {
              if (snapshot.data != null &&
                  snapshot.data.containsKey('Data') &&
                  snapshot.data['Data'] != null) {
                if (snapshot.data['Data'][0].containsKey('Id')) {
                  return HomePage();
                } else {
                  return SafeArea(
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: (_signIn)
                          ? PhoneOtpPages(
                              toggelSignIn: toggelSignIn,
                            )
                          : SignUpPage(
                              toggelSignIn: toggelSignIn,
                            ),
                    ),
                  );
                }
              } else {
                return SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    body: (_signIn)
                        ? PhoneOtpPages(
                            toggelSignIn: toggelSignIn,
                          )
                        : SignUpPage(
                            toggelSignIn: toggelSignIn,
                          ),
                  ),
                );
              }
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
