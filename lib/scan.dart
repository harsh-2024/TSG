import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:extended_image/extended_image.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as aa;

// import 'package:fstore/models/user_model.dart';
// import 'package:fstore/services/wordpress/wordpress.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/src/painting/text_style.dart' as t;
import 'package:shared_preferences/shared_preferences.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  // final WordPress _service = WordPress();
  // _service.url=""

  @override
  void initState() {
    super.initState();
  }

  String barcode = "";
  String cookie = "";
  String error = "";
  String barcode2 = "";
  String error2 = "";
  List<File> files = [];

  int index = 0;
  PageController c = PageController(initialPage: 0, keepPage: true);

  Future<dynamic> getproductAPI(String cookie, data) async {
    // print('$url');
    showAlertDialog(context, "loading...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cookie = prefs.getString("cookies");
    print(cookie);
    print(data);
    try {
      final response = await http.post(
          'https://signin-signup-user.herokuapp.com/bigqr',
          body: data,
          headers: {'Cookie': cookie, 'Content-Type': "application/json"});
      var body = convert.jsonDecode(response.body);
      print(body['product_name']);
      Navigator.pop(context);

      if (response.statusCode == 200) {
        print("hello");
        return await body;
      } else {
        throw Exception(body['message']);
      }
    } catch (e) {
      Navigator.pop(context);

      //This error exception is about your Rest API is not config correctly so that not return the correct JSON format, please double check the document from this link https://docs.inspireui.com/fluxstore/woocommerce-setup/
      rethrow;
    }
    Navigator.pop(context);
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      if (barcode != null) {
        setState(() {
          this.barcode = barcode;
        });
      }
      return;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.error = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.error = 'Unknown error: $e');
        print(barcode);
      }
    } on FormatException {
      setState(() => this.error = 'Scan incomplete');
      // print(barcode);
    } catch (e) {
      setState(() => this.error = 'Unknown error: $e');
      print(barcode);
    }
  }

  Future scan2() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode2 = barcode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.error2 = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.error2 = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.error2 = 'Scan incomplete');
    } catch (e) {
      setState(() => this.error2 = 'Unknown error: $e');
    }
  }

  Future<void> getproduct(BuildContext context) async {
    // final userModel = Provider.of<UserModel>(context, listen: false);
    // print(userModel.user.cookie);
    // this.cookie = userModel.user.cookie;
    if (barcode.length < 9) {
      onError("Please Scan a valid QR code");
      return;
    }

    try {
      String data = '''{"bigqr":"$barcode"}''';
      final data1 = await getproductAPI("userModel.user.cookie", data);
      print(data1);

      if (data1["imageurl"] == null || data1["imageurl"] == "") {
        onError(data1['message'].toString());
      } else {
        if (data1['product'] != null) {
          onsuccess1(data1['product']['productname'].toString(),
              data1['imageurl'].toString(), true, context);
        } else {
          onsuccess('', data1["imageurl"], false, context);
        }
      }

      // ignore: avoid_print
      print(data1);
      return;
    } catch (e) {
      onError('$e');

      // ignore: avoid_print
      print(e);
    }
  }

  showAlertDialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text(text)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogOnFileUploadSuccess(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      actions: [
        // GestureDetector(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text(
        //       "ok",
        //       style: TextStyle(fontSize: 18),
        //     )),
        // usually buttons at the bottom of the dialog
        Center(
          child: FlatButton(
            color: Colors.grey[200],
            child: Text(
              "ok",
              style: TextStyle(
                letterSpacing: 0.5,
                color: Colors.black,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            onPressed: () async {
              setCurrentPage(0);

              Navigator.of(context).pop();
            },
          ),
        ),
      ],
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ExtendedImage.network(
            "https://www.nicepng.com/png/full/362-3624869_icon-success-circle-green-tick-png.png",
            fit: BoxFit.cover,
            cache: true,
            enableLoadState: false,
          ),
          SizedBox(
            height: 15,
          ),
          Container(margin: EdgeInsets.only(left: 5), child: Text(text)),
        ],
      ),
    );
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  setCurrentPage(val) {
    // setState(() {
    if (index == 0) {
      c.jumpToPage(val);
    } else if (index == 1) {
      c.jumpToPage(val);
    }
    // });
    // notifyListeners();
  }

  Future<dynamic> validateproductAPI(String cookie, data) async {
    showAlertDialog(context, "validating...");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var cookie1 = prefs.getString("cookies");
      print(cookie);
      final response = await http.post(
          'https://signin-signup-user.herokuapp.com/smallqr',
          body: data,
          headers: {'Cookie': cookie1, 'Content-Type': "application/json"});
      var body = convert.jsonDecode(response.body);
      print(body['product_name']);
      Navigator.pop(context);

      if (response.statusCode == 200) {
        print("hello");
        return await body;
      } else {
        throw Exception(body['message']);
      }
    } catch (e) {
      Navigator.pop(context);

      //This error exception is about your Rest API is not config correctly so that not return the correct JSON format, please double check the document from this link https://docs.inspireui.com/fluxstore/woocommerce-setup/
      rethrow;
    }
    Navigator.pop(context);
  }

  void uploads(List<File> files) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cookie1 = prefs.getString("cookies");
    var mailID = prefs.getString("email");

    print(cookie);
    var uri =
        Uri.parse('https://signin-signup-user.herokuapp.com/invoiceupload');
    var request = http.MultipartRequest('POST', uri);
    List<http.MultipartFile> newList = new List<http.MultipartFile>();
    request.headers['Cookie'] = cookie1;
    showAlertDialog(context, "uploading files..");
    request.fields['email'] = mailID;
    print(files.length);

    for (int i = 0; i < 1; i++) {
      print(files[i].path);
      var path = files[i].path;
      File imageFile = File(path);

      var stream = new http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      var multipartFile = new http.MultipartFile("file", stream, length,
          filename: aa.basename(imageFile.path));
      newList.add(multipartFile);
      print(aa.basename(imageFile.path));
    }

    request.files.addAll(newList);
    var response = await request.send();
    print(response.toString());
    await response.stream.transform(utf8.decoder).listen((value) {
      print('value');
      print(value);
      print('value1');
    });
    print(response.statusCode);

    if (response.statusCode == 200) {
      Navigator.pop(context);
      print('uploaded');
      showAlertDialogOnFileUploadSuccess(context, "File Uploaded Successfully");
    } else {
      print(response);

      Navigator.pop(context);
      onError("unable to upload file please try after sometime");

      // print(response.bos);

    }
  }

  Future<void> validateproduct() async {
    // final userModel = Provider.of<UserModel>(context, listen: false);
    // print(userModel.user.cookie);

    try {
      String data = '''{"bigqr":"$barcode","smallqr":"$barcode2"}''';
      final data1 = await validateproductAPI(cookie, data);
      print(data1);

      if (data1['imageurl'] == null) {
        onError(data1["message"]);
      } else {
        // setCurrentPage(1);
        if (data1['imageurl'] ==
            "https://shop.teamsg.in/wp-content/uploads/2022/01/genuine-round-grunge-stamp-ribbon-isolated-sign-163294742.jpg") {
          setCurrentPage(1);
        }

        onValidate(data1['imageurl'], '', '', context);
      }
      // if (data1['code'] == 'success') {
      //   onValidate(data1['imageurl'], '', data1['message'], context);
      // } else if (data1['code'] == 'error') {
      //   onValidate(data1['imageurl'], '', data1['message'], context);
      // }
      // ignore: avoid_print
      print(data1);
      return;
    } catch (e) {
      onError('$e');

      // ignore: avoid_print
      print(e);
    }
  }

  onsuccess(String productName, image, bool val, BuildContext con) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            // alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // height: 140,
                  // color: AppColor.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (productName != "")
                        const Text(
                          "Product Detail",
                          style: t.TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      if (productName != "")
                        const SizedBox(
                          height: 15,
                        ),
                      if (productName != "")
                        Text(
                          productName,
                          style: const t.TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (image != "" || image != null)
                        ExtendedImage.network(
                          image,
                          // width: 75,
                          // height: 150,
                          fit: BoxFit.cover,
                          cache: true,
                          enableLoadState: false,
                        ),
                      if (val)
                        Center(
                          child: FlatButton(
                            color: Colors.redAccent[700],
                            child: Text(
                              'Tap to validate the product',
                              style: t.TextStyle(
                                letterSpacing: 0.5,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () async {
                              if (val) {
                                Navigator.of(context).pop();
                                await scan2();
                                if (barcode2 != "") {
                                  await validateproduct();
                                  // ignore: avoid_print
                                  print("scan " + barcode2);
                                } else {
                                  this.barcode = "";
                                  this.barcode2 = "";
                                  this.error = "";
                                  onError(error2);
                                  // Scaffold.of(con).showSnackBar(SnackBar(
                                  //   content: Text(error2),
                                  //   duration: Duration(seconds: 3),
                                  // ));
                                }
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Show your Image
              Align(
                alignment: Alignment.topRight,
                child: RaisedButton.icon(
                    color: Colors.redAccent[700],
                    textColor: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    label: Text('Close')),
              ),
            ],
          ),
        );
      },
    );
  }

  /// to capture a new image and render captured image on the image view widget
  void _capture() async {
    // file = null;
    // filecode = null;

    // var image = await ImagePicker.getImage(
    //     source: ImageSource.camera,
    //     imageQuality: 100,
    //     preferredCameraDevice: CameraDevice.rear,
    //     maxHeight: 150,
    //     maxWidth: 150);

    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      print(image.path);
      files.add(File(image.path));
      uploads(files);
    } else {
      onError("file not selected");
    }

    // if (croppedImage != null) {
    //   file = croppedImage;

    //   setState(() {
    //     croppedImage = image;
    //     _upload();
    //   });
    // }
  }

  filePicker() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(children: <Widget>[
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                FilePickerResult result =
                    await FilePicker.platform.pickFiles(allowMultiple: true);

                if (result != null) {
                  files = result.paths.map((path) => File(path)).toList();
                  uploads(files);
                } else {
                  onError("file not selected");
                }
              },
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.image),
                  new Text('  Gallery',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'OpenSansRegular')),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                _capture();
              },
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.camera),
                  new Text('  Camera',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'OpenSansRegular')),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  files = [];
                });
              },
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.cancel),
                  new Text('  Cancel',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'OpenSansRegular')),
                ],
              ),
            )
          ]);
        });
  }

  onsuccess1(String productName, image, bool val, BuildContext con) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            // alignment: Alignment.center,
            children: <Widget>[
              if (image != "" || image != null)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.white.withOpacity(0.1), BlendMode.dstATop),
                        image: NetworkImage(
                          image,

                          // width: 150,
                          // height: 150,
                          // fit: BoxFit.cover,
                          // cache: true,
                          // enableLoadState: false,
                        ),
                        // ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      ),
                    ),
                  ),
                ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // height: 140,
                  // color: AppColor.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (productName != "")
                        const Text(
                          "Product Detail",
                          style: t.TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      if (productName != "")
                        const SizedBox(
                          height: 15,
                        ),
                      if (productName != "")
                        Text(
                          productName,
                          style: const t.TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (val)
                        Center(
                          child: FlatButton(
                            minWidth: double.infinity,
                            color: Colors.redAccent[700],
                            child: Text(
                              'Click here to validate product',
                              style: t.TextStyle(
                                letterSpacing: 0.5,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () async {
                              if (val) {
                                Navigator.of(context).pop();
                                await scan2();
                                if (barcode2 != "") {
                                  await validateproduct();
                                  // ignore: avoid_print
                                  print("scan " + barcode2);
                                } else {
                                  this.barcode = "";
                                  this.barcode2 = "";
                                  this.error = "";
                                  onError(error2);
                                  // Scaffold.of(con).showSnackBar(SnackBar(
                                  //   content: Text(error2),
                                  //   duration: Duration(seconds: 3),
                                  // ));
                                }
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Show your Image
              Align(
                alignment: Alignment.topRight,
                child: RaisedButton.icon(
                    color: Colors.redAccent[700],
                    textColor: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    label: Text('Close')),
              ),
            ],
          ),
        );
      },
    );
  }

  onValidate(String image, productname, message, BuildContext con) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            // alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  // height: 140,
                  // color: AppColor.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (productname != "")
                        const Text(
                          "Product Detail",
                          style: t.TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      if (productname != "")
                        const SizedBox(
                          height: 15,
                        ),
                      if (productname != "")
                        Text(
                          productname,
                          style: const t.TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      if (message != "")
                        const SizedBox(
                          height: 8,
                        ),
                      if (message != "")
                        Text(
                          message,
                          style: t.TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      if (image != "" || image != null)
                        ExtendedImage.network(
                          image,
                          // width: 75,
                          // height: 150,
                          fit: BoxFit.cover,
                          cache: true,
                          enableLoadState: false,
                        ),
                    ],
                  ),
                ),
              ),

              // Show your Image
              Align(
                alignment: Alignment.topRight,
                child: RaisedButton.icon(
                    color: Colors.redAccent[700],
                    textColor: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    label: Text('Close')),
              ),
            ],
          ),
        );
      },
    );
  }

  Screen1(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              await scan();
              if (barcode != "") {
                await getproduct(context);
                // ignore: avoid_print
                print("scan " + barcode);
              } else {
                onError(error);
              }
            },
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.qr_code_scanner_sharp,
                  size: 75,
                  color: Colors.redAccent[700],
                ),
                Text("Scan Qr Code")
              ],
            ),
          ),
        ],
      ),
    );
  }

  Screen2() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            height: 80,
            minWidth: 200,
            // minWidth: ,
            onPressed: () async {
              filePicker();
            },
            color: Colors.red,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Upload Invoice",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  onError(String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Text(
                  message.replaceFirst("Exception:", ""),
                  style: t.TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),

                // Show your Image
                Align(
                  alignment: Alignment.topRight,
                  child: RaisedButton.icon(
                      color: Colors.redAccent[700],
                      textColor: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      label: Text('Close')),
                ),
              ],
            ),
          );
        });
    // return showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) {
    //     // return object of type Dialog
    //     return AlertDialog(
    //       // title: Container(
    //       //   color: Colors.white,
    //       //   child:
    //       //       // padding: const EdgeInsets.symm/etric(horizontal: 5, vertical: 0),
    //       //       ExtendedImage.network(
    //       //     image,
    //       //     // width: 75,
    //       //     height: 180,
    //       //     fit: BoxFit.fitHeight,
    //       //     cache: true,
    //       //     enableLoadState: false,
    //       //   ),
    //       // ),
    //       contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),

    //       content: SingleChildScrollView(
    //         child: Container(
    //           // height: 140,
    //           // color: AppColor.amber,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               Text(
    //                 message.replaceFirst("Exception:", ""),
    //                 style: t.TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.black,
    //                   fontSize: 18,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       actions: <Widget>[
    //         // usually buttons at the bottom of the dialog
    //         Center(
    //           child: FlatButton(
    //             color: Colors.grey[200],
    //             child: Text(
    //               "ok",
    //               style: t.TextStyle(
    //                 letterSpacing: 0.5,
    //                 color: Colors.black,
    //                 fontSize: 16,
    //               ),
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //             onPressed: () async {
    //               this.barcode = "";
    //               this.barcode2 = "";
    //               this.error = "";
    //               this.error2 = '';

    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Verify Product",
          style: const t.TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: Center(
          child: GestureDetector(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () => Navigator.pop(context),
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() {
          // ignore: avoid_print
          print("value " + value.toString());
          index = value;
        }),
        controller: c,
        children: [Screen1(context), Screen2()],
      ),
    );
  }
}
