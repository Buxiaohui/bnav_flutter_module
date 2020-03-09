import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../mode/item_mode.dart';

class BaseItemWidget<E extends BaseItemMode> extends StatefulWidget {
  E item;

  BaseItemWidget(this.item);

  factory BaseItemWidget.forDesignTime() {
    BaseItemMode itemMode = BaseItemMode();
    return BaseItemWidget(itemMode);
  }

  @override
  State<StatefulWidget> createState() => new BaseItemWidgetState();
}

class BaseItemWidgetState<E extends BaseItemMode> extends State<BaseItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(widget.item);
  }

  Widget getWidget(E item) {
    return Text("BaseItemWidget");
  }
}

void main() => runApp(BaseItemWidget.forDesignTime());
