import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:html/dom.dart' as dom;
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class SingleBlogPage extends StatefulWidget {
  String title, content, yURL;
  SingleBlogPage({Key key, this.content, this.title, this.yURL})
      : super(key: key);

  @override
  _SingleBlogPageState createState() => _SingleBlogPageState();
}

class _SingleBlogPageState extends State<SingleBlogPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
          widget.title,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFFFDFAFA),
            fontSize: 18,
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
              child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           YoutubePlayerIFrame(
            controller: getYoutubeVideo((widget.yURL)),
            aspectRatio: 16 / 9,
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${widget.content}"),
          ),
           SizedBox(
            height: 25,
          )
         
          // Html(

          //   data: """
          //     ${widget.content}
          //     """,
          //   // padding: EdgeInsets.all(8.0),
          //   onLinkTap: (url) {
          //     // print("Opening $url...");
          //   },
          //   style: {
          //     "iframe": Style(
          //       width: MediaQuery.of(context).size.width * 0.9,
          //       height: MediaQuery.of(context).size.height * 0.35,
          //     )
          //   },
          // ),
        ],
      ))),
    );
  }
}
