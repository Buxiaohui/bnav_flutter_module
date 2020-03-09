import 'package:bnav_flutter_module/new_setting/callback.dart';
import 'package:bnav_flutter_module/new_setting/item/setting_base_item.dart';
import 'package:bnav_flutter_module/new_setting/mode/item_mode.dart';
import 'package:bnav_flutter_module/utils/StringUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SwitchItemWidget extends BaseItemWidget<SwitchItemMode> {
  factory SwitchItemWidget.forDesignTime() {
    SwitchItemMode switchItem = SwitchItemMode();
    switchItem.mainTitle = "main title";
    switchItem.subTitle = "sub title";
    switchItem.checkIn = true;
    switchItem.itemHeight = 90;
    switchItem.setMainTitleTextColor(Colors.blue);

    return SwitchItemWidget(switchItem);
  }

  SwitchItemWidget(SwitchItemMode item) : super(item);

  @override
  State<StatefulWidget> createState() => new _SwitchItemWidgetState();
}

class _SwitchItemWidgetState<SwitchItemWidget> extends BaseItemWidgetState<SwitchItemMode> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getWidget(SwitchItemMode item) {
    return getSwitchWitchWidget(item);
  }

  Widget getSwitchWitchWidget(SwitchItemMode switchItem) {
    String mainTitle = switchItem.mainTitle;
    String subTitle = switchItem.subTitle;
    String imgPathCheckIn = switchItem.imagePathCheckIn;
    String imgPathCheckOut = switchItem.imagePathCheckOut;
    String tag = switchItem.tag;
    double itemHeight = switchItem.itemHeight;
    bool checkIn = switchItem.checkIn;
    SwitchItemClickCallback onCallback = switchItem.callback;
    String finalPath = checkIn ? imgPathCheckIn : imgPathCheckOut;
    return Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 25, 0),
          child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Visibility(
                    visible: StringUtils.isStrNotEmpty(finalPath),
                    child: Container(
                      height: itemHeight,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: getImageWidget(finalPath, tag, onCallback),
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

  Widget getImageWidget(String imagePath, String tag, SwitchItemClickCallback onCallback) {
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
            if (onCallback != null) {
              onCallback(tag);
            }
          }),
    );
  }
}

void main() => runApp(SwitchItemWidget.forDesignTime());
