import 'package:bnav_flutter_module/new_setting/callback.dart';
import 'package:bnav_flutter_module/new_setting/item/setting_switch_item.dart';
import 'package:bnav_flutter_module/new_setting/mode/item_mode.dart';
import 'package:bnav_flutter_module/new_setting/setting_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SoundExpansionItems extends StatefulWidget {
  const SoundExpansionItems({
    Key key,
    this.onExpansionChanged,
    this.onSwitchBtnClick,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  /// the value false.
  final ValueChanged<bool> onExpansionChanged;
  final SwitchItemClickCallback onSwitchBtnClick;
  final bool initiallyExpanded;

  @override
  _SoundExpansionItemsState createState() => _SoundExpansionItemsState();
}

class _SoundExpansionItemsState extends State<SoundExpansionItems> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _easeInToLinearTween = CurveTween(curve: Curves.easeInToLinear);

  AnimationController _controller;
  Animation<double> _heightFactor;

  bool _isExpanded = false;
  List<BaseItemMode> childrenItems;

  @override
  void initState() {
    super.initState();
    initList();
    const Duration _kExpand = Duration(milliseconds: 200);
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _controller.addListener(() {
      double height = _heightFactor.value;
      print("height:$height");
      setState(() {
        // Rebuild without widget.children.
      });
    });
    _heightFactor = _controller.drive(_easeInToLinearTween);
    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      print("点击了声音按钮之前是否展开:$_isExpanded");
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        print("开始展开");
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          print("开始收起");
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null) widget.onExpansionChanged(_isExpanded);
  }

  double getHeightFactor() {
    double _heightFactorVal = _heightFactor.value;
    print("getHeightFactor:$_heightFactorVal");
    return _heightFactorVal;
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SwitchItemWidget(_soundSwitchItemMode),
          ClipRect(
            child: Align(
              heightFactor: getHeightFactor(),
              child: _buildChildrenWidgets(context),
            ),
          ),
        ],
      ),
    );
  }

  SwitchItemMode _soundSwitchItemMode;

  void initList() {
    childrenItems = List();
    _soundSwitchItemMode = SwitchItemMode();
    _soundSwitchItemMode.tag = COMMUTE_GUIDE_SETTING_SOUND;
    _soundSwitchItemMode.type = SWITCH_ITEM_TYPE;
    _soundSwitchItemMode.callback = (COMMUTE_GUIDE_SETTING_SOUND) {
      widget.onSwitchBtnClick(COMMUTE_GUIDE_SETTING_SOUND);
      print("点击了声音按钮");
      _handleTap();
    };
    _soundSwitchItemMode.mainTitle = "播报声音";
    _soundSwitchItemMode.subTitle = "开启后播报通勤信息提示";
    _soundSwitchItemMode.isDay = false;

    SwitchItemMode turnSoundSwitchItemMode = SwitchItemMode();
    turnSoundSwitchItemMode.tag = COMMUTE_GUIDE_SETTING_SOUND_TURN;
    turnSoundSwitchItemMode.type = SWITCH_ITEM_TYPE;
    turnSoundSwitchItemMode.callback = widget.onSwitchBtnClick;
    turnSoundSwitchItemMode.mainTitle = "转向提示";
    turnSoundSwitchItemMode.subTitle = "开启后播报陌生道路转向信息";
    turnSoundSwitchItemMode.isDay = false;
    childrenItems.add(turnSoundSwitchItemMode);

    SwitchItemMode eleSoundSwitchItemMode = SwitchItemMode();
    eleSoundSwitchItemMode.tag = COMMUTE_GUIDE_SETTING_SOUND_ELE_EYE;
    eleSoundSwitchItemMode.type = SWITCH_ITEM_TYPE;
    eleSoundSwitchItemMode.callback = widget.onSwitchBtnClick;
    eleSoundSwitchItemMode.mainTitle = "电子眼提示";
    eleSoundSwitchItemMode.subTitle = "开启后播报电子眼提示";
    eleSoundSwitchItemMode.isDay = false;
    childrenItems.add(eleSoundSwitchItemMode);
  }

  Widget _buildChildrenWidgets(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    print("_buildChildrenWidgets-closed:$closed");
    if (closed) {
      return null;
    } else {
      return Column(
        children: <Widget>[
          SwitchItemWidget(childrenItems[0]),
          SwitchItemWidget(childrenItems[1]),
        ],
      );
    }
  }
}
