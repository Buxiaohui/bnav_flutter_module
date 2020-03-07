import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class NewSettingPage extends StatefulWidget {
  NewSettingPage();

  factory NewSettingPage.forDesignTime() {
    return new NewSettingPage();
  }

  @override
  State<StatefulWidget> createState() => new _NewSettingPageState();
}

class _NewSettingPageState extends State<NewSettingPage> {
  MethodChannel _methodChannel = MethodChannel("bnav.flutter.io.setting/method", const JSONMethodCodec());
  static const String COMMUTE_GUIDE_SETTING_SOUND = 'commute_guide_setting_sound';
  static const String COMMUTE_GUIDE_SETTING_SOUND_TURN = 'commute_guide_setting_sound_turn';
  static const String COMMUTE_GUIDE_SETTING_SOUND_ELE_EYE = 'commute_guide_setting_sound_ele_eye';
  static const String COMMUTE_GUIDE_SETTING_SCALE = 'commute_guide_scale_setting';
  static const String NAVI_MODE_DAY_AND_NIGHT = 'NAVI_MODE_DAY_AND_NIGHT';

  static const String NAVI_MODE_DAY_BOOLEAN = 'NAVI_MODE_DAY_AND_NIGHT_BOOLEAN';
  static const String CONCERN_ROAD = 'ConcernRoad'; // 关注路线
  static const String USER_HELPER = 'UserHelper'; // UFO

  initSettingWidgetsState() async {
    isSoundEnabled = await _methodChannel.invokeMethod('isSoundEnabled');
    isTurnSoundEnabled = await _methodChannel.invokeMethod('isTurnSoundEnabled');
    isEleEyeSoundEnabled = await _methodChannel.invokeMethod('isEleEyeSoundEnabled');
    dayMode = await _methodChannel.invokeMethod('getDayModePrefer');
    isDayMode = await _methodChannel.invokeMethod('isDayMode');
    isScaleModeEnabled = await _methodChannel.invokeMethod('isScaleModeEnabled');
    setState(() {});
  }

  @override
  void initState() {
    _methodChannel.setMethodCallHandler((methodCall) => Future<dynamic>(() {
          String methodName = methodCall.method;
          print("methodChannel,methodName:$methodName");
          // 事件
          switch (methodName) {

            /// true|false选择类的item
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
                  case NAVI_MODE_DAY_BOOLEAN:
                    {
                      isDayMode = val;
                    }
                    break;
                  case COMMUTE_GUIDE_SETTING_SCALE:
                    {
                      isScaleModeEnabled = val;
                    }
                    break;
                  default:
                    break;
                }
              }
              break;

            /// 选择不同子view的item
            case 'onSelectGroupSettingChange': // 选择类的item
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
          return "return msg from flutter methodChannel-handler";
        }));

    super.initState();
    initSettingWidgetsState();
  }

  /// 白天模式|黑夜模式|自动模式，代表几个选项的选中态
  int dayMode;

  /// 白天模式|黑夜模式，依据此字段刷新UI
  bool isDayMode = true;

  bool isScaleModeEnabled = false;
  bool isSoundEnabled = false;
  bool isTurnSoundEnabled = false;
  bool isEleEyeSoundEnabled = false;

  var timeDilation;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Container(child: ListView.builder(itemBuilder: null)),
    );
  }

  Widget getDivider() {
    return Container(
      height: 10,
    );
  }

  // _methodChannel.invokeMethod('onDayModeItemClick', {'index': index});
  // _methodChannel.invokeListMethod("onCommonItemClick", {'key': '$tag'});
  // _methodChannel.invokeMethod('onSwitchItemClick', {'key': '$tag'});

}

void main() => runApp(NewSettingPage());
