import 'package:bnav_flutter_module/new_setting/item/setting_sound_children_item.dart';
import 'package:bnav_flutter_module/new_setting/item/setting_switch_item.dart';
import 'package:bnav_flutter_module/new_setting/mode/item_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'item/setting_day_mode_item.dart';
import 'item/setting_more_item.dart';

const String COMMUTE_GUIDE_SETTING_SOUND = 'commute_guide_setting_sound';
const String COMMUTE_GUIDE_SETTING_SOUND_TURN = 'commute_guide_setting_sound_turn';
const String COMMUTE_GUIDE_SETTING_SOUND_ELE_EYE = 'commute_guide_setting_sound_ele_eye';
const String COMMUTE_GUIDE_SETTING_SCALE = 'commute_guide_scale_setting';
const String NAVI_MODE_DAY_AND_NIGHT = 'NAVI_MODE_DAY_AND_NIGHT';

const String NAVI_MODE_DAY_BOOLEAN = 'NAVI_MODE_DAY_AND_NIGHT_BOOLEAN';
const String CONCERN_ROAD = 'ConcernRoad'; // 关注路线
const String USER_HELPER = 'UserHelper'; // UFO

const int SWITCH_ITEM_TYPE = 0;
const int DAY_MODE_ITEM_TYPE = 1;
const int MORE_ITEM_TYPE = 2;
const int SOUND_CHILDREN_TYPE = 3;

class NewSettingPage extends StatefulWidget {
  NewSettingPage();

  factory NewSettingPage.forDesignTime() {
    return new NewSettingPage();
  }

  @override
  State<StatefulWidget> createState() => new _NewSettingPageState();
}

class _NewSettingPageState extends State<NewSettingPage> with TickerProviderStateMixin {
  MethodChannel _methodChannel = MethodChannel("bnav.flutter.io.setting/method", const JSONMethodCodec());
  static const bool USE_ANIM = true;

  initSettingWidgetsState() async {
    isSoundEnabled = await _methodChannel.invokeMethod('isSoundEnabled');
    isTurnSoundEnabled = await _methodChannel.invokeMethod('isTurnSoundEnabled');
    isEleEyeSoundEnabled = await _methodChannel.invokeMethod('isEleEyeSoundEnabled');
    dayMode = await _methodChannel.invokeMethod('getDayModePrefer');
    isDayMode = await _methodChannel.invokeMethod('isDayMode');
    isScaleModeEnabled = await _methodChannel.invokeMethod('isScaleModeEnabled');
    isScaleFunctionEnabled = await _methodChannel.invokeMethod('isScaleFunctionEnabled');
    isDayModeFunctionEnabled = await _methodChannel.invokeMethod('isDayModeFunctionEnabled');
    setState(() {});
  }

  List<BaseItemMode> items;

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

    items = List();
    items.clear();
    if (USE_ANIM) {
      SwitchItemMode soundSwitchItemModeNew = SwitchItemMode();
      soundSwitchItemModeNew.type = SOUND_CHILDREN_TYPE;
      soundSwitchItemModeNew.callback = onSwitchBtnClick;
      items.add(soundSwitchItemModeNew);
    } else {
      SwitchItemMode soundSwitchItemMode = SwitchItemMode();
      soundSwitchItemMode.tag = COMMUTE_GUIDE_SETTING_SOUND;
      soundSwitchItemMode.type = SWITCH_ITEM_TYPE;
      soundSwitchItemMode.callback = onSwitchBtnClick;
      soundSwitchItemMode.mainTitle = "播报声音";
      soundSwitchItemMode.subTitle = "开启后播报通勤信息提示";
      soundSwitchItemMode.isDay = false;
      items.add(soundSwitchItemMode);

      SwitchItemMode turnSoundSwitchItemMode = SwitchItemMode();
      turnSoundSwitchItemMode.tag = COMMUTE_GUIDE_SETTING_SOUND_TURN;
      turnSoundSwitchItemMode.type = SWITCH_ITEM_TYPE;
      turnSoundSwitchItemMode.callback = onSwitchBtnClick;
      turnSoundSwitchItemMode.mainTitle = "转向提示";
      turnSoundSwitchItemMode.subTitle = "开启后播报陌生道路转向信息";
      turnSoundSwitchItemMode.isDay = false;
      items.add(turnSoundSwitchItemMode);

      SwitchItemMode eleSoundSwitchItemMode = SwitchItemMode();
      eleSoundSwitchItemMode.tag = COMMUTE_GUIDE_SETTING_SOUND_ELE_EYE;
      eleSoundSwitchItemMode.type = SWITCH_ITEM_TYPE;
      eleSoundSwitchItemMode.callback = onSwitchBtnClick;
      eleSoundSwitchItemMode.mainTitle = "电子眼提示";
      eleSoundSwitchItemMode.subTitle = "开启后播报电子眼提示";
      eleSoundSwitchItemMode.callback = onSwitchBtnClick;
      eleSoundSwitchItemMode.isDay = false;
      items.add(eleSoundSwitchItemMode);
    }
    if (isScaleFunctionEnabled) {
      SwitchItemMode scaleSwitchItemMode = SwitchItemMode();
      scaleSwitchItemMode.tag = COMMUTE_GUIDE_SETTING_SOUND_ELE_EYE;
      scaleSwitchItemMode.type = SWITCH_ITEM_TYPE;
      scaleSwitchItemMode.callback = onSwitchBtnClick;
      scaleSwitchItemMode.mainTitle = "比例尺";
      scaleSwitchItemMode.subTitle = "比例尺副标题";
      scaleSwitchItemMode.callback = onSwitchBtnClick;
      scaleSwitchItemMode.isDay = false;
      items.add(scaleSwitchItemMode);
    }
    if (isDayModeFunctionEnabled) {
      DayModeItemMode dayModeItemMode = DayModeItemMode();
      dayModeItemMode.tag = NAVI_MODE_DAY_AND_NIGHT;
      dayModeItemMode.type = DAY_MODE_ITEM_TYPE;
      dayModeItemMode.mainTitle = "日夜模式";
      dayModeItemMode.prefer = DAY_NIGHT_MODE_AUTO;
      dayModeItemMode.callback = onDayModeClick;
      dayModeItemMode.isDay = false;
      items.add(dayModeItemMode);
    }
    MoreItemMode concernRoadItemMode = MoreItemMode();
    concernRoadItemMode.tag = CONCERN_ROAD;
    concernRoadItemMode.type = MORE_ITEM_TYPE;
    concernRoadItemMode.mainTitle = "关注道路(先别点击，会crash)";
    concernRoadItemMode.subTitle = "你想走那条路啊我的哥";
    concernRoadItemMode.callback = onMoreBtnClick;
    concernRoadItemMode.isDay = false;
    items.add(concernRoadItemMode);

    MoreItemMode ufoItemMode = MoreItemMode();
    ufoItemMode.tag = USER_HELPER;
    ufoItemMode.type = MORE_ITEM_TYPE;
    ufoItemMode.mainTitle = "帮助与反馈";
    ufoItemMode.subTitle = "有问题就说，我给你解决";
    ufoItemMode.callback = onMoreBtnClick;
    ufoItemMode.isDay = false;
    items.add(ufoItemMode);
    initSettingWidgetsState();
    super.initState();
  }

  void onDayModeClick(int index) {
    _methodChannel.invokeMethod('onDayModeItemClick', {'index': index});
  }

  void onSwitchBtnClick(String tag) {
    _methodChannel.invokeMethod('onSwitchItemClick', {'key': '$tag'});
  }

  void onMoreBtnClick(String tag) {
    _methodChannel.invokeListMethod("onCommonItemClick", {'key': '$tag'});
  }

  /// 白天模式|黑夜模式|自动模式，代表几个选项的选中态
  int dayMode;

  /// 白天模式|黑夜模式，依据此字段刷新UI
  bool isDayMode = true;

  bool isScaleModeEnabled = false;
  bool isSoundEnabled = false;
  bool isTurnSoundEnabled = false;
  bool isEleEyeSoundEnabled = false;
  bool isScaleFunctionEnabled = false;
  bool isDayModeFunctionEnabled = false;

  var timeDilation;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Container(
          color: Colors.grey,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: _buildItem,
          )),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    print("_buildItem index $index");
    switch (items[index].type) {
      case SWITCH_ITEM_TYPE:
        return SwitchItemWidget(items[index]);
      case MORE_ITEM_TYPE:
        return MoreItemWidget(items[index]);
      case DAY_MODE_ITEM_TYPE:
        return DayModeItemWidget(items[index]);
      case SOUND_CHILDREN_TYPE:
        return SoundExpansionItems(
            onExpansionChanged: (expansion) {
              print("声音设置项新状态：$expansion");
            },
            onSwitchBtnClick: (items[index] as SwitchItemMode).callback,
            initiallyExpanded: isSoundEnabled);
      default:
        return null;
    }
  }
}

void main() => runApp(NewSettingPage());
