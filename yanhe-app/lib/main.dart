import 'dart:io';

import 'package:boxApp/page/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:boxApp/navigation/tab_navigation.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/util/size_fit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 顶层异常捕获
  // runZoned(() {
  /// 设置竖屏
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    // 初始化
    AppManager.init().then((e) {
      // 登录状态
      bool isLogin = AppManager.prefs.getString('token') != null;
      runApp(MyApp(page: isLogin ? TabNavigation() : EntryPage()));
    });

    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。
      // 写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  });
  // }, onError: (e) {
  //   print("catches error of first error-zone.");
  //   debugPrint(e);
  // });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget page;
  const MyApp({Key key, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //对MSizeFit初始化
    MSizeFit.initialize();

    return MaterialApp(
      title: '蜀黍之家',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: NavigatorManager.navigatorKey,
      debugShowCheckedModeBanner: false, //去除右上角的Debug标签
      home: page ?? EntryPage()
    );
  }
}
