import 'dart:convert' as convert;

import 'package:TeamSG/login.dart';
import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';
import 'package:http/http.dart' as http;

class LoginOtp extends StatefulWidget {
  const LoginOtp({Key key}) : super(key: key);

  @override
  _LoginOtpState createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String onMessage = "";
  Future<String> validateOtp(String otp) async {
    // await Future.delayed(Duration(milliseconds: 2000));
    // if (otp == "123456") {
    //   return null;
    // } else {
    //   return "The entered Otp is wrong";
    // }

    // int id = _valu;
    String data = '''{
         "otp":$otp
        }''';
    try {
      final http.Response response = await http.post(
        Uri.parse("https://signin-signup-user.herokuapp.com/user-verify"),
        headers: {'Content-Type': "application/json"},
        body: data,
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        var body = convert.jsonDecode(response.body);
        onMessage = body['message'].toString();
        setState(() {});
        return null;
      } else {
        var body = convert.jsonDecode(response.body);

        return body['error'].toString();
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> moveToNextScreen(context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(onMessage)));
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => LoginPage(),
      ),
      (route) => false, //if you want to disable back feature set to false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: SafeArea(
        // maintainBottomViewPadding: ,
        // debugShowCheckedModeBanner: false,
        child: OtpScreen.withGradientBackground(
          topColor: Colors.white,
          bottomColor: Colors.white,
          otpLength: 6,
          validateOtp: validateOtp,

          routeCallback: moveToNextScreen,
          themeColor: Colors.black,
          titleColor: Colors.black,
          title: "Email Verification",
          // subTitle: "Enter the code sent to \n +919876543210",
          // icon: Image.asset(
          //   'images/phone_logo.png',
          //   fit: BoxFit.fill,
          // ),
        ),
      ),
    );
  }
}
