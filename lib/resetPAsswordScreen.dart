import 'package:TeamSG/login.dart';
import 'package:TeamSG/otpScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import "dart:core";

import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
  String otp;
  ResetPasswordScreen({
    Key key,
    this.otp,
  }) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isLoading = false;

  String message = "";
  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
        // cout.value++;
      });
      return;
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }

  bool _passwordVisible = true;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPAsswordController = TextEditingController();

  bool _checkPasswordVisible = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                'Create New Password?',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  width: double.infinity,
                  height: 48,
                  child: TextFormField(
                    obscureText: _passwordVisible,

                    controller: password,
                    // obscureText: false,
                    decoration: InputDecoration(
                      suffix: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      labelText: 'Enter password',
                      // labelStyle: .bodyText1,
                      hintText: 'Enter password',
                      // hintStyle: .bodyText1,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0D0D0D),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0D0D0D),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  width: double.infinity,
                  height: 48,
                  child: TextFormField(
                    obscureText: _checkPasswordVisible,

                    controller: confirmPAsswordController,
                    // obscureText: false,
                    decoration: InputDecoration(
                      suffix: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _checkPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _checkPasswordVisible = !_checkPasswordVisible;
                          });
                        },
                      ),
                      labelText: 'Confirm Password',
                      // labelStyle: .bodyText1,
                      hintText: 'Confirm Password',
                      // hintStyle: .bodyText1,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0D0D0D),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0D0D0D),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 4, 10, 10),
                child: TextButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, 48)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[700]),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  child: new Text(
                    isLoading == true ? "processing..." : 'Reset Password',
                    style: TextStyle(color: Color(0xFFFDFAFA)),
                  ),
                  onPressed: () async {
                    if (password.text.trim() == "") {
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          content: new Text("please fill enter password")));

                      return;
                    }
                    if (confirmPAsswordController.text.trim() == "") {
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          content: new Text("please fill confirm password")));

                      return;
                    }

                    print((password.text.trim() ==
                        confirmPAsswordController.text.trim()));

                    if (!(password.text.trim() ==
                        confirmPAsswordController.text.trim())) {
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          content: new Text(
                              "Password and confirm password should match")));

                      return;
                    }

                    await _playAnimation();
                    var issendForgetPasswordOTP = await resetPAssword();

                    if (issendForgetPasswordOTP) {
                      _stopAnimation();
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => LoginPage(),
                        ),
                        (route) =>
                            true, //if you want to disable back feature set to false
                      );

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomePage()));
                    } else {
                      _stopAnimation();
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          content: new Text(message.toLowerCase())));
                    }
                    _stopAnimation();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> resetPAssword() async {
    String pass = password.text.trim();
    String cPass = confirmPAsswordController.text.trim();
    print(widget.otp);
    String data =
        '''{"otp":${widget.otp},"newpassword":"$pass","cnewpassword":"$cPass"}''';

    print(data);
    try {
      final http.Response response = await http.post(
          Uri.parse("https://signin-signup-user.herokuapp.com/resetpassword"),
          headers: {'Content-Type': "application/json"},
          body: data);
      var body = convert.json.decode(response.body);
      print(body);

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        // var cookies = response.headers['set-cookie'];
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('cookies', cookies);

        // print(cookies);
        // return await getUserInfo(cookie);
        return true;
      } else {
        setState(() {
          message = body['message'];
        });
        print(response.statusCode);
        // throw Exception("The username or password is incorrect.");
        return false;
      }
    } catch (err) {
      rethrow;
    }
  }
}
