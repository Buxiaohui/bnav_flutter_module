import 'package:bnav_flutter_module/new_setting/callback.dart';
import 'package:bnav_flutter_module/new_setting/item/setting_base_item.dart';
import 'package:bnav_flutter_module/new_setting/mode/item_mode.dart';
import 'package:bnav_flutter_module/utils/StringUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MoreItemWidget extends BaseItemWidget<MoreItemMode> {
  MoreItemWidget(MoreItemMode item) : super(item);

  factory MoreItemWidget.forDesignTime() {
    MoreItemMode moreItem = MoreItemMode();
    moreItem.mainTitle = "main title";
    moreItem.subTitle = "sub title";
    moreItem.isDay = true;
    moreItem.itemHeight = 90;
    moreItem.mainTitleTextColor = Colors.blue;
    return MoreItemWidget(moreItem);
  }

  @override
  State<StatefulWidget> createState() => new _MoreItemWidgetState();
}

class _MoreItemWidgetState<MoreItemWidget> extends BaseItemWidgetState<MoreItemMode> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getWidget(MoreItemMode item) {
    return getMoreItemWidget(item);
  }

  Widget getMoreItemWidget(MoreItemMode item) {
    String mainTitle = item.mainTitle;
    String subTitle = item.subTitle;
    String imgPathDay = item.imagePathDay;
    String imgPathNight = item.imagePathNight;
    String tag = item.tag;
    double itemHeight = item.itemHeight;
    MoreItemClickCallback callback = item.callback;
    String finalPath = item.isDay ? imgPathDay : imgPathNight;
    return GestureDetector(
        onTap: () {
          callback(tag);
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
                        visible: StringUtils.isStrNotEmpty(finalPath),
                        child: Container(
                          height: itemHeight,
                          width: double.infinity,
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: getImageWidget(finalPath, tag),
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
        ));
  }
}

void main() => runApp(MoreItemWidget.forDesignTime());
