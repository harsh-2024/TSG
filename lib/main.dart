import 'package:TeamSG/blogs.dart';
import 'package:TeamSG/homePage.dart';
import 'package:TeamSG/landing.dart';
import 'package:TeamSG/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otpScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
          var x = prefs.data;
          if (prefs.hasData) {
            if (x.getString('cookies') != "" &&
                x.getString('cookies') != null &&
                x.getString('email') != "" &&
                x.getString('email') != null) {
              print(x.getString('cookies'));
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primaryColor: Colors.redAccent[700],
                  appBarTheme: AppBarTheme(color: Colors.black),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: Scaffold(body: HomePage()),
              );
            } else {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primaryColor: Colors.redAccent[700],
                  appBarTheme: AppBarTheme(color: Colors.black),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: Scaffold(body: LoginPage()),
              );
            }
          }
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Colors.redAccent[700],
              appBarTheme: AppBarTheme(color: Colors.black),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Scaffold(body: Landing()),
          );
        });
  }
}
