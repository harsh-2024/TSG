import 'package:TeamSG/forgetPasswordScreen.dart';
import 'package:TeamSG/homePage.dart';
import 'package:TeamSG/otpScreen.dart';
import 'package:TeamSG/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert' as convert;
import "dart:core";

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:otp_screen/otp_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController textController;
  TextEditingController password;

  bool isLoading = false;
  bool _passwordVisible = true;

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

  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Toast fToast;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to exit an App'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    )
                  ],
                );
              },
            ) ??
            false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // resizeToAvoidBottomPadding: false,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(50),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: AssetImage(
                          "assets/image-009.jpg"), // <-- BACKGROUND IMAGE
                      fit: BoxFit.contain,
                      // ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1, 0.2),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Row(
                      //   mainAxisSize: MainAxisSize.max,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
                      //       child: Text(
                      //         'TeamSG',
                      //         style: TextStyle(
                      //           fontFamily: 'Poppins',
                      //           color: Color(0xFF1A1919),
                      //           fontSize: 24,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 25),
                        child: Image.network(
                          'https://shop.teamsg.in/wp-content/uploads/2021/07/SG_Logo-512X512-2048x2048.png',
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.18,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          child: TextFormField(
                            controller: textController,
                            // obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Enter email',
                              // labelStyle: .bodyText1,
                              hintText: 'Enter email',
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
                              prefixIcon: Icon(Icons.email),
                            ),
                            textAlign: TextAlign.start,
                            // obscuringCharacter: '*',
                            //This will obscure text dynamically

                            // suffixIcon: IconButton(
                            //   icon: Icon(
                            //     // Based on passwordVisible state choose the icon
                            //     _passwordVisible
                            //         ? Icons.visibility
                            //         : Icons.visibility_off,
                            //     color: Theme.of(context).primaryColorDark,
                            //   ),
                            //   onPressed: () {
                            //     // Update the state i.e. toogle the state of passwordVisible variable
                            //     setState(() {
                            //       _passwordVisible = !_passwordVisible;
                            //     });
                            //   },
                            // ),

                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()));
                        },
                        child: Align(
                          alignment: AlignmentDirectional(0.8, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            child: Text(
                              'forget password?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.red[700],
                                fontFamily: 'Poppins',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 4, 10, 10),
                        child: FlatButton(
                          minWidth: double.infinity,
                          height: 48,
                          color: Colors.red[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: new Text(
                            isLoading == true ? "logging...." : 'Continue',
                            style: TextStyle(color: Color(0xFFFDFAFA)),
                          ),
                          onPressed: () async {
                            if (textController.text.trim() == "") {
                              scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content:
                                          new Text("please fill email id")));

                              return;
                            }
                            if (password.text.trim() == "") {
                              scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content:
                                          new Text("please fill password")));

                              return;
                            }
                            await _playAnimation();
                            var isLogin = await login();

                            if (isLogin) {
                              _stopAnimation();
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => HomePage(),
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
                              scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content: new Text(
                                          "invalid email or password")));
                            }
                            _stopAnimation();
                          },
                        ),
                      ),
                      Center(
                        child: new RichText(
                          text: new TextSpan(
                            children: [
                              new TextSpan(
                                text: "Don't have an account? ",
                                style: new TextStyle(color: Colors.black),
                              ),
                              new TextSpan(
                                text: 'register here',
                                style: new TextStyle(color: Colors.red[700]),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   // height: 50,
                      //   height: 50,
                      // ),
                      Align(
                        alignment: Alignment(0, 0.95),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            'By clicking continue,  you agree with our Privacy Policy',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String isSecure;
  Future<bool> login() async {
    String mail = textController.text.trim();
    String pass = password.text.trim();

    String data = '''{"email":"$mail","password":"$pass"}''';

    print(data);
    try {
      final http.Response response = await http.post(
          "https://signin-signup-user.herokuapp.com/login",
          headers: {'Content-Type': "application/json"},
          body: data);
      var body = convert.json.decode(response.body);
      print(body);

      if (response.statusCode == 200) {
        var cookies = response.headers['set-cookie'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('cookies', cookies);
        prefs.setString('email', mail);

        print(cookies);
        // return await getUserInfo(cookie);
        return true;
      } else {
        print(response.statusCode);
        // throw Exception("The username or password is incorrect.");
        return false;
      }
    } catch (err) {
      rethrow;
    }
  }
}
