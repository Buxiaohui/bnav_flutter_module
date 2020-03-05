import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MusicPage extends StatefulWidget {
  MusicPage();

  factory MusicPage.forDesignTime() {
    // TODO: add arguments
    return new MusicPage();
  }

  @override
  State<StatefulWidget> createState() => new _MyFlutterFlutterFirstState();
}

class _MyFlutterFlutterFirstState extends State<MusicPage>
    with TickerProviderStateMixin {
  static final String TAG = "BXH_AUDIO_PLAYER";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "flutter---bxh",
        home: new Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop(context);
                    } else {
                      SystemNavigator.pop();
                    }
                  },
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                );
              },
            ),
            title: Text("title-bxh-music"),
            centerTitle: true,
          ),
          body: Stack(
            children: <Widget>[
              // 显示歌曲封面背景图片
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage(
                        "assets/images/record_plate_bruno_mars.jpeg"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                      Colors.white30,
                      BlendMode.overlay,
                    ),
                  ),
                ),
              ),
              // 高斯模糊图层
              new Container(
                  child: new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Opacity(
                  opacity: 0.6,
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
              )),
            ],
          ),
        ));
  }

  Widget getImageWidget(String imagePath, int index) {
    return Expanded(
      child: Container(
        child: GestureDetector(
            child: Image.asset(
              imagePath,
              repeat: ImageRepeat.noRepeat,
              fit: BoxFit.contain,
              height: 28,
              width: 28,
            ),
            onTap: () {
              //something
            }),
      ),
    );
  }
}

void main() => runApp(MusicPage());
