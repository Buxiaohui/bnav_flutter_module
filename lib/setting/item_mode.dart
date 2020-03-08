import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'callback.dart';
import 'setting_day_mode_item.dart';

class BaseItemMode {
  int type;
  String tag;
  bool isDay = false;
}

mixin TwoLineItemMode {
  String mainTitle;
  String subTitle;
  Color _mainTitleTextColor;
  Color _subTitleTextColor;

  Color get mainTitleTextColor => _mainTitleTextColor ??= Colors.black;

  Color get subTitleTextColor => _subTitleTextColor ??= Colors.black38;

  void setSubTitleTextColor(Color value) {
    this._subTitleTextColor = value;
  }

  void setMainTitleTextColor(Color value) {
    this._mainTitleTextColor = value;
  }
}

class MoreItemMode extends BaseItemMode with TwoLineItemMode {
  String tag;
  String mainTitle;
  String subTitle;
  String _imagePathDay;
  String _imagePathNight;
  Color mainTitleTextColor;
  Color subTitleTextColor;
  double itemHeight = 90;
  bool isDay;
  MoreItemClickCallback callback;

  String get imagePathDay => _imagePathDay ??= "assets/images/setting_right_arrow.png";
  String get imagePathNight => _imagePathNight ??= "assets/images/setting_right_arrow.png";
}

class SwitchItemMode extends BaseItemMode with TwoLineItemMode {
  String _imagePathCheckIn;
  String _imagePathCheckOut;
  bool checkIn = false;
  double itemHeight = 90;
  SwitchItemClickCallback callback;

  String get imagePathCheckIn => _imagePathCheckIn ??= "assets/images/nsdk_set_checkin_icon.png";

  String get imagePathCheckOut => _imagePathCheckOut ??= "assets/images/nsdk_set_checkout_icon.png";
}

mixin BaseWidgetState<T extends BaseItemMode> {
  Widget geWidget(T item) {
    return null;
  }
}

class DayModeItemMode extends BaseItemMode with TwoLineItemMode {
  String tag;
  double itemHeight = 90;
  int prefer = DAY_NIGHT_MODE_AUTO;
  DayModeItemClickCallback callback;
}
