import 'package:bnav_flutter_module/new_setting/callback.dart';
import 'package:bnav_flutter_module/new_setting/item/setting_base_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../mode/item_mode.dart';

/// 日夜模式 ：自动模式
const int DAY_NIGHT_MODE_AUTO = 1;

/// 日夜模式 ：白天模式
const int DAY_NIGHT_MODE_DAY = 2;

/// 日夜模式 ：夜晚模式
const int DAY_NIGHT_MODE_NIGHT = 3;

class DayModeItemWidget extends BaseItemWidget<DayModeItemMode> {
  factory DayModeItemWidget.forDesignTime() {
    DayModeItemMode dayModeItem = DayModeItemMode();
    dayModeItem.isDay = true;
    dayModeItem.prefer = DAY_NIGHT_MODE_AUTO;
    dayModeItem.itemHeight = 90;
    return DayModeItemWidget(dayModeItem);
  }

  DayModeItemWidget(DayModeItemMode item) : super(item);

  @override
  State<StatefulWidget> createState() => new _DayModeItemWidgetState();
}

class _DayModeItemWidgetState<DayModeItemWidget> extends BaseItemWidgetState<DayModeItemMode> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getWidget(DayModeItemMode item) {
    return getDayModeWidget(item);
  }

  Widget getDayModeWidget(DayModeItemMode item) {
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
                getDayModeTextContainer("自动", 0, item.prefer == DAY_NIGHT_MODE_AUTO, item.isDay, item.callback),
                getDayModeTextContainer("白天", 1, item.prefer == DAY_NIGHT_MODE_DAY, item.isDay, item.callback),
                getDayModeTextContainer("夜间", 2, item.prefer == DAY_NIGHT_MODE_NIGHT, item.isDay, item.callback),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getDayModeTextContainer(
      String str, int index, bool isSelect, bool isDayMode, DayModeItemClickCallback callback) {
    Color textColor;
    Color bgColor;
    if (isSelect) {
      textColor = Colors.white;
      bgColor = Colors.blueAccent;
    } else {
      if (isDayMode) {
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
            callback(index);
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
}

void main() => runApp(DayModeItemWidget.forDesignTime());
