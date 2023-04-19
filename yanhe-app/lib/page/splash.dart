import 'package:flutter/material.dart';
import 'package:boxApp/navigation/tab_navigation.dart';
// import 'package:boxApp/page/login_register/change_way.dart';

import 'package:boxApp/util/app_manager.dart';
import 'package:boxApp/nav_router/manager.dart';


/// 启动页 可配置广告
class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();    

    Future(() async {
      // 登录状态
      isLogin = AppManager.prefs.getString('token') != null;

      // if (isLogin) {
      //   NavigatorManager.pushReplacement(TabNavigation());
      // } else {
      //   NavigatorManager.pushReplacement(ChangeWay());
      // }
    });

    // 延迟
    // Future.delayed(Duration(seconds: 3), () {
    //   // 登录状态
    //   isLogin = AppManager.prefs.getString('token') != null;

    //   if (isLogin) {
    //     NavigatorManager.pushReplacement(TabNavigation());
    //   } else {
    //     NavigatorManager.pushReplacement(ChangeWay());
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.asset('assets/images/splash.png', fit: BoxFit.fitHeight),
        height: double.infinity)
    );
  }
}
