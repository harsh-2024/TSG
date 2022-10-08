import 'package:TeamSG/fpOtpScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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

  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  static String id = 'forgot-password';
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // actions: [

        // ],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
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
                'Forget Password?',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: textController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  errorStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                    isLoading == true ? "sending otp..." : 'Send Otp',
                    style: TextStyle(color: Color(0xFFFDFAFA)),
                  ),
                  onPressed: () async {
                    if (textController.text.trim() == "") {
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          content: new Text("please fill email id")));

                      return;
                    }

                    await _playAnimation();
                    var issendForgetPasswordOTP = await sendForgetPasswordOTP();

                    if (issendForgetPasswordOTP) {
                      _stopAnimation();
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => FPOTP(),
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

  Future<bool> sendForgetPasswordOTP() async {
    String mail = textController.text.trim();

    String data = '''{"email":"$mail"}''';

    print(data);
    try {
      final http.Response response = await http.post(
          Uri.parse("https://signin-signup-user.herokuapp.com/forgetpassword"),
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

// class ForgotPassword extends StatelessWidget {

// }
