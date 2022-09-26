import 'package:flutter/material.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class YoutubePage extends StatefulWidget {
  const YoutubePage({Key key}) : super(key: key);

  @override
  _YoutubePageState createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  getYoutubeVideo(String url) {
    // url = url.substring(0, url.indexOf("?"));
    return YoutubePlayerController(
      initialVideoId: "d8slaeWp9i4",
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
          '',
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
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            if (false) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (false) {
                return Container(
                    alignment: Alignment.bottomCenter,
                    height: 500,
                    child: Text("No Data"));
              } else {
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  elevation: 3,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      YoutubePlayerIFrame(
                        controller: getYoutubeVideo(""),
                        aspectRatio: 16 / 9,
                      ),
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
