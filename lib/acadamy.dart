import 'package:TeamSG/acadamyModel.dart';
import 'package:TeamSG/youtubePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchAcadamy extends StatefulWidget {
  const SearchAcadamy({Key key}) : super(key: key);

  @override
  _SearchAcadamyState createState() => _SearchAcadamyState();
}

class _SearchAcadamyState extends State<SearchAcadamy> {
  String dropDownValue1;
  String dropDownValue2;
  TextEditingController searchFieldController;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<AcadamyModel> blogs1 = [];
  List<AcadamyModel> data = [];

  // List<Map<String, dynamic>> data = [];

  List<String> city = [];
  List<String> state = [];

  // List<Map<String,dynamic>> data =[];

  @override
  void initState() {
    super.initState();
    searchFieldController = TextEditingController();
    setState(() {
      isLoading = true;
      getacad();
    });
  }

  getacad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cookie1 = prefs.getString("cookies");
    var url = Uri.parse('https://signin-signup-user.herokuapp.com/alldata');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url,
        headers: {'Cookie': cookie1, 'Content-Type': "application/json"});
    if (response.statusCode == 200) {
      print("ajkkjjskf---" + response.body.toString());
      print(response.body);
      // var jsonResponse =
      //     convert.jsonDecode(response.body) as Map<String, dynamic>;
      // var itemCount = jsonResponse['totalItems'];

      // data = json.decode(utf8.decode(response.bodyBytes));
      blogs1 = List<AcadamyModel>.from(json
          .decode(utf8.decode(response.bodyBytes))
          .map((x) => AcadamyModel.fromJson(x)));
      var i = 0;
      String firstState = "";
      blogs1.forEach((element) {
        print(element.nameofacademy);

        print("object $i");
        if (i == 0) {
          firstState = element.state;
          i++;
        }
        if (!state.contains(element.state)) {
          state.add(element.state);
        }
        if (element.state == firstState) {
          if (!city.contains(element.city)) {
            city.add(element.city);
          }
        }
        data.add(element);
      });
      setState(() {
        isLoading = false;
      });
      // print('Number of books about http: $itemCount.');
    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Color(0xFF090F13),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: AlignmentDirectional(-0.5, 0),
          child: Text(
            'Cricket Academy',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFFFDFAFA),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body:
          // SingleChildScrollView(
          //   physics: NeverScrollableScrollPhysics(),
          //   child:
          ListView(
        // mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Material(
                color: Colors.transparent,
                // elevation: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                    child: TextFormField(
                      controller: searchFieldController,
                      onFieldSubmitted: (value) {
                        print("dropDownValue1 + dropDownValue2");

                        print(dropDownValue1);
                        if ((dropDownValue1 != null &&
                                dropDownValue2 != null) ||
                            (dropDownValue1 == "" && dropDownValue2 == "")) {
                          // data.clear();
                          // da
                          print("s");
                          data.clear();
                          // print("else");
                          blogs1.forEach((element) {
                            if (element.nameofacademy.toLowerCase().contains(
                                searchFieldController.text.toLowerCase())) {
                              data.add(element);
                            }
                          });
                        } else {
                          List<AcadamyModel> list = [];
                          list = data;
                          data.clear();
                          print("else");
                          list.forEach((element) {
                            if (element.nameofacademy.toLowerCase().contains(
                                searchFieldController.text.toLowerCase())) {
                              data.add(element);
                            }
                          });
                        }

                        // }
                        setState(() {});
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF95A1AC),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Search by name, location etc...',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF95A1AC),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF262D34),
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF262D34),
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Color(0xFF95A1AC),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF95A1AC),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton(
                  hint: Text('Select State'),
                  value: dropDownValue1,
                  items: state.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    isLoading = true;
                    setState(() {});
                    dropDownValue1 = val;
                    data.clear();
                    city.clear();
                    int i = 0;
                    // String firstState = "";
                    blogs1.forEach((element) {
                      // if (i == 0) {
                      //   firstState = element.state;
                      //   i++;
                      // }
                      if (dropDownValue1.toLowerCase() ==
                          element.state.toLowerCase()) {
                        if (!city.contains(element.city)) {
                          city.add(element.city);
                        }
                      }
                      if (city.length > 0) {
                        dropDownValue2 = city[0];
                        if (element.state
                                .toLowerCase()
                                .contains(dropDownValue1.toLowerCase()) &&
                            element.city
                                .toLowerCase()
                                .contains(city[0].toLowerCase())) {
                          // if (!city.contains(element.city)) {
                          data.add(element);
                          // }
                        }
                      }
                    });
                    isLoading = false;
                    setState(() {});
                  },
                  elevation: 2,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
                DropdownButton(
                  hint: Text('Select City'),
                  value: dropDownValue2,
                  items: city.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    isLoading = true;
                    setState(() {});
                    // => setState(() => dropDownValue2 = val)
                    dropDownValue2 = val;
                    data.clear();
                    // blogs1.forEach((element) {
                    blogs1.forEach((element) {
                      if (city.length > 0) {
                        if (dropDownValue1.toLowerCase() ==
                                (element.state.toLowerCase()) &&
                            element.city
                                .toLowerCase()
                                .contains(dropDownValue2.toLowerCase())) {
                          // if (!city.contains(element.city)) {
                          data.add(element);
                        }
                      }
                    });
                    isLoading = false;
                    setState(() {});
                  },
                  elevation: 2,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  physics: ClampingScrollPhysics(),
                  // physics: AllowScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (isLoading) {
                      return Container(
                          height: 500,
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      if (data.length == 0) {
                        return Container(
                            alignment: Alignment.bottomCenter,
                            height: 500,
                            child: Text("No Data"));
                      } else {
                        return Card(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  color: Color(0xFF090F13),
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: Image.network(
                                      'https://shop.teamsg.in/wp-content/uploads/2021/07/ball-large.png',
                                    ).image,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    color: Color(0x65090F13),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 16, 16, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data[index]
                                                    .nameofacademy
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            // Icon(
                                            //   Icons.chevron_right_rounded,
                                            //   color: Colors.white,
                                            //   size: 24,
                                            // )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 4, 16, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data[index].headcoach +
                                                    ' | ' +
                                                    data[index]
                                                        .city
                                                        .toString() +
                                                    ' | ' +
                                                    data[index]
                                                        .facilities
                                                        .toString()
                                                        .replaceAll("null", ""),
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF39D2C0),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 4, 16, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data[index].address.toString(),
                                                maxLines: 3,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      if (data[index].phonenumber != null)
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 4, 16, 16),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all(CircleBorder(
                                                              side: BorderSide
                                                                  .none)),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .redAccent)),
                                                  // minWidth: 120,
                                                  // height: 40,

                                                  onPressed: () async {
                                                    await launchUrl(
                                                        lauch: data[index]
                                                            .phonenumber,
                                                        type: "tel");

                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             YoutubePage()));
                                                  },
                                                  // shape:,

                                                  child:
                                                      // Icon(
                                                      //   Icons.phone,
                                                      //   color: Colors.white,
                                                      // )
                                                      new Text(
                                                    data[index].phonenumber,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 25,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 4),
                                                        child: Text(
                                                          data[index]
                                                              .address
                                                              .toString(),
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   'Thursday June 22',
                                                      //   textAlign: TextAlign.end,
                                                      //   style: TextStyle(
                                                      //     fontFamily: 'Poppins',
                                                      //     color:
                                                      //         Color(0xB4FFFFFF),
                                                      //     fontSize: 14,
                                                      //     fontWeight:
                                                      //         FontWeight.normal,
                                                      //   ),
                                                      // )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  },
                )
        ],
      ),
    );
  }

  void launchUrl({
    @required String lauch,
    @required String type,
  }) async {
    try {
      if (type == "tel") {
        var err = await launch(
          "tel:" + lauch,
          forceSafariVC: false,
          universalLinksOnly: true,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(new SnackBar(content: new Text(e.toString())));
    }
  }
}
