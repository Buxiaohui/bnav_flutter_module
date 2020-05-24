import 'dart:async';

import 'package:bnav_flutter_module/new_setting/setting_new.dart';
import 'package:bnav_flutter_module/setting/setting.dart';
import 'package:flutter/material.dart';

import 'music/page_music_player.dart';

bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;
  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  // Assert 表达式只在开发模式下被执行，release发布模式下不会被执行的，因此，我们可以在开发模式下设置inDebugMode为true
  assert(inDebugMode = true);
  return inDebugMode;
}

// TODO 规范 route tag
Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // 开发模式下，仅调用默认方式打印日志
      FlutterError.dumpErrorToConsole(details);
    } else {
      // release模式下
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
  runZoned<Future<void>>(
    () async {
      runApp(_widgetForRoute("route2"));
    },
    zoneSpecification: ZoneSpecification(
      // 通过 zoneSpecification，拦截应用中所有调用print输出日志的行为。
      // 这样一来，我们APP中所有调用print方法输出日志的行为都会被拦截，通过这种方式，我们也可以在应用中记录日志，
      // 等到应用触发未捕获的异常时，将异常信息和日志统一上报
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) async {
        _collectLog(line); // 收集日志
      },
    ),
    onError: (Object obj, StackTrace stack) async {
      _reportError(obj, stack);
    },
  );
}

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print("~~~~~~~~~~~信辉哥得永生~~~~~~~~~~~~~_reportError-闪开，我要装逼了~~~~~~~~~~~~~~~~~~~信辉哥得永生~~~~~~~~~~~~~~~~~~~~~\n");
  print("$error" + "\n" + "$stackTrace");
}

Future<Null> _collectLog(String log) async {
  // TODO
  print('_collectLog:' + log);
}

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'route1':
      return new MusicPage();
    case 'route2':
      return new SettingPage();
    case 'route3':
      return new NewSettingPage();
    default:
      // echo  -e "\033[1;31mI ♡  You \e[0m"
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
  }
}

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
//        // counter didn't reset back to zero; the application is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also a layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
