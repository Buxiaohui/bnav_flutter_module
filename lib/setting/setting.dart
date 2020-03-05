import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:music_flutter/utils/StringUtils.dart';

class SettingPage extends StatefulWidget {
  SettingPage();

  factory SettingPage.forDesignTime() {
    return new SettingPage();
  }

  @override
  State<StatefulWidget> createState() => new _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  MethodChannel _methodChannel = MethodChannel("bnav.flutter.io.setting/method", const JSONMethodCodec());
  static const BasicMessageChannel<String> _basicMessageChannel =
      BasicMessageChannel<String>("bnav.flutter.io.setting/baseMsg", StringCodec());
  static const String COMMUTE_GUIDE_SETTING_SOUND = 'commute_guide_setting_sound';
  static const String COMMUTE_GUIDE_SETTING_SOUND_TURN = 'commute_guide_setting_sound_turn';
  static const String COMMUTE_GUIDE_SETTING_SOUND_ELE_EYE = 'commute_guide_setting_sound_ele_eye';
  static const String COMMUTE_GUIDE_SETTING_SCALE = 'commute_guide_scale_setting';
  static const String NAVI_MODE_DAY_AND_NIGHT = 'NAVI_MODE_DAY_AND_NIGHT';
  static const String CONCERN_ROAD = 'ConcernRoad';
  static const String USER_HELPER = 'UserHelper';

  /// 日夜模式 ：自动模式
  static const int DAY_NIGHT_MODE_AUTO = 1;

  /// 日夜模式 ：白天模式
  static const int DAY_NIGHT_MODE_DAY = 2;

  /// 日夜模式 ：夜晚模式
  static const int DAY_NIGHT_MODE_NIGHT = 3;

  /// this channel just for test
  Future<String> _handlePlatformIncrement(String message) async {
    setState(() {
      print("_handlePlatformIncrement->" + message);
      int count = _count++;
      print(count);
    });
    return "empty_base_msg";
  }

  initSettingWidgetsState() async {
    isSoundEnabled = await _methodChannel.invokeMethod('isSoundEnabled');
    isTurnSoundEnabled = await _methodChannel.invokeMethod('isTurnSoundEnabled');
    isEleEyeSoundEnabled = await _methodChannel.invokeMethod('isEleEyeSoundEnabled');
    dayMode = await _methodChannel.invokeMethod('getDayMode');
    isScaleModeEnabled = await _methodChannel.invokeMethod('isScaleModeEnabled');
    setState(() {});
  }

  @override
  void initState() {
    _basicMessageChannel.setMessageHandler(_handlePlatformIncrement);
    _methodChannel.setMethodCallHandler((methodCall) => Future<dynamic>(() {
          String methodName = methodCall.method;
          print("methodChannel,methodName:$methodName");
          switch (methodName) {
            case 'onSwitchSettingChange':
              {
                String key = methodCall.arguments["arg0"];
                bool val = methodCall.arguments["arg1"];
                print("methodChannel,onSwitchSettingChange,key:$key");
                print("methodChannel,onSwitchSettingChange,val:$val");
                switch (key) {
                  case COMMUTE_GUIDE_SETTING_SOUND:
                    {
                      isSoundEnabled = val;
                    }
                    break;
                  case COMMUTE_GUIDE_SETTING_SOUND_TURN:
                    {
                      isTurnSoundEnabled = val;
                    }
                    break;
                  case COMMUTE_GUIDE_SETTING_SOUND_ELE_EYE:
                    {
                      isEleEyeSoundEnabled = val;
                    }
                    break;
                  default:
                    break;
                }
              }
              break;
            case 'onSelectGroupSettingChange':
              {
                String key = methodCall.arguments["arg0"];
                int val = methodCall.arguments["arg1"];
                print("methodChannel,onSelectGroupSettingChange,key:$key");
                print("methodChannel,onSelectGroupSettingChange,val:$val");
                switch (key) {
                  case NAVI_MODE_DAY_AND_NIGHT:
                    {
                      dayMode = val;
                    }
                    break;
                  default:
                    break;
                }
              }
              break;
            default:
              print("methodChannel,not match any methods $methodName");
              break;
          }

          setState(() {
            print("onSwitchSettingChange,setState,isSoundEnabled:$isSoundEnabled");
            print("onSwitchSettingChange,setState,isTurnSoundEnabled:$isTurnSoundEnabled");
            print("onSwitchSettingChange,setState,isEleEyeSoundEnabled:$isEleEyeSoundEnabled");
          });
          // 给Android端的返回值
          return "methodChannel return msg";
        }));

    super.initState();
    initSettingWidgetsState();
  }

  int dayMode = DAY_NIGHT_MODE_AUTO;
  bool isScaleModeEnabled = false;
  bool isSoundEnabled = false;
  bool isTurnSoundEnabled = false;
  bool isEleEyeSoundEnabled = false;

  var timeDilation;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          color: Color(0xf2ffffff),
          child: ListView(
            children: <Widget>[
              getSwitchWitchWidget(
                  "播报声音",
                  "开启后播报通勤信息提示",
                  isSoundEnabled
                      ? "assets/images/nsdk_set_checkin_icon.png"
                      : "assets/images/nsdk_set_checkout_icon.png",
                  COMMUTE_GUIDE_SETTING_SOUND),
              getDivider(),
              getSwitchWitchWidget(
                  "转向提示",
                  "开启后播报陌生道路转向信息",
                  isTurnSoundEnabled
                      ? "assets/images/nsdk_set_checkin_icon.png"
                      : "assets/images/nsdk_set_checkout_icon.png",
                  COMMUTE_GUIDE_SETTING_SOUND_TURN),
              getDivider(),
              getSwitchWitchWidget(
                  "电子眼提示",
                  "开启后播报电子眼提示",
                  isEleEyeSoundEnabled
                      ? "assets/images/nsdk_set_checkin_icon.png"
                      : "assets/images/nsdk_set_checkout_icon.png",
                  COMMUTE_GUIDE_SETTING_SOUND_ELE_EYE),
              getDivider(),
              getDayModeWidget(),
              getDivider(),
              getCommonItemWidget("关注道路", "你想走那条路啊我的哥", "", CONCERN_ROAD),
              getDivider(),
              getSwitchWitchWidget(
                  "比例尺",
                  "调整比例尺模式",
                  isScaleModeEnabled
                      ? "assets/images/nsdk_set_checkin_icon.png"
                      : "assets/images/nsdk_set_checkout_icon.png",
                  COMMUTE_GUIDE_SETTING_SCALE),
              getDivider(),
              getCommonItemWidget("帮助与反馈", "有问题就说，我给你解决", "", USER_HELPER),
            ],
          ),
        ));
  }

  Widget getDivider() {
    return Container(
      height: 10,
    );
  }

  Widget getDayModeWidget() {
    return Container(
      color: Color(0xf2ffffff),
      height: 81,
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "日夜模式",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // 背景
              color: Colors.green,
              // 设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              // 设置四周边框
              border: new Border.all(width: 1, color: Colors.blueAccent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min, // 尽可能短的占用主轴宽度
              children: <Widget>[
                getDayModeTextContainer("自动", 0, dayMode == DAY_NIGHT_MODE_AUTO),
                getDayModeTextContainer("白天", 1, dayMode == DAY_NIGHT_MODE_DAY),
                getDayModeTextContainer("夜间", 2, dayMode == DAY_NIGHT_MODE_NIGHT),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getDayModeTextContainer(String str, int index, bool isSelect) {
    Color textColor;
    Color bgColor;
    if (isSelect) {
      textColor = Colors.white;
      bgColor = Colors.blueAccent;
    } else {
      if (dayMode == DAY_NIGHT_MODE_DAY) {
        textColor = Colors.blueAccent;
        bgColor = Colors.white;
      } else {
        textColor = Colors.blueAccent;
        bgColor = Colors.black38;
      }
    }
    BoxDecoration decoration;
    if (index == 0) {
      decoration = new BoxDecoration(
          color: bgColor,
          border: new Border.all(width: 0, color: Colors.blueAccent),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(4.0),
            bottomLeft: Radius.circular(4.0),
          ));
    } else if (index == 1) {
      decoration = new BoxDecoration(
        color: bgColor,
        border: new Border(
          top: BorderSide(width: 1.0, color: Color(0x00000000)),
          left: BorderSide(width: 1.0, color: Colors.blueAccent),
          right: BorderSide(width: 1.0, color: Colors.blueAccent),
          bottom: BorderSide(width: 1.0, color: Color(0x00000000)),
        ),
      );
    } else {
      decoration = new BoxDecoration(
          color: bgColor,
          border: new Border.all(width: 0, color: Colors.blueAccent),
          borderRadius: new BorderRadius.only(
            topRight: Radius.circular(4.0),
            bottomRight: Radius.circular(4.0),
          ));
    }
    return Expanded(
      child: GestureDetector(
          onTap: () {
            _methodChannel.invokeMethod('onDayModeItemClick', {'index': index});
            setState(() {});
          },
          child: Container(
            decoration: decoration,
            width: 100,
            height: 30,
            child: Center(
              child: getDayModeText(str, textColor),
            ),
          )),
    );
  }

  Text getDayModeText(String str, Color textColor) {
    return Text(str,
        textAlign: TextAlign.center,
        style:
            TextStyle(fontWeight: FontWeight.normal, decoration: TextDecoration.none, fontSize: 15, color: textColor));
  }

  static const double itemHeight = 90;

  Widget getSwitchWitchWidget(String mainTitle, String subTitle, String imgPath, String tag) {
    return Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 25, 0),
          child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Visibility(
                    visible: StringUtils.isStrNotEmpty(imgPath),
                    child: Container(
                      height: itemHeight,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: getImageWidget(imgPath, tag),
                      ),
                    ),
                  ),
                  Container(
                    height: itemHeight,
                    margin: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            mainTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Visibility(
                              // 设置是否可见：true:可见// false:不可见
                              visible: StringUtils.isStrNotEmpty(subTitle),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  subTitle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                      fontSize: 13,
                                      color: Colors.black38),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }

  Widget getCommonItemWidget(String mainTitle, String subTitle, String imgPath, String tag) {
    return GestureDetector(
        onTap: () {
          print("--onCommonItemClick");
          print(tag);
          _methodChannel.invokeListMethod("onCommonItemClick", {'key': '$tag'});
        },
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 25, 0),
              child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Visibility(
                        visible: StringUtils.isStrNotEmpty(imgPath),
                        child: Container(
                          height: itemHeight,
                          width: double.infinity,
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: getCommonImageWidget(imgPath, tag),
                          ),
                        ),
                      ),
                      Container(
                        height: itemHeight,
                        margin: EdgeInsets.fromLTRB(0, 0, 60, 0),
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                mainTitle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Visibility(
                                  // 设置是否可见：true:可见// false:不可见
                                  visible: StringUtils.isStrNotEmpty(subTitle),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Text(
                                      subTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                          fontSize: 13,
                                          color: Colors.black38),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))),
        ));
  }

  Widget getImageWidget(String imagePath, String tag) {
    return Container(
      color: Colors.transparent,
      width: 56,
      height: 56,
      child: GestureDetector(
          child: Image.asset(
            imagePath,
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.contain,
            height: 28,
            width: 28,
          ),
          onTap: () {
            // something
            print("--onSwitchItemClick");
            _methodChannel.invokeMethod('onSwitchItemClick', {'key': '$tag'});
            int count = _count++;
            _basicMessageChannel.send('$count');
          }),
    );
  }

  int _count = 0;

  Widget getCommonImageWidget(String imagePath, String tag) {
    return Container(
        color: Colors.transparent,
        width: 56,
        height: 56,
        child: GestureDetector(
          child: Image.asset(
            imagePath,
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.contain,
            height: 28,
            width: 28,
          ),
        ));
  }
}

void main() => runApp(SettingPage());
