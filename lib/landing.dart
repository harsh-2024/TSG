import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({Key key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 25),
      child: Image.network(
        'https://shop.teamsg.in/wp-content/uploads/2021/07/SG_Logo-512X512-2048x2048.png',
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        fit: BoxFit.contain,
      ),
    );
  }
}
