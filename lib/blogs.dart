import 'package:TeamSG/postList.dart';
import 'package:TeamSG/singleBlogpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';
// import 'dart:html' as html;
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

import 'package:http/http.dart' as http;

// import 'pages/oldDemo.dart';
// import 'pages/thumbnailDemo.dart';

class AllBlogs extends StatefulWidget {
  const AllBlogs({Key key}) : super(key: key);

  @override
  _AllBlogsState createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = true;
      getBlogs();
    });
  }

  List<PostList> blogs = [];

  static String convertUrlToId(String url, {bool trimWhitespaces = true}) {
    assert(url?.isNotEmpty ?? false, 'Url cannot be empty');
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  getYoutubeVideo(String url) {
    // var regExp =;

    // url = url.replaceFirst(
    //     RegExp(
    //         r"/^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/"),
    //     "");
    print("hello---" + convertUrlToId(url));
    // print((url && url[7].length == 11) ? url[7] : false);

    return YoutubePlayerController(
      initialVideoId: convertUrlToId(url),
      // url
      //     .replaceAll("https://www.youtube.com/embed/", "")
      //     .replaceFirst(RegExp(r"\.[^]*"), ""),
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  getBlogs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cookie1 = prefs.getString("cookies");
    var url = ('https://signin-signup-user.herokuapp.com/sgtvdata');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url,
        headers: {'Cookie': cookie1, 'Content-Type': "application/json"});
    if (response.statusCode == 200) {
      // var jsonResponse =
      //     convert.jsonDecode(response.body) as Map<String, dynamic>;
      // var itemCount = jsonResponse['totalItems'];
      blogs = List<PostList>.from(json
          .decode(utf8.decode(response.bodyBytes))
          .map((x) => PostList.fromJson(x)));
      setState(() {
        isLoading = false;
      });
      print(blogs.length);
      // print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  String getYoutubdeLink(String body) {
    var document = parse(body);
    dom.Element link = document.querySelector('iframe');
    String imageLink = link != null ? link.attributes['src'] : '';
    print("ack-" + imageLink);
    return imageLink;
  }

  // String getText(String data) {
  //   var text = html.Element.span()..appendHtml(data);
  //   return text.innerText;
  // }

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
        backgroundColor: Color(0xFF020000),
        automaticallyImplyLeading: true,
        title: Text(
          'SG Brand Ambassadors',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFFFDFAFA),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  print(isLoading);
                  if (isLoading) {
                    return Container(
                        height: 500,
                        width: double.infinity,
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    if (blogs.length == 0) {
                      return Container(
                          alignment: Alignment.bottomCenter,
                          height: 500,
                          child: Text("No Data"));
                    } else {
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF5F5F5),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            YoutubePlayerIFrame(
                              controller:
                                  getYoutubeVideo((blogs[index].youtubeurl)),
                              aspectRatio: 16 / 9,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingleBlogPage(
                                            title: blogs[index].heading,
                                            content: blogs[index].description,
                                            yURL: blogs[index].youtubeurl,
                                          )),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 25),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        child: Text(
                                          _parseHtmlString(
                                              blogs[index].heading),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 8, 0, 0),
                                      child: Text(
                                        _parseHtmlString(
                                            blogs[index].description),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
      ),
    );
  }
}
