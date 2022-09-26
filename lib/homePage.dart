import 'dart:async';

import 'package:TeamSG/acadamy.dart';
import 'package:TeamSG/blogs.dart';
import 'package:TeamSG/login.dart';
import 'package:TeamSG/scan.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                        print("object");
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
        key: scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                size: 22,
                color: Colors.transparent,
              ),
              onPressed: null),
          backgroundColor: Color(0xFF020000),
          // automaticallyImplyLeading: true,
          title: Text(
            'TeamSG',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFFFDFAFA),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        backgroundColor: Color(0xFFF5F5F5),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Scanner()),
                  //     );
                  //   },
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: [
                  //       ClipPath(
                  //         clipper: MyCustomClipper(),
                  //         child: Container(
                  //           color: Color(0xff0097da),
                  //           width: MediaQuery.of(context).size.width,
                  //           height: MediaQuery.of(context).size.height * 0.09,
                  //           alignment: Alignment(0.8, 0),
                  //           child: Text(
                  //             "Verify Product",
                  //             style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               color: Color(0xFFFDFAFA),
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         bottom: 8,
                  //         left: 0,
                  //         child: ClipPath(
                  //           clipper: MyCustomClipper2(),
                  //           child: Container(
                  //             color: Color(0xff00adef),
                  //             width: MediaQuery.of(context).size.width * 0.6,
                  //             height: MediaQuery.of(context).size.height * 0.045,
                  //           ),
                  //         ),
                  //       ),
                  //       Align(
                  //         alignment: Alignment(-0.75, -1),
                  //         child: Container(
                  //           padding: EdgeInsets.all(3),
                  //           decoration: BoxDecoration(
                  //             color: Color(0xff0097da),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           width: MediaQuery.of(context).size.width * 0.20,
                  //           height: MediaQuery.of(context).size.height * 0.11,
                  //           child: ClipRRect(
                  //             clipBehavior: Clip.antiAlias,
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Image.asset(
                  //               "assets/image-000.jpg",
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => AllBlogs()),
                  //     );
                  //   },
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: [
                  //       ClipPath(
                  //         clipper: MyCustomClipper(),
                  //         child: Container(
                  //           color: Color(0xff373737),
                  //           width: MediaQuery.of(context).size.width,
                  //           height: MediaQuery.of(context).size.height * 0.09,
                  //           alignment: Alignment(0.8, 0),
                  //           child: Text(
                  //             "Blogs",
                  //             style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               color: Color(0xFFFDFAFA),
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         bottom: 8,
                  //         left: 0,
                  //         child: ClipPath(
                  //           clipper: MyCustomClipper2(),
                  //           child: Container(
                  //             color: Color(0xff606062),
                  //             width: MediaQuery.of(context).size.width * 0.6,
                  //             height: MediaQuery.of(context).size.height * 0.045,
                  //           ),
                  //         ),
                  //       ),
                  //       Align(
                  //         alignment: Alignment(-0.75, -1),
                  //         child: Container(
                  //           padding: EdgeInsets.all(3),
                  //           decoration: BoxDecoration(
                  //             color: Color(0xff606062),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           width: MediaQuery.of(context).size.width * 0.20,
                  //           height: MediaQuery.of(context).size.height * 0.11,
                  //           child: ClipRRect(
                  //             clipBehavior: Clip.antiAlias,
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Image.asset(
                  //               "assets/image-001.png",
                  //               fit: BoxFit.fill,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => SearchAcadamy()),
                  //     );
                  //   },
                  //   child: Stack(
                  //     // clipBehavior: Clip.antiAlias,
                  //     alignment: Alignment.center,
                  //     children: [
                  //       ClipPath(
                  //         clipper: MyCustomClipper(),
                  //         child: Container(
                  //           color: Color(0xffa7cd46),
                  //           width: MediaQuery.of(context).size.width,
                  //           height: MediaQuery.of(context).size.height * 0.09,
                  //           alignment: Alignment(0.8, 0),
                  //           child: Text(
                  //             "Cricket Academy",
                  //             style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               color: Color(0xFFFDFAFA),
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         bottom: 8,
                  //         left: 0,
                  //         child: ClipPath(
                  //           clipper: MyCustomClipper2(),
                  //           child: Container(
                  //             color: Color(0xffd1e188),
                  //             width: MediaQuery.of(context).size.width * 0.6,
                  //             height: MediaQuery.of(context).size.height * 0.045,
                  //           ),
                  //         ),
                  //       ),
                  //       Align(
                  //         alignment: Alignment(-0.75, -1),
                  //         child: Container(
                  //           padding: EdgeInsets.all(3),
                  //           decoration: BoxDecoration(
                  //             color: Color(0xffa7cd46),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           width: MediaQuery.of(context).size.width * 0.20,
                  //           height: MediaQuery.of(context).size.height * 0.11,
                  //           child: ClipRRect(
                  //             clipBehavior: Clip.antiAlias,
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Image.asset(
                  //               "assets/image-002.jpg",
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchUrl(url: ("https://youtube.com/c/SGCricketOfficial"));
                  //   },
                  //   child: Stack(
                  //     // clipBehavior: Clip.antiAlias,
                  //     alignment: Alignment.center,
                  //     children: [
                  //       ClipPath(
                  //         clipper: MyCustomClipper(),
                  //         child: Container(
                  //           color: Color(0xffec3539),
                  //           width: MediaQuery.of(context).size.width,
                  //           height: MediaQuery.of(context).size.height * 0.09,
                  //           alignment: Alignment(0.8, 0),
                  //           child: Text(
                  //             "YouTube",
                  //             style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               color: Color(0xFFFDFAFA),
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         bottom: 8,
                  //         left: 0,
                  //         child: ClipPath(
                  //           clipper: MyCustomClipper2(),
                  //           child: Container(
                  //             color: Color(0xfff16f57),
                  //             width: MediaQuery.of(context).size.width * 0.6,
                  //             height: MediaQuery.of(context).size.height * 0.045,
                  //           ),
                  //         ),
                  //       ),
                  //       Align(
                  //         alignment: Alignment(-0.75, -1),
                  //         child: Container(
                  //           padding: EdgeInsets.all(3),
                  //           decoration: BoxDecoration(
                  //             color: Color(0xffec3539),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           width: MediaQuery.of(context).size.width * 0.20,
                  //           height: MediaQuery.of(context).size.height * 0.11,
                  //           child: ClipRRect(
                  //             clipBehavior: Clip.antiAlias,
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Image.asset(
                  //               "assets/image-004.jpg",
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchUrl(url: ("https://www.facebook.com/sgcricket"));
                  //   },
                  //   child: Stack(
                  //     // clipBehavior: Clip.antiAlias,
                  //     alignment: Alignment.center,
                  //     children: [
                  //       ClipPath(
                  //         clipper: MyCustomClipper(),
                  //         child: Container(
                  //           color: Color(0xff465993),
                  //           width: MediaQuery.of(context).size.width,
                  //           height: MediaQuery.of(context).size.height * 0.09,
                  //           alignment: Alignment(0.8, 0),
                  //           child: Text(
                  //             "Facebook",
                  //             style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               color: Color(0xFFFDFAFA),
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         bottom: 8,
                  //         left: 0,
                  //         child: ClipPath(
                  //           clipper: MyCustomClipper2(),
                  //           child: Container(
                  //             color: Color(0xff8285b2),
                  //             width: MediaQuery.of(context).size.width * 0.6,
                  //             height: MediaQuery.of(context).size.height * 0.045,
                  //           ),
                  //         ),
                  //       ),
                  //       Align(
                  //         alignment: Alignment(-0.75, -1),
                  //         child: Container(
                  //           padding: EdgeInsets.all(3),
                  //           decoration: BoxDecoration(
                  //             color: Color(0xff465993),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           width: MediaQuery.of(context).size.width * 0.20,
                  //           height: MediaQuery.of(context).size.height * 0.11,
                  //           child: ClipRRect(
                  //             clipBehavior: Clip.antiAlias,
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Image.asset(
                  //               "assets/image-005.jpg",
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchUrl(
                  //         url:
                  //             ("https://instagram.com/sgcricketofficial?utm_medium=copy_link"));
                  //   },
                  //   child: Stack(
                  //     // clipBehavior: Clip.antiAlias,
                  //     alignment: Alignment.center,
                  //     children: [
                  //       ClipPath(
                  //         clipper: MyCustomClipper(),
                  //         child: Container(
                  //           color: Color(0xff9d3b92),
                  //           width: MediaQuery.of(context).size.width,
                  //           height: MediaQuery.of(context).size.height * 0.09,
                  //           alignment: Alignment(0.8, 0),
                  //           child: Text(
                  //             "Instagram",
                  //             style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               color: Color(0xFFFDFAFA),
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         bottom: 8,
                  //         left: 0,
                  //         child: ClipPath(
                  //           clipper: MyCustomClipper2(),
                  //           child: Container(
                  //             color: Color(0xffea2a8d),
                  //             width: MediaQuery.of(context).size.width * 0.6,
                  //             height: MediaQuery.of(context).size.height * 0.045,
                  //           ),
                  //         ),
                  //       ),
                  //       Align(
                  //         alignment: Alignment(-0.75, -1),
                  //         child: Container(
                  //           padding: EdgeInsets.all(3),
                  //           decoration: BoxDecoration(
                  //             color: Color(0xff973d8f),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           width: MediaQuery.of(context).size.width * 0.20,
                  //           height: MediaQuery.of(context).size.height * 0.11,
                  //           child: ClipRRect(
                  //             clipBehavior: Clip.antiAlias,
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Image.asset(
                  //               "assets/image-006.jpg",
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // GestureDetector(
                  //   child: Stack(
                  //     // clipBehavior: Clip.antiAlias,
                  //     alignment: Alignment.center,
                  //     children: [
                  //       ClipPath(
                  //         clipper: MyCustomClipper(),
                  //         child: Container(
                  //           color: Color(0xff00a54f),
                  //           width: MediaQuery.of(context).size.width,
                  //           height: MediaQuery.of(context).size.height * 0.09,
                  //           alignment: Alignment(0.8, 0),
                  //           child: Text(
                  //             "Live Score",
                  //             style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               color: Color(0xFFFDFAFA),
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         bottom: 8,
                  //         left: 0,
                  //         child: ClipPath(
                  //           clipper: MyCustomClipper2(),
                  //           child: Container(
                  //             color: Color(0xff4fbc82),
                  //             width: MediaQuery.of(context).size.width * 0.6,
                  //             height: MediaQuery.of(context).size.height * 0.045,
                  //           ),
                  //         ),
                  //       ),
                  //       Align(
                  //         alignment: Alignment(-0.75, -1),
                  //         child: Container(
                  //           padding: EdgeInsets.all(3),
                  //           decoration: BoxDecoration(
                  //             color: Color(0xff00a54f),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           width: MediaQuery.of(context).size.width * 0.20,
                  //           height: MediaQuery.of(context).size.height * 0.11,
                  //           child: ClipRRect(
                  //             clipBehavior: Clip.antiAlias,
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Image.asset(
                  //               "assets/image-017.jpg",
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  SizedBox(
                    height: 15,
                  ),
                  // GestureDetector(
                  //   child: Stack(
                  //     //     // clipBehavior: Clip.antiAlias,
                  //     alignment: Alignment.center,
                  //     children: [
                  //       ClipPath(
                  //         clipper: MyCustomClipper(),
                  //         child: Container(
                  //           color: Color(0xfff58220),
                  //           width: MediaQuery.of(context).size.width,
                  //           height: MediaQuery.of(context).size.height * 0.09,
                  //           alignment: Alignment(0.8, 0),
                  //           child: Text(
                  //             "News",
                  //             style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               color: Color(0xFFFDFAFA),
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         bottom: 8,
                  //         left: 0,
                  //         child: ClipPath(
                  //           clipper: MyCustomClipper2(),
                  //           child: Container(
                  //             color: Color(0xfff9a64a),
                  //             width: MediaQuery.of(context).size.width * 0.6,
                  //             height: MediaQuery.of(context).size.height * 0.045,
                  //           ),
                  //         ),
                  //       ),
                  //       Align(
                  //         alignment: Alignment(-0.75, -1),
                  //         child: Container(
                  //           padding: EdgeInsets.all(3),
                  //           decoration: BoxDecoration(
                  //             color: Color(0xfff58220),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           width: MediaQuery.of(context).size.width * 0.20,
                  //           height: MediaQuery.of(context).size.height * 0.11,
                  //           child: ClipRRect(
                  //             clipBehavior: Clip.antiAlias,
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Image.asset(
                  //               "assets/image-019.jpg",
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scanner()),
                      );
                    },
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.redAccent[700],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'Verify Product',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFFDFAFA),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllBlogs()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.redAccent[700],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'SG Brand Ambassadors',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFFDFAFA),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchAcadamy()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.redAccent[700],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'Cricket Academy',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFFDFAFA),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  GestureDetector(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => LoginPage(),
                        ),
                        (route) =>
                            false, //if you want to disable back feature set to false
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.redAccent[700],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFFDFAFA),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchUrl(url: ("https://youtube.com/c/SGCricketOfficial"));
                  //     //     // Navigator.push(
                  //     //     //   context,
                  //     //     //   MaterialPageRoute(
                  //     //     //       builder: (context) => WebViewBlogs(
                  //     //     //           url: "https://youtube.com/c/SGCricketOfficial")),
                  //     //     // );
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: MediaQuery.of(context).size.height * 0.08,
                  //     decoration: BoxDecoration(
                  //       color: Colors.redAccent[700],
                  //       shape: BoxShape.rectangle,
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     alignment: AlignmentDirectional(0, 0),
                  //     child: Text(
                  //       'Live Score',
                  //       style: TextStyle(
                  //         fontFamily: 'Poppins',
                  //         color: Color(0xFFFDFAFA),
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchUrl(url: ("https://www.facebook.com/sgcricket"));
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: MediaQuery.of(context).size.height * 0.08,
                  //     decoration: BoxDecoration(
                  //       color: Colors.redAccent[700],
                  //       shape: BoxShape.rectangle,
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     alignment: AlignmentDirectional(0, 0),
                  //     child: Text(
                  //       'News',
                  //       style: TextStyle(
                  //         fontFamily: 'Poppins',
                  //         color: Color(0xFFFDFAFA),
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchUrl(
                  //         url:
                  //             ("https://instagram.com/sgcricketofficial?utm_medium=copy_link"));
                  //     // // Navigator.push(
                  //     //     //   context,
                  //     //     //   MaterialPageRoute(
                  //     //     //       builder: (context) => WebViewBlogs(
                  //     //     //           url:
                  //     //     //               "https://instagram.com/sgcricketofficial?utm_medium=copy_link")),
                  //     //     // );
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: MediaQuery.of(context).size.height * 0.08,
                  //     decoration: BoxDecoration(
                  //       color: Colors.redAccent[700],
                  //       shape: BoxShape.rectangle,
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     alignment: AlignmentDirectional(0, 0),
                  //     child: Text(
                  //       'Instagram',
                  //       style: TextStyle(
                  //         fontFamily: 'Poppins',
                  //         color: Color(0xFFFDFAFA),
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                            (FontAwesomeIcons.youtube),
                            size: 34,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            launchUrl(
                                url:
                                    ("https://youtube.com/c/SGCricketOfficial"));
                          }),
                      IconButton(
                          icon: Icon(
                            (FontAwesomeIcons.facebook),
                            size: 34,
                            color: Color(0xFF4267B2),
                          ),
                          onPressed: () {
                            launchUrl(
                                url: ("https://www.facebook.com/sgcricket"));
                          }),
                      // IconButton(
                      //     icon: Icon(
                      //       (FontAwesomeIcons.twitter),
                      //       size: 34,
                      //       color: Color(0xFF4267B2),
                      //     ),
                      //     onPressed: () {
                      //       launchUrl(
                      //           url: ("https://www.facebook.com/sgcricket"));
                      //     }),
                      IconButton(
                          icon: Icon(
                            (FontAwesomeIcons.instagram),
                            size: 34,
                            color: Color(0xFF8a3ab9),
                          ),
                          onPressed: () {
                            launchUrl(
                                url:
                                    ("https://instagram.com/sgcricketofficial?utm_medium=copy_link"));
                          }),
                    ],
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   height: MediaQuery.of(context).size.height * 0.25,
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void launchUrl({
    @required String url,
  }) async {
    try {
      print(await canLaunch(url));

      // if (await canLaunch(url)) {
      var err = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      //   print(err);
      // } else {
      //   // scaffoldKey.currentState
      //   //     .showSnackBar(new SnackBar(content: new Text("")));
      //   throw 'Could not launch ${url}';
      // }
    } catch (e) {
      scaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text(e.toString())));
    }
  }
}
