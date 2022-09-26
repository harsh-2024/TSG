import 'dart:convert';

import 'package:TeamSG/acadamyModel.dart';
import 'package:TeamSG/citiesModel.dart' as cities;
import 'package:TeamSG/otpScreen.dart';
import 'package:TeamSG/statesModel.dart' as states;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:otp_screen/otp_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController;
  // TextEditingController countrySearch;
  //   TextEditingController stateSearch;
  // TextEditingController citySearch;

  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController citySearchController;
  TextEditingController stateSearchController;
  TextEditingController countrySearchController;
  TextEditingController passwordController;
  // bool _obscuredText = true;
  bool isLoading = false;
  bool _passwordVisible = true;

  String onSignUpMessage = "";

  Result _value;
  Country countryList;
  bool countryLoading = true;

  states.Result _states;
  states.States statesList;
  bool stateLoading = true;

  cities.Result _cities;
  cities.Cities citiesList;
  bool citiLoading = true;

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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    print("object length");
    // print(countryList.result.length);
    // countryList.result = [];
    getcountries();
    super.initState();
    // countrySearch = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    citySearchController = TextEditingController();
    stateSearchController = TextEditingController();
    countrySearchController = TextEditingController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Builder(
          builder: (context) => GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: screenSize.width * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 1.0),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          child: TextFormField(
                            controller: nameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Enter your name',
                              // labelStyle: .bodyText1,
                              hintText: 'Enter your name',
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
                              prefixIcon: Icon(Icons.account_circle),
                            ),
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          child: TextFormField(
                            controller: emailController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Email id',
                              // labelStyle: .bodyText1,
                              hintText: 'Email id',
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
                              prefixIcon: Icon(Icons.mail),
                            ),
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          child: TextFormField(
                            controller: phoneController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              // labelStyle: .bodyText1,
                              hintText: 'Phone number',
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
                              prefixIcon: Icon(Icons.phone),
                            ),
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: _passwordVisible,
                            decoration: InputDecoration(
                              labelText: 'Enter password',
                              // labelStyle: .bodyText1,
                              hintText: 'Enter password',
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
                      // if (countryList != null)
                      //   if (countryList.result != null)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: DropdownSearch<Result>(
                          mode: Mode.BOTTOM_SHEET,
                          // enabled: true,
                          showSearchBox: true,
                          searchBoxController: countrySearchController,
                          // label: _value.name,

                          // showClearButton: true,

                          searchBoxDecoration: InputDecoration(
                            contentPadding: EdgeInsets.all(1),

                            labelText: 'search country',
                            // labelStyle: .bodyText1,
                            hintText: 'search country',

                            suffix: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                Icons.clear,
                                color: Colors.black,
                                size: 10,
                              ),
                              onPressed: () {
                                countrySearchController.clear();
                              },
                            ),
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
                            prefixIcon: Icon(Icons.search),
                          ),

                          onChanged: (newValue) {
                            _value = newValue;
                            getState();
                            setState(() {});
                          },

                          selectedItem: _value,
                          isFilteredOnline: true,
                          enabled: countryLoading,
                          filterFn: (item, filter) {
                            if (item.name
                                .toLowerCase()
                                .contains(filter.toLowerCase())) {
                              return true;
                            } else {
                              return false;
                            }
                          },
                          itemAsString: (item) {
                            return item.name;
                          },
                          dropdownButtonBuilder: (context) {
                            if (countryList == null) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0.5, vertical: 0.5),
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 32,
                                ),
                              );
                            }
                          },
                          items:
                              countryList == null ? null : countryList.result,
                          dropdownSearchDecoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF0D0D0D),
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.all(1),

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
                            prefixIcon: Icon(Icons.location_city),
                          ),

                          popupItemBuilder: (context, item, isSelected) {
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: Container(
                                  width: double.infinity,
                                  height: 20,
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )),
                            );
                          },

                          label: ("Select Country"),
                          hint: ("Select Country"),
                          // disabledHint:Text("Disabled"),
                          // elevation: 8,
                          // style:
                          //     TextStyle(color: Colors.black, fontSize: 16),
                          // icon: Icon(Icons.arrow_drop_down_circle),
                          // iconDisabledColor: Colors.grey,
                          // iconEnabledColor: Colors.black,
                          // isExpanded: true,
                        ),
                      ),

                      if (_value != null)
                        //   if (statesList.result != null)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                          child: DropdownSearch<states.Result>(
                            mode: Mode.BOTTOM_SHEET,
                            enabled: stateLoading,

                            dropdownButtonBuilder: (context) {
                              if (!stateLoading) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.5, vertical: 0.5),
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 32,
                                  ),
                                );
                              }
                            },
                            // enabled: true,
                            showSearchBox: true,
                            searchBoxController: stateSearchController,
                            searchBoxDecoration: InputDecoration(
                              labelText: 'search state',
                              // labelStyle: .bodyText1,
                              hintText: 'search state',
                              contentPadding: EdgeInsets.all(1),
                              suffix: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  Icons.clear,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                onPressed: () {
                                  stateSearchController.clear();
                                },
                              ),

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
                              prefixIcon: Icon(Icons.search),
                            ),
                            dropdownSearchDecoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF0D0D0D),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: EdgeInsets.all(1),

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
                              prefixIcon: Icon(Icons.location_city),
                            ),

                            onChanged: (newValue) {
                              _states = newValue;
                              getCities();
                              setState(() {});
                            },

                            selectedItem: _states,
                            filterFn: (item, filter) {
                              if (item.name
                                  .toLowerCase()
                                  .contains(filter.toLowerCase())) {
                                return true;
                              } else {
                                return false;
                              }
                            },
                            itemAsString: (item) {
                              return item.name;
                            },
                            items:
                                statesList == null ? null : statesList.result,
                            popupItemBuilder: (context, item, isSelected) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: Container(
                                    width: double.infinity,
                                    height: 20,
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    )),
                              );
                            },
                            label: ("Select State"),
                            hint: ("Select State"),
                          ),
                        ),

                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      //   child: DropdownButton<states.Result>(
                      //     value: _states,
                      //     items:
                      //         statesList.result.map((states.Result item) {
                      //       return DropdownMenuItem<states.Result>(
                      //         child: Text(item.name.toString()),
                      //         value: item,
                      //       );
                      //     }).toList(),
                      //     onChanged: (i) {
                      //       setState(() {
                      //         _states = i;
                      //         getCities();
                      //       });
                      //     },
                      //     hint: Text("Select State"),
                      //     // disabledHint:Text("Disabled"),
                      //     elevation: 8,
                      //     style:
                      //         TextStyle(color: Colors.black, fontSize: 16),
                      //     icon: Icon(Icons.arrow_drop_down_circle),
                      //     iconDisabledColor: Colors.grey,
                      //     iconEnabledColor: Colors.black,
                      //     isExpanded: true,
                      //   ),
                      // ),

                      if (_states != null)
                        //   if (citiesList.result != null)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                          child: DropdownSearch<cities.Result>(
                            mode: Mode.BOTTOM_SHEET,
                            enabled: citiLoading,

                            dropdownButtonBuilder: (context) {
                              if (!citiLoading) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.5, vertical: 0.5),
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 32,
                                  ),
                                );
                              }
                            },
                            // enabled: true,
                            showSearchBox: true,
                            searchBoxController: citySearchController,
                            searchBoxDecoration: InputDecoration(
                              labelText: 'search city',
                              contentPadding: EdgeInsets.all(1),
                              // labelStyle: .bodyText1,
                              hintText: 'search city',
                              suffix: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  Icons.clear,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                onPressed: () {
                                  citySearchController.clear();
                                },
                              ),
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
                              prefixIcon: Icon(Icons.search),
                            ),

                            onChanged: (newValue) {
                              _cities = newValue;
                              // getState();
                              setState(() {});
                            },
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.all(1),

                              // hintStyle: .bodyText1,
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF0D0D0D),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
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
                              prefixIcon: Icon(Icons.location_city),
                            ),

                            selectedItem: _cities,
                            filterFn: (item, filter) {
                              if (item.name
                                  .toLowerCase()
                                  .contains(filter.toLowerCase())) {
                                return true;
                              } else {
                                return false;
                              }
                            },
                            itemAsString: (item) {
                              return item.name;
                            },
                            items:
                                citiesList == null ? null : citiesList.result,
                            popupItemBuilder: (context, item, isSelected) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: Container(
                                    width: double.infinity,
                                    height: 20,
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    )),
                              );
                            },
                            label: ("Select City"),
                            hint: ("Select City"),
                          ),
                        ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      //   child: DropdownButton<cities.Result>(
                      //     value: _cities,
                      //     items:
                      //         citiesList.result.map((cities.Result item) {
                      //       return DropdownMenuItem<cities.Result>(
                      //         child: Text(item.name.toString()),
                      //         value: item,
                      //       );
                      //     }).toList(),
                      //     onChanged: (i) {
                      //       setState(() {
                      //         _cities = i;
                      //       });
                      //     },
                      //     hint: Text("Select City"),
                      //     // disabledHint:Text("Disabled"),
                      //     elevation: 8,
                      //     style:
                      //         TextStyle(color: Colors.black, fontSize: 16),
                      //     icon: Icon(Icons.arrow_drop_down_circle),
                      //     iconDisabledColor: Colors.grey,
                      //     iconEnabledColor: Colors.black,
                      //     isExpanded: true,
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 48,
                      //     child: TextFormField(
                      //       controller: cityController,
                      //       obscureText: false,
                      //       decoration: InputDecoration(
                      //         labelText: 'City',
                      //         // labelStyle: .bodyText1,
                      //         hintText: 'City',
                      //         // hintStyle: .bodyText1,
                      //         enabledBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //             color: Color(0xFF0D0D0D),
                      //             width: 0.5,
                      //           ),
                      //           borderRadius: BorderRadius.circular(15),
                      //         ),
                      //         focusedBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //             color: Color(0xFF0D0D0D),
                      //             width: 0.5,
                      //           ),
                      //           borderRadius: BorderRadius.circular(15),
                      //         ),
                      //         prefixIcon: Icon(Icons.location_city),
                      //       ),
                      //       textAlign: TextAlign.start,
                      //       textAlignVertical: TextAlignVertical.center,
                      //       keyboardType: TextInputType.visiblePassword,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 48,
                      //     child: TextFormField(
                      //       controller: stateController,
                      //       obscureText: false,
                      //       decoration: InputDecoration(
                      //         labelText: 'State',
                      //         // labelStyle: .bodyText1,
                      //         hintText: 'State',
                      //         // hintStyle: .bodyText1,
                      //         enabledBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //             color: Color(0xFF0D0D0D),
                      //             width: 0.5,
                      //           ),
                      //           borderRadius: BorderRadius.circular(15),
                      //         ),
                      //         focusedBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //             color: Color(0xFF0D0D0D),
                      //             width: 0.5,
                      //           ),
                      //           borderRadius: BorderRadius.circular(15),
                      //         ),
                      //         prefixIcon: Icon(Icons.location_city),
                      //       ),
                      //       textAlign: TextAlign.start,
                      //       textAlignVertical: TextAlignVertical.center,
                      //       keyboardType: TextInputType.visiblePassword,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 48,
                      //     child: TextFormField(
                      //       controller: countryController,
                      //       obscureText: false,
                      //       decoration: InputDecoration(
                      //         labelText: 'Country',
                      //         // labelStyle: .bodyText1,
                      //         hintText: 'Country',
                      //         // hintStyle: .bodyText1,
                      //         enabledBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //             color: Color(0xFF0D0D0D),
                      //             width: 0.5,
                      //           ),
                      //           borderRadius: BorderRadius.circular(15),
                      //         ),
                      //         focusedBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //             color: Color(0xFF0D0D0D),
                      //             width: 0.5,
                      //           ),
                      //           borderRadius: BorderRadius.circular(15),
                      //         ),
                      //         prefixIcon: Icon(Icons.location_city),
                      //       ),
                      //       textAlign: TextAlign.start,
                      //       textAlignVertical: TextAlignVertical.center,
                      //       keyboardType: TextInputType.visiblePassword,
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Material(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          elevation: 0,
                          child: MaterialButton(
                            onPressed: isLoading == true
                                ? null
                                : () async {
                                    if (nameController.text.trim() == "") {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please fill name")));

                                      return;
                                    }

                                    if (emailController.text.trim() == "") {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please fill email")));

                                      return;
                                    }
                                    bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(emailController.text.trim());
                                    if (!emailValid) {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please use valid email id")));
                                      return;
                                    }
                                    if (phoneController.text.trim() == "") {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please fill phone number")));
                                      return;
                                    }
                                    if (passwordController.text.trim() == "") {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please fill password")));

                                      return;
                                    }

                                    if (_value == null) {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please select a country")));

                                      return;
                                    }

                                    if (_states == null) {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please select a state")));

                                      return;
                                    }

                                    if (_cities == null) {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please select a city")));

                                      return;
                                    }

                                    if (_cities.name.trim() == "") {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please select a city")));

                                      return;
                                    }
                                    if (_states.name.trim() == "") {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please select a state")));

                                      return;
                                    }
                                    if (_value.name.trim() == "") {
                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "please select a country")));

                                      return;
                                    }
                                    await _playAnimation();
                                    var isLogin = await signUp();

                                    if (isLogin) {
                                      await _stopAnimation();
                                      Scaffold.of(context).showSnackBar(
                                          new SnackBar(
                                              content:
                                                  new Text(onSignUpMessage)));
                                      await Future.delayed(
                                          Duration(milliseconds: 500));
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginOtp()));
                                    } else {
                                      await _stopAnimation();

                                      scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content:
                                                  new Text(onSignUpMessage)));
                                    }
                                    await _stopAnimation();
                                  },
                            minWidth: 200.0,
                            elevation: 0.0,
                            height: 37.0,
                            child: Text(
                              isLoading == true
                                  ? 'Loading...'
                                  : 'Create an account',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        "By signing up, you agree to our privacy policy and terms of use",
                        style: TextStyle(fontSize: 9),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> signUp() async {
    String mail = emailController.text.trim();
    String pass = passwordController.text.trim();
    String city = _cities.name.trim();
    String country = _value.name.trim();
    String state = _states.name.trim();
    String phone = phoneController.text.trim();
    String panamess = nameController.text.trim();

    String data = '''{
    "name":"$panamess",
    "email":"$mail",
    "phone":$phone,
    "city":"$city",
    "state":"$state",
    "country":"$country",
    "password":"$pass",
    "cpassword":"$pass"
}''';

    print(data);
    try {
      final http.Response response = await http.post(
          "https://signin-signup-user.herokuapp.com/signup",
          headers: {'Content-Type': "application/json"},
          body: data);

      var body = json.decode(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        // var cookies = response.headers['set-cookie'];
        print(body);

        onSignUpMessage = body['message'];
        setState(() {});
        // return await getUserInfo(cookie);
        return true;
      } else {
        print(response.statusCode);
        print(body);

        onSignUpMessage = body['error'];
        setState(() {});

        // throw Exception("The username or password is incorrect.");
        return false;
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> getcountries() async {
    countryLoading = false;
    setState(() {});

    try {
      // final http.Response response = await http.get(
      //   "https://signin-signup-user.herokuapp.com/countries",
      //   headers: {'Content-Type': "application/json"},
      // );

      // if (response.statusCode == 200) {
      countryList = Country.fromJson(json.decode((coutries)));
      countryList.result.forEach((element) {
        if (element.name.toLowerCase() == "india") {
          _value = element;
          getState();
        }
      });
      // var cookies = response.headers['set-cookie'];
      print(countryList);
      countryLoading = true;
      setState(() {});
      // return await getUserInfo(cookie);
      return true;
      // } else {
      //   print(response.statusCode);
      //   countryLoading = true;
      //   setState(() {});
      //   // throw Exception("The username or password is incorrect.");
      //   return false;
      // }
    } catch (err) {
      countryLoading = true;
      setState(() {});
      rethrow;
    }
  }

  Future<bool> getState() async {
    stateLoading = false;
    setState(() {});

    int id = _value.id;
    String data = '''{
         "country_id":$id
        }''';
    try {
      final http.Response response = await http.post(
        "https://signin-signup-user.herokuapp.com/states",
        headers: {'Content-Type': "application/json"},
        body: data,
      );

      if (response.statusCode == 200) {
        statesList = states.States.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
        // var cookies = response.headers['set-cookie'];
        print(statesList);
        stateLoading = true;
        setState(() {});
        // return await getUserInfo(cookie);
        return true;
      } else {
        print(response.statusCode);
        stateLoading = true;
        setState(() {});

        // throw Exception("The username or password is incorrect.");
        return false;
      }
    } catch (err) {
      stateLoading = true;
      setState(() {});

      rethrow;
    }
  }

  Future<bool> getCities() async {
    citiLoading = false;
    setState(() {});

    int id = _states.id;
    String data = '''{
         "state_id":$id
        }''';
    try {
      final http.Response response = await http.post(
        "https://signin-signup-user.herokuapp.com/cities",
        headers: {'Content-Type': "application/json"},
        body: data,
      );

      if (response.statusCode == 200) {
        citiesList = cities.Cities.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
        // var cookies = response.headers['set-cookie'];
        print(citiesList);
        citiLoading = true;
        setState(() {});
        // return await getUserInfo(cookie);
        return true;
      } else {
        print(response.statusCode);
        citiLoading = true;
        setState(() {});
        // throw Exception("The username or password is incorrect.");
        return false;
      }
    } catch (err) {
      citiLoading = true;
      setState(() {});
      rethrow;
    }
  }

  String coutries = '''
{"result":
  [{"id":1,"name":"Afghanistan","phone_code":93,"capital":"Kabul","currency":"AFN","currency_name":"Afghan afghani","currency_symbol":"؋"},{"id":2,"name":"Aland Islands","phone_code":340,"capital":"Mariehamn","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":3,"name":"Albania","phone_code":355,"capital":"Tirana","currency":"ALL","currency_name":"Albanian lek","currency_symbol":"Lek"},{"id":4,"name":"Algeria","phone_code":213,"capital":"Algiers","currency":"DZD","currency_name":"Algerian dinar","currency_symbol":"دج"},{"id":5,"name":"American Samoa","phone_code":-683,"capital":"Pago Pago","currency":"USD","currency_name":"US Dollar","currency_symbol":"\$"},{"id":6,"name":"Andorra","phone_code":376,"capital":"Andorra la Vella","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":7,"name":"Angola","phone_code":244,"capital":"Luanda","currency":"AOA","currency_name":"Angolan kwanza","currency_symbol":"Kz"},{"id":8,"name":"Anguilla","phone_code":-263,"capital":"The Valley","currency":"XCD","currency_name":"East Caribbean dollar","currency_symbol":"\$"},{"id":9,"name":"Antarctica","phone_code":672,"currency":"AAD","currency_name":"Antarctican dollar","currency_symbol":"\$"},{"id":10,"name":"Antigua And Barbuda","phone_code":-267,"capital":"St. John's","currency":"XCD","currency_name":"Eastern Caribbean dollar","currency_symbol":"\$"},{"id":11,"name":"Argentina","phone_code":54,"capital":"Buenos Aires","currency":"ARS","currency_name":"Argentine peso","currency_symbol":"\$"},{"id":12,"name":"Armenia","phone_code":374,"capital":"Yerevan","currency":"AMD","currency_name":"Armenian dram","currency_symbol":"֏"},{"id":13,"name":"Aruba","phone_code":297,"capital":"Oranjestad","currency":"AWG","currency_name":"Aruban florin","currency_symbol":"ƒ"},{"id":14,"name":"Australia","phone_code":61,"capital":"Canberra","currency":"AUD","currency_name":"Australian dollar","currency_symbol":"\$"},{"id":15,"name":"Austria","phone_code":43,"capital":"Vienna","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":16,"name":"Azerbaijan","phone_code":994,"capital":"Baku","currency":"AZN","currency_name":"Azerbaijani manat","currency_symbol":"m"},{"id":17,"name":"Bahamas The","phone_code":-241,"capital":"Nassau","currency":"BSD","currency_name":"Bahamian dollar","currency_symbol":"B\$"},{"id":18,"name":"Bahrain","phone_code":973,"capital":"Manama","currency":"BHD","currency_name":"Bahraini dinar","currency_symbol":".د.ب"},{"id":19,"name":"Bangladesh","phone_code":880,"capital":"Dhaka","currency":"BDT","currency_name":"Bangladeshi taka","currency_symbol":"৳"},{"id":20,"name":"Barbados","phone_code":-245,"capital":"Bridgetown","currency":"BBD","currency_name":"Barbadian dollar","currency_symbol":"Bds\$"},{"id":21,"name":"Belarus","phone_code":375,"capital":"Minsk","currency":"BYN","currency_name":"Belarusian ruble","currency_symbol":"Br"},{"id":22,"name":"Belgium","phone_code":32,"capital":"Brussels","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},
  {"id":23,"name":"Belize","phone_code":501,"capital":"Belmopan","currency":"BZD","currency_name":"Belize dollar","currency_symbol":"\$"},{"id":24,"name":"Benin","phone_code":229,"capital":"Porto-Novo","currency":"XOF","currency_name":"West African CFA franc","currency_symbol":"CFA"},{"id":25,"name":"Bermuda","phone_code":-440,"capital":"Hamilton","currency":"BMD","currency_name":"Bermudian dollar","currency_symbol":"\$"},{"id":26,"name":"Bhutan","phone_code":975,"capital":"Thimphu","currency":"BTN","currency_name":"Bhutanese ngultrum","currency_symbol":"Nu."},{"id":27,"name":"Bolivia","phone_code":591,"capital":"Sucre","currency":"BOB","currency_name":"Bolivian boliviano","currency_symbol":"Bs."},{"id":155,"name":"Bonaire, Sint Eustatius and Saba","phone_code":599,"capital":"Kralendijk","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":28,"name":"Bosnia and Herzegovina","phone_code":387,"capital":"Sarajevo","currency":"BAM","currency_name":"Bosnia and Herzegovina convertible mark","currency_symbol":"KM"},{"id":29,"name":"Botswana","phone_code":267,"capital":"Gaborone","currency":"BWP","currency_name":"Botswana pula","currency_symbol":"P"},{"id":30,"name":"Bouvet Island","phone_code":55,"currency":"NOK","currency_name":"Norwegian Krone","currency_symbol":"kr"},{"id":31,"name":"Brazil","phone_code":55,"capital":"Brasilia","currency":"BRL","currency_name":"Brazilian real","currency_symbol":"R\$"},{"id":32,"name":"British Indian Ocean Territory","phone_code":246,"capital":"Diego Garcia","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":33,"name":"Brunei","phone_code":673,"capital":"Bandar Seri Begawan","currency":"BND","currency_name":"Brunei dollar","currency_symbol":"B\$"},{"id":34,"name":"Bulgaria","phone_code":359,"capital":"Sofia","currency":"BGN","currency_name":"Bulgarian lev","currency_symbol":"Лв."},{"id":35,"name":"Burkina Faso","phone_code":226,"capital":"Ouagadougou","currency":"XOF","currency_name":"West African CFA franc","currency_symbol":"CFA"},{"id":36,"name":"Burundi","phone_code":257,"capital":"Bujumbura","currency":"BIF","currency_name":"Burundian franc","currency_symbol":"FBu"},{"id":37,"name":"Cambodia","phone_code":855,"capital":"Phnom Penh","currency":"KHR","currency_name":"Cambodian riel","currency_symbol":"KHR"},{"id":38,"name":"Cameroon","phone_code":237,"capital":"Yaounde","currency":"XAF","currency_name":"Central African CFA franc","currency_symbol":"FCFA"},{"id":39,"name":"Canada","phone_code":1,"capital":"Ottawa","currency":"CAD","currency_name":"Canadian dollar","currency_symbol":"\$"},{"id":40,"name":"Cape Verde","phone_code":238,"capital":"Praia","currency":"CVE","currency_name":"Cape Verdean escudo","currency_symbol":"\$"},{"id":41,"name":"Cayman Islands","phone_code":-344,"capital":"George Town","currency":"KYD","currency_name":"Cayman Islands dollar","currency_symbol":"\$"},{"id":42,"name":"Central African Republic","phone_code":236,"capital":"Bangui","currency":"XAF","currency_name":"Central African CFA franc","currency_symbol":"FCFA"},{"id":43,"name":"Chad","phone_code":235,"capital":"N'Djamena","currency":"XAF","currency_name":"Central African CFA franc","currency_symbol":"FCFA"},{"id":44,"name":"Chile","phone_code":56,"capital":"Santiago","currency":"CLP","currency_name":"Chilean peso","currency_symbol":"\$"},
  {"id":45,"name":"China","phone_code":86,"capital":"Beijing","currency":"CNY","currency_name":"Chinese yuan","currency_symbol":"¥"},{"id":46,"name":"Christmas Island","phone_code":61,"capital":"Flying Fish Cove","currency":"AUD","currency_name":"Australian dollar","currency_symbol":"\$"},{"id":47,"name":"Cocos (Keeling) Islands","phone_code":61,"capital":"West Island","currency":"AUD","currency_name":"Australian dollar","currency_symbol":"\$"},{"id":48,"name":"Colombia","phone_code":57,"capital":"Bogotá","currency":"COP","currency_name":"Colombian peso","currency_symbol":"\$"},{"id":49,"name":"Comoros","phone_code":269,"capital":"Moroni","currency":"KMF","currency_name":"Comorian franc","currency_symbol":"CF"},{"id":50,"name":"Congo","phone_code":242,"capital":"Brazzaville","currency":"XAF","currency_name":"Central African CFA franc","currency_symbol":"FC"},{"id":52,"name":"Cook Islands","phone_code":682,"capital":"Avarua","currency":"NZD","currency_name":"Cook Islands dollar","currency_symbol":"\$"},{"id":53,"name":"Costa Rica","phone_code":506,"capital":"San Jose","currency":"CRC","currency_name":"Costa Rican colón","currency_symbol":"₡"},{"id":54,"name":"Cote D'Ivoire (Ivory Coast)","phone_code":225,"capital":"Yamoussoukro","currency":"XOF","currency_name":"West African CFA franc","currency_symbol":"CFA"},{"id":55,"name":"Croatia","phone_code":385,"capital":"Zagreb","currency":"HRK","currency_name":"Croatian kuna","currency_symbol":"kn"},{"id":56,"name":"Cuba","phone_code":53,"capital":"Havana","currency":"CUP","currency_name":"Cuban peso","currency_symbol":"\$"},{"id":249,"name":"Curaçao","phone_code":599,"capital":"Willemstad","currency":"ANG","currency_name":"Netherlands Antillean guilder","currency_symbol":"ƒ"},{"id":57,"name":"Cyprus","phone_code":357,"capital":"Nicosia","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":58,"name":"Czech Republic","phone_code":420,"capital":"Prague","currency":"CZK","currency_name":"Czech koruna","currency_symbol":"Kč"},{"id":51,"name":"Democratic Republic of the Congo","phone_code":243,"capital":"Kinshasa","currency":"CDF","currency_name":"Congolese Franc","currency_symbol":"FC"},{"id":59,"name":"Denmark","phone_code":45,"capital":"Copenhagen","currency":"DKK","currency_name":"Danish krone","currency_symbol":"Kr."},{"id":60,"name":"Djibouti","phone_code":253,"capital":"Djibouti","currency":"DJF","currency_name":"Djiboutian franc","currency_symbol":"Fdj"},{"id":61,"name":"Dominica","phone_code":-766,"capital":"Roseau","currency":"XCD","currency_name":"Eastern Caribbean dollar","currency_symbol":"\$"},{"id":62,"name":"Dominican Republic","phone_code":1,"capital":"Santo Domingo","currency":"DOP","currency_name":"Dominican peso","currency_symbol":"\$"},{"id":63,"name":"East Timor","phone_code":670,"capital":"Dili","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},
  {"id":64,"name":"Ecuador","phone_code":593,"capital":"Quito","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":65,"name":"Egypt","phone_code":20,"capital":"Cairo","currency":"EGP","currency_name":"Egyptian pound","currency_symbol":"ج.م"},{"id":66,"name":"El Salvador","phone_code":503,"capital":"San Salvador","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":67,"name":"Equatorial Guinea","phone_code":240,"capital":"Malabo","currency":"XAF","currency_name":"Central African CFA franc","currency_symbol":"FCFA"},{"id":68,"name":"Eritrea","phone_code":291,"capital":"Asmara","currency":"ERN","currency_name":"Eritrean nakfa","currency_symbol":"Nfk"},{"id":69,"name":"Estonia","phone_code":372,"capital":"Tallinn","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":70,"name":"Ethiopia","phone_code":251,"capital":"Addis Ababa","currency":"ETB","currency_name":"Ethiopian birr","currency_symbol":"Nkf"},{"id":71,"name":"Falkland Islands","phone_code":500,"capital":"Stanley","currency":"FKP","currency_name":"Falkland Islands pound","currency_symbol":"£"},{"id":72,"name":"Faroe Islands","phone_code":298,"capital":"Torshavn","currency":"DKK","currency_name":"Danish krone","currency_symbol":"Kr."},{"id":73,"name":"Fiji Islands","phone_code":679,"capital":"Suva","currency":"FJD","currency_name":"Fijian dollar","currency_symbol":"FJ\$"},{"id":74,"name":"Finland","phone_code":358,"capital":"Helsinki","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":75,"name":"France","phone_code":33,"capital":"Paris","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":76,"name":"French Guiana","phone_code":594,"capital":"Cayenne","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":77,"name":"French Polynesia","phone_code":689,"capital":"Papeete","currency":"XPF","currency_name":"CFP franc","currency_symbol":"₣"},{"id":78,"name":"French Southern Territories","phone_code":262,"capital":"Port-aux-Francais","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":79,"name":"Gabon","phone_code":241,"capital":"Libreville","currency":"XAF","currency_name":"Central African CFA franc","currency_symbol":"FCFA"},{"id":80,"name":"Gambia The","phone_code":220,"capital":"Banjul","currency":"GMD","currency_name":"Gambian dalasi","currency_symbol":"D"},{"id":81,"name":"Georgia","phone_code":995,"capital":"Tbilisi","currency":"GEL","currency_name":"Georgian lari","currency_symbol":"ლ"},{"id":82,"name":"Germany","phone_code":49,"capital":"Berlin","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":83,"name":"Ghana","phone_code":233,"capital":"Accra","currency":"GHS","currency_name":"Ghanaian cedi","currency_symbol":"GH₵"},{"id":84,"name":"Gibraltar","phone_code":350,"capital":"Gibraltar","currency":"GIP","currency_name":"Gibraltar pound","currency_symbol":"£"},{"id":85,"name":"Greece","phone_code":30,"capital":"Athens","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},
  {"id":86,"name":"Greenland","phone_code":299,"capital":"Nuuk","currency":"DKK","currency_name":"Danish krone","currency_symbol":"Kr."},{"id":87,"name":"Grenada","phone_code":-472,"capital":"St. George's","currency":"XCD","currency_name":"Eastern Caribbean dollar","currency_symbol":"\$"},{"id":88,"name":"Guadeloupe","phone_code":590,"capital":"Basse-Terre","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":89,"name":"Guam","phone_code":-670,"capital":"Hagatna","currency":"USD","currency_name":"US Dollar","currency_symbol":"\$"},{"id":90,"name":"Guatemala","phone_code":502,"capital":"Guatemala City","currency":"GTQ","currency_name":"Guatemalan quetzal","currency_symbol":"Q"},{"id":91,"name":"Guernsey and Alderney","phone_code":-1437,"capital":"St Peter Port","currency":"GBP","currency_name":"British pound","currency_symbol":"£"},{"id":92,"name":"Guinea","phone_code":224,"capital":"Conakry","currency":"GNF","currency_name":"Guinean franc","currency_symbol":"FG"},{"id":93,"name":"Guinea-Bissau","phone_code":245,"capital":"Bissau","currency":"XOF","currency_name":"West African CFA franc","currency_symbol":"CFA"},{"id":94,"name":"Guyana","phone_code":592,"capital":"Georgetown","currency":"GYD","currency_name":"Guyanese dollar","currency_symbol":"\$"},{"id":95,"name":"Haiti","phone_code":509,"capital":"Port-au-Prince","currency":"HTG","currency_name":"Haitian gourde","currency_symbol":"G"},{"id":96,"name":"Heard Island and McDonald Islands","phone_code":672,"currency":"AUD","currency_name":"Australian dollar","currency_symbol":"\$"},{"id":97,"name":"Honduras","phone_code":504,"capital":"Tegucigalpa","currency":"HNL","currency_name":"Honduran lempira","currency_symbol":"L"},{"id":98,"name":"Hong Kong S.A.R.","phone_code":852,"capital":"Hong Kong","currency":"HKD","currency_name":"Hong Kong dollar","currency_symbol":"\$"},{"id":99,"name":"Hungary","phone_code":36,"capital":"Budapest","currency":"HUF","currency_name":"Hungarian forint","currency_symbol":"Ft"},{"id":100,"name":"Iceland","phone_code":354,"capital":"Reykjavik","currency":"ISK","currency_name":"Icelandic króna","currency_symbol":"kr"},{"id":101,"name":"India","phone_code":91,"capital":"New Delhi","currency":"INR","currency_name":"Indian rupee","currency_symbol":"₹"},{"id":102,"name":"Indonesia","phone_code":62,"capital":"Jakarta","currency":"IDR","currency_name":"Indonesian rupiah","currency_symbol":"Rp"},{"id":103,"name":"Iran","phone_code":98,"capital":"Tehran","currency":"IRR","currency_name":"Iranian rial","currency_symbol":"﷼"},{"id":104,"name":"Iraq","phone_code":964,"capital":"Baghdad","currency":"IQD","currency_name":"Iraqi dinar","currency_symbol":"د.ع"},{"id":105,"name":"Ireland","phone_code":353,"capital":"Dublin","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":106,"name":"Israel","phone_code":972,"capital":"Jerusalem","currency":"ILS","currency_name":"Israeli new shekel","currency_symbol":"₪"},{"id":107,"name":"Italy","phone_code":39,"capital":"Rome","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},
  {"id":108,"name":"Jamaica","phone_code":-875,"capital":"Kingston","currency":"JMD","currency_name":"Jamaican dollar","currency_symbol":"J\$"},{"id":109,"name":"Japan","phone_code":81,"capital":"Tokyo","currency":"JPY","currency_name":"Japanese yen","currency_symbol":"¥"},{"id":110,"name":"Jersey","phone_code":-1490,"capital":"Saint Helier","currency":"GBP","currency_name":"British pound","currency_symbol":"£"},{"id":111,"name":"Jordan","phone_code":962,"capital":"Amman","currency":"JOD","currency_name":"Jordanian dinar","currency_symbol":"ا.د"},{"id":112,"name":"Kazakhstan","phone_code":7,"capital":"Astana","currency":"KZT","currency_name":"Kazakhstani tenge","currency_symbol":"лв"},{"id":113,"name":"Kenya","phone_code":254,"capital":"Nairobi","currency":"KES","currency_name":"Kenyan shilling","currency_symbol":"KSh"},{"id":114,"name":"Kiribati","phone_code":686,"capital":"Tarawa","currency":"AUD","currency_name":"Australian dollar","currency_symbol":"\$"},{"id":248,"name":"Kosovo","phone_code":383,"capital":"Pristina","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":117,"name":"Kuwait","phone_code":965,"capital":"Kuwait City","currency":"KWD","currency_name":"Kuwaiti dinar","currency_symbol":"ك.د"},{"id":118,"name":"Kyrgyzstan","phone_code":996,"capital":"Bishkek","currency":"KGS","currency_name":"Kyrgyzstani som","currency_symbol":"лв"},{"id":119,"name":"Laos","phone_code":856,"capital":"Vientiane","currency":"LAK","currency_name":"Lao kip","currency_symbol":"₭"},{"id":120,"name":"Latvia","phone_code":371,"capital":"Riga","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":121,"name":"Lebanon","phone_code":961,"capital":"Beirut","currency":"LBP","currency_name":"Lebanese pound","currency_symbol":"£"},{"id":122,"name":"Lesotho","phone_code":266,"capital":"Maseru","currency":"LSL","currency_name":"Lesotho loti","currency_symbol":"L"},{"id":123,"name":"Liberia","phone_code":231,"capital":"Monrovia","currency":"LRD","currency_name":"Liberian dollar","currency_symbol":"\$"},{"id":124,"name":"Libya","phone_code":218,"capital":"Tripolis","currency":"LYD","currency_name":"Libyan dinar","currency_symbol":"د.ل"},{"id":125,"name":"Liechtenstein","phone_code":423,"capital":"Vaduz","currency":"CHF","currency_name":"Swiss franc","currency_symbol":"CHf"},{"id":126,"name":"Lithuania","phone_code":370,"capital":"Vilnius","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":127,"name":"Luxembourg","phone_code":352,"capital":"Luxembourg","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":128,"name":"Macau S.A.R.","phone_code":853,"capital":"Macao","currency":"MOP","currency_name":"Macanese pataca","currency_symbol":"\$"},
  {"id":129,"name":"Macedonia","phone_code":389,"capital":"Skopje","currency":"MKD","currency_name":"Denar","currency_symbol":"ден"},{"id":130,"name":"Madagascar","phone_code":261,"capital":"Antananarivo","currency":"MGA","currency_name":"Malagasy ariary","currency_symbol":"Ar"},{"id":131,"name":"Malawi","phone_code":265,"capital":"Lilongwe","currency":"MWK","currency_name":"Malawian kwacha","currency_symbol":"MK"},{"id":132,"name":"Malaysia","phone_code":60,"capital":"Kuala Lumpur","currency":"MYR","currency_name":"Malaysian ringgit","currency_symbol":"RM"},{"id":133,"name":"Maldives","phone_code":960,"capital":"Male","currency":"MVR","currency_name":"Maldivian rufiyaa","currency_symbol":"Rf"},{"id":134,"name":"Mali","phone_code":223,"capital":"Bamako","currency":"XOF","currency_name":"West African CFA franc","currency_symbol":"CFA"},{"id":135,"name":"Malta","phone_code":356,"capital":"Valletta","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":136,"name":"Man (Isle of)","phone_code":-1580,"capital":"Douglas, Isle of Man","currency":"GBP","currency_name":"British pound","currency_symbol":"£"},{"id":137,"name":"Marshall Islands","phone_code":692,"capital":"Majuro","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":138,"name":"Martinique","phone_code":596,"capital":"Fort-de-France","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":139,"name":"Mauritania","phone_code":222,"capital":"Nouakchott","currency":"MRO","currency_name":"Mauritanian ouguiya","currency_symbol":"MRU"},{"id":140,"name":"Mauritius","phone_code":230,"capital":"Port Louis","currency":"MUR","currency_name":"Mauritian rupee","currency_symbol":"₨"},{"id":141,"name":"Mayotte","phone_code":262,"capital":"Mamoudzou","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":142,"name":"Mexico","phone_code":52,"capital":"Mexico City","currency":"MXN","currency_name":"Mexican peso","currency_symbol":"\$"},{"id":143,"name":"Micronesia","phone_code":691,"capital":"Palikir","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":144,"name":"Moldova","phone_code":373,"capital":"Chisinau","currency":"MDL","currency_name":"Moldovan leu","currency_symbol":"L"},{"id":145,"name":"Monaco","phone_code":377,"capital":"Monaco","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":146,"name":"Mongolia","phone_code":976,"capital":"Ulan Bator","currency":"MNT","currency_name":"Mongolian tögrög","currency_symbol":"₮"},{"id":147,"name":"Montenegro","phone_code":382,"capital":"Podgorica","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},
  {"id":148,"name":"Montserrat","phone_code":-663,"capital":"Plymouth","currency":"XCD","currency_name":"Eastern Caribbean dollar","currency_symbol":"\$"},{"id":149,"name":"Morocco","phone_code":212,"capital":"Rabat","currency":"MAD","currency_name":"Moroccan dirham","currency_symbol":"DH"},{"id":150,"name":"Mozambique","phone_code":258,"capital":"Maputo","currency":"MZN","currency_name":"Mozambican metical","currency_symbol":"MT"},{"id":151,"name":"Myanmar","phone_code":95,"capital":"Nay Pyi Taw","currency":"MMK","currency_name":"Burmese kyat","currency_symbol":"K"},{"id":152,"name":"Namibia","phone_code":264,"capital":"Windhoek","currency":"NAD","currency_name":"Namibian dollar","currency_symbol":"\$"},{"id":153,"name":"Nauru","phone_code":674,"capital":"Yaren","currency":"AUD","currency_name":"Australian dollar","currency_symbol":"\$"},{"id":154,"name":"Nepal","phone_code":977,"capital":"Kathmandu","currency":"NPR","currency_name":"Nepalese rupee","currency_symbol":"₨"},{"id":156,"name":"Netherlands","phone_code":31,"capital":"Amsterdam","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":157,"name":"New Caledonia","phone_code":687,"capital":"Noumea","currency":"XPF","currency_name":"CFP franc","currency_symbol":"₣"},{"id":158,"name":"New Zealand","phone_code":64,"capital":"Wellington","currency":"NZD","currency_name":"New Zealand dollar","currency_symbol":"\$"},{"id":159,"name":"Nicaragua","phone_code":505,"capital":"Managua","currency":"NIO","currency_name":"Nicaraguan córdoba","currency_symbol":"C\$"},{"id":160,"name":"Niger","phone_code":227,"capital":"Niamey","currency":"XOF","currency_name":"West African CFA franc","currency_symbol":"CFA"},{"id":161,"name":"Nigeria","phone_code":234,"capital":"Abuja","currency":"NGN","currency_name":"Nigerian naira","currency_symbol":"₦"},{"id":162,"name":"Niue","phone_code":683,"capital":"Alofi","currency":"NZD","currency_name":"New Zealand dollar","currency_symbol":"\$"},{"id":163,"name":"Norfolk Island","phone_code":672,"capital":"Kingston","currency":"AUD","currency_name":"Australian dollar","currency_symbol":"\$"},{"id":115,"name":"North Korea","phone_code":850,"capital":"Pyongyang","currency":"KPW","currency_name":"North Korean Won","currency_symbol":"₩"},{"id":164,"name":"Northern Mariana Islands","phone_code":-669,"capital":"Saipan","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":165,"name":"Norway","phone_code":47,"capital":"Oslo","currency":"NOK","currency_name":"Norwegian krone","currency_symbol":"kr"},{"id":166,"name":"Oman","phone_code":968,"capital":"Muscat","currency":"OMR","currency_name":"Omani rial","currency_symbol":".ع.ر"},{"id":167,"name":"Pakistan","phone_code":92,"capital":"Islamabad","currency":"PKR","currency_name":"Pakistani rupee","currency_symbol":"₨"},{"id":168,"name":"Palau","phone_code":680,"capital":"Melekeok","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":169,"name":"Palestinian Territory Occupied","phone_code":970,"capital":"East Jerusalem","currency":"ILS","currency_name":"Israeli new shekel","currency_symbol":"₪"},{"id":170,"name":"Panama","phone_code":507,"capital":"Panama City","currency":"PAB","currency_name":"Panamanian balboa","currency_symbol":"B/."},{"id":171,"name":"Papua new Guinea","phone_code":675,"capital":"Port Moresby","currency":"PGK","currency_name":"Papua New Guinean kina","currency_symbol":"K"},{"id":172,"name":"Paraguay","phone_code":595,"capital":"Asuncion","currency":"PYG","currency_name":"Paraguayan guarani","currency_symbol":"₲"},{"id":173,"name":"Peru","phone_code":51,"capital":"Lima","currency":"PEN","currency_name":"Peruvian sol","currency_symbol":"S/."},
  {"id":174,"name":"Philippines","phone_code":63,"capital":"Manila","currency":"PHP","currency_name":"Philippine peso","currency_symbol":"₱"},{"id":175,"name":"Pitcairn Island","phone_code":870,"capital":"Adamstown","currency":"NZD","currency_name":"New Zealand dollar","currency_symbol":"\$"},{"id":176,"name":"Poland","phone_code":48,"capital":"Warsaw","currency":"PLN","currency_name":"Polish złoty","currency_symbol":"zł"},{"id":177,"name":"Portugal","phone_code":351,"capital":"Lisbon","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":178,"name":"Puerto Rico","phone_code":1,"capital":"San Juan","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":179,"name":"Qatar","phone_code":974,"capital":"Doha","currency":"QAR","currency_name":"Qatari riyal","currency_symbol":"ق.ر"},{"id":180,"name":"Reunion","phone_code":262,"capital":"Saint-Denis","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":181,"name":"Romania","phone_code":40,"capital":"Bucharest","currency":"RON","currency_name":"Romanian leu","currency_symbol":"lei"},{"id":182,"name":"Russia","phone_code":7,"capital":"Moscow","currency":"RUB","currency_name":"Russian ruble","currency_symbol":"₽"},{"id":183,"name":"Rwanda","phone_code":250,"capital":"Kigali","currency":"RWF","currency_name":"Rwandan franc","currency_symbol":"FRw"},{"id":184,"name":"Saint Helena","phone_code":290,"capital":"Jamestown","currency":"SHP","currency_name":"Saint Helena pound","currency_symbol":"£"},{"id":185,"name":"Saint Kitts And Nevis","phone_code":-868,"capital":"Basseterre","currency":"XCD","currency_name":"Eastern Caribbean dollar","currency_symbol":"\$"},{"id":186,"name":"Saint Lucia","phone_code":-757,"capital":"Castries","currency":"XCD","currency_name":"Eastern Caribbean dollar","currency_symbol":"\$"},{"id":187,"name":"Saint Pierre and Miquelon","phone_code":508,"capital":"Saint-Pierre","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":188,"name":"Saint Vincent And The Grenadines","phone_code":-783,"capital":"Kingstown","currency":"XCD","currency_name":"Eastern Caribbean dollar","currency_symbol":"\$"},{"id":189,"name":"Saint-Barthelemy","phone_code":590,"capital":"Gustavia","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":190,"name":"Saint-Martin (French part)","phone_code":590,"capital":"Marigot","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":191,"name":"Samoa","phone_code":685,"capital":"Apia","currency":"WST","currency_name":"Samoan tālā","currency_symbol":"SAT"},{"id":192,"name":"San Marino","phone_code":378,"capital":"San Marino","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":193,"name":"Sao Tome and Principe","phone_code":239,"capital":"Sao Tome","currency":"STD","currency_name":"Dobra","currency_symbol":"Db"},{"id":194,"name":"Saudi Arabia","phone_code":966,"capital":"Riyadh","currency":"SAR","currency_name":"Saudi riyal","currency_symbol":"﷼"},{"id":195,"name":"Senegal","phone_code":221,"capital":"Dakar","currency":"XOF","currency_name":"West African CFA franc","currency_symbol":"CFA"},{"id":196,"name":"Serbia","phone_code":381,"capital":"Belgrade","currency":"RSD","currency_name":"Serbian dinar","currency_symbol":"din"},{"id":197,"name":"Seychelles","phone_code":248,"capital":"Victoria","currency":"SCR","currency_name":"Seychellois rupee","currency_symbol":"SRe"},{"id":198,"name":"Sierra Leone","phone_code":232,"capital":"Freetown","currency":"SLL","currency_name":"Sierra Leonean leone","currency_symbol":"Le"},
  {"id":199,"name":"Singapore","phone_code":65,"capital":"Singapur","currency":"SGD","currency_name":"Singapore dollar","currency_symbol":"\$"},{"id":250,"name":"Sint Maarten (Dutch part)","phone_code":1721,"capital":"Philipsburg","currency":"ANG","currency_name":"Netherlands Antillean guilder","currency_symbol":"ƒ"},{"id":200,"name":"Slovakia","phone_code":421,"capital":"Bratislava","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":201,"name":"Slovenia","phone_code":386,"capital":"Ljubljana","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":202,"name":"Solomon Islands","phone_code":677,"capital":"Honiara","currency":"SBD","currency_name":"Solomon Islands dollar","currency_symbol":"Si\$"},{"id":203,"name":"Somalia","phone_code":252,"capital":"Mogadishu","currency":"SOS","currency_name":"Somali shilling","currency_symbol":"Sh.so."},{"id":204,"name":"South Africa","phone_code":27,"capital":"Pretoria","currency":"ZAR","currency_name":"South African rand","currency_symbol":"R"},{"id":205,"name":"South Georgia","phone_code":500,"capital":"Grytviken","currency":"GBP","currency_name":"British pound","currency_symbol":"£"},{"id":116,"name":"South Korea","phone_code":82,"capital":"Seoul","currency":"KRW","currency_name":"Won","currency_symbol":"₩"},{"id":206,"name":"South Sudan","phone_code":211,"capital":"Juba","currency":"SSP","currency_name":"South Sudanese pound","currency_symbol":"£"},{"id":207,"name":"Spain","phone_code":34,"capital":"Madrid","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":208,"name":"Sri Lanka","phone_code":94,"capital":"Colombo","currency":"LKR","currency_name":"Sri Lankan rupee","currency_symbol":"Rs"},{"id":209,"name":"Sudan","phone_code":249,"capital":"Khartoum","currency":"SDG","currency_name":"Sudanese pound","currency_symbol":".س.ج"},{"id":210,"name":"Suriname","phone_code":597,"capital":"Paramaribo","currency":"SRD","currency_name":"Surinamese dollar","currency_symbol":"\$"},{"id":211,"name":"Svalbard And Jan Mayen Islands","phone_code":47,"capital":"Longyearbyen","currency":"NOK","currency_name":"Norwegian Krone","currency_symbol":"kr"},{"id":212,"name":"Swaziland","phone_code":268,"capital":"Mbabane","currency":"SZL","currency_name":"Lilangeni","currency_symbol":"E"},{"id":213,"name":"Sweden","phone_code":46,"capital":"Stockholm","currency":"SEK","currency_name":"Swedish krona","currency_symbol":"kr"},{"id":214,"name":"Switzerland","phone_code":41,"capital":"Bern","currency":"CHF","currency_name":"Swiss franc","currency_symbol":"CHf"},{"id":215,"name":"Syria","phone_code":963,"capital":"Damascus","currency":"SYP","currency_name":"Syrian pound","currency_symbol":"LS"},{"id":216,"name":"Taiwan","phone_code":886,"capital":"Taipei","currency":"TWD","currency_name":"New Taiwan dollar","currency_symbol":"\$"},{"id":217,"name":"Tajikistan","phone_code":992,"capital":"Dushanbe","currency":"TJS","currency_name":"Tajikistani somoni","currency_symbol":"SM"},{"id":218,"name":"Tanzania","phone_code":255,"capital":"Dodoma","currency":"TZS","currency_name":"Tanzanian shilling","currency_symbol":"TSh"},{"id":219,"name":"Thailand","phone_code":66,"capital":"Bangkok","currency":"THB","currency_name":"Thai baht","currency_symbol":"฿"},{"id":220,"name":"Togo","phone_code":228,"capital":"Lome","currency":"XOF","currency_name":"West African CFA franc","currency_symbol":"CFA"},{"id":221,"name":"Tokelau","phone_code":690,"currency":"NZD","currency_name":"New Zealand dollar","currency_symbol":"\$"},
  {"id":222,"name":"Tonga","phone_code":676,"capital":"Nuku'alofa","currency":"TOP","currency_name":"Tongan paʻanga","currency_symbol":"\$"},{"id":223,"name":"Trinidad And Tobago","phone_code":-867,"capital":"Port of Spain","currency":"TTD","currency_name":"Trinidad and Tobago dollar","currency_symbol":"\$"},{"id":224,"name":"Tunisia","phone_code":216,"capital":"Tunis","currency":"TND","currency_name":"Tunisian dinar","currency_symbol":"ت.د"},{"id":225,"name":"Turkey","phone_code":90,"capital":"Ankara","currency":"TRY","currency_name":"Turkish lira","currency_symbol":"₺"},{"id":226,"name":"Turkmenistan","phone_code":993,"capital":"Ashgabat","currency":"TMT","currency_name":"Turkmenistan manat","currency_symbol":"T"},{"id":227,"name":"Turks And Caicos Islands","phone_code":-648,"capital":"Cockburn Town","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":228,"name":"Tuvalu","phone_code":688,"capital":"Funafuti","currency":"AUD","currency_name":"Australian dollar","currency_symbol":"\$"},{"id":229,"name":"Uganda","phone_code":256,"capital":"Kampala","currency":"UGX","currency_name":"Ugandan shilling","currency_symbol":"USh"},{"id":230,"name":"Ukraine","phone_code":380,"capital":"Kiev","currency":"UAH","currency_name":"Ukrainian hryvnia","currency_symbol":"₴"},{"id":231,"name":"United Arab Emirates","phone_code":971,"capital":"Abu Dhabi","currency":"AED","currency_name":"United Arab Emirates dirham","currency_symbol":"إ.د"},{"id":232,"name":"United Kingdom","phone_code":44,"capital":"London","currency":"GBP","currency_name":"British pound","currency_symbol":"£"},{"id":233,"name":"United States","phone_code":1,"capital":"Washington","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":234,"name":"United States Minor Outlying Islands","phone_code":1,"currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":235,"name":"Uruguay","phone_code":598,"capital":"Montevideo","currency":"UYU","currency_name":"Uruguayan peso","currency_symbol":"\$"},{"id":236,"name":"Uzbekistan","phone_code":998,"capital":"Tashkent","currency":"UZS","currency_name":"Uzbekistani soʻm","currency_symbol":"лв"},{"id":237,"name":"Vanuatu","phone_code":678,"capital":"Port Vila","currency":"VUV","currency_name":"Vanuatu vatu","currency_symbol":"VT"},{"id":238,"name":"Vatican City State (Holy See)","phone_code":379,"capital":"Vatican City","currency":"EUR","currency_name":"Euro","currency_symbol":"€"},{"id":239,"name":"Venezuela","phone_code":58,"capital":"Caracas","currency":"VEF","currency_name":"Bolívar","currency_symbol":"Bs"},{"id":240,"name":"Vietnam","phone_code":84,"capital":"Hanoi","currency":"VND","currency_name":"Vietnamese đồng","currency_symbol":"₫"},{"id":241,"name":"Virgin Islands (British)","phone_code":-283,"capital":"Road Town","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":242,"name":"Virgin Islands (US)","phone_code":-339,"capital":"Charlotte Amalie","currency":"USD","currency_name":"United States dollar","currency_symbol":"\$"},{"id":243,"name":"Wallis And Futuna Islands","phone_code":681,"capital":"Mata Utu","currency":"XPF","currency_name":"CFP franc","currency_symbol":"₣"},{"id":244,"name":"Western Sahara","phone_code":212,"capital":"El-Aaiun","currency":"MAD","currency_name":"Moroccan Dirham","currency_symbol":"MAD"},{"id":245,"name":"Yemen","phone_code":967,"capital":"Sanaa","currency":"YER","currency_name":"Yemeni rial","currency_symbol":"﷼"},{"id":246,"name":"Zambia","phone_code":260,"capital":"Lusaka","currency":"ZMW","currency_name":"Zambian kwacha","currency_symbol":"ZK"},{"id":247,"name":"Zimbabwe","phone_code":263,"capital":"Harare","currency":"ZWL","currency_name":"Zimbabwe Dollar","currency_symbol":"\$"}]
  }''';
}
