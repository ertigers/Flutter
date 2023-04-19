import 'package:boxApp/page/auth/login.dart';
import 'package:boxApp/page/auth/register.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/navigation/tab_navigation.dart';
import 'package:boxApp/page/webview/browser.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:flutter/services.dart';


/// 入口页 可配置广告
class EntryPage extends StatefulWidget {
  const EntryPage({Key key}) : super(key: key);

  @override
  createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
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
    var isAgree = AppManager.prefs.getBool('agreement');
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            Container(
              child: Image.asset('assets/images/splash.png', fit: BoxFit.fitHeight),
              height: double.infinity
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MSizeFit.bottomBarHeight + 10,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (isAgree != null && isAgree) {
                        NavigatorManager.pushReplacement(LoginPage());
                      } else {
                        _showSheet("login");
                      } 
                    },
                    child: Container(
                      width: MSizeFit.screenWidth / 2 + 20,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFF1F86FE),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        "登录",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.0,
                        ),
                      )
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (isAgree != null && isAgree) {
                        NavigatorManager.pushReplacement(RegisterPage());
                      } else {
                        _showSheet("register");
                      }                      
                    },
                    child: Container(
                      width: MSizeFit.screenWidth / 2 + 20,
                      height: 40,
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF000000), width: 0.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        "注册",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 16.0,
                        ),
                      )
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (isAgree != null && isAgree) {
                        NavigatorManager.pushReplacement(TabNavigation());
                      } else {
                        _showSheet("visitor");
                      }                      
                    },
                    child: Container(
                      // width: MSizeFit.screenWidth / 2,
                      height: 40,
                      margin: EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      child: Text(
                        "随便看看>>",
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 14.0,
                          // fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                  ),
                ],
              )
            )
          ],
        )
      )
    );
  }

  // 用户协议弹出窗
  _showSheet(String type) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.white,
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16)
        )
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 260 + MSizeFit.bottomBarHeight,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                alignment: Alignment.center,
                child: Text(
                  '服务条款及隐私政策',
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    '        尊敬的研盒用户，感谢您使用研盒题库。在您使用APP时，我们可能对您的部分信息进行收集，使用和分享。',
                    style: TextStyle(fontSize: 12, color: Color(0xff333333))
                  ),
                  SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '        关于您个人信息的相关问题请详见',
                          style: TextStyle(fontSize: 12, color: Color(0xff333333))
                        ),
                        TextSpan(
                          text: '《用户协议》',
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                          recognizer: TapGestureRecognizer()..onTap = () { 
                            print('《用户协议》');
                            NavigatorManager.push(Browser(url: 'http://render.koudaikaoyan.com/agreement', isFull: true));
                          },
                        ),
                        TextSpan(
                          text: '、',
                          style: TextStyle(fontSize: 12, color: Color(0xff333333))
                        ),
                        TextSpan(
                          text: '《隐私政策》',
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                          recognizer: TapGestureRecognizer()..onTap = () { 
                            print('《隐私政策》');
                            NavigatorManager.push(Browser(url: 'http://render.koudaikaoyan.com/agreement', isFull: true));
                          },
                        ),
                        TextSpan(
                          text: '，请您仔细阅读并充分理解，我们会不断完善技术及安全管理，保护您的个人隐私。',
                          style: TextStyle(fontSize: 12, color: Color(0xff333333))
                        ),
                      ],
                    ),
                  ),
                ])
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    InkWell(
                      child: Container(
                        width: 160,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(248, 248, 248, 1),
                          borderRadius: BorderRadius.all(Radius.circular(21))
                        ),
                        child: Text(
                          '暂不使用',
                          style: TextStyle(
                            color: Color.fromRGBO(51, 51, 51, 1),
                            fontSize: 14),
                        ),
                      ),
                      onTap: () async {
                        await exit();
                      },
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      child: Container(
                        width: 160,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(33, 145, 255, 1),
                          borderRadius: BorderRadius.all(Radius.circular(21))
                        ),
                        child: Text(
                          '同意',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        // 同意协议 不再弹出提示
                        AppManager.prefs.setBool('agreement', true);

                        if (type == "register") {
                          NavigatorManager.pushReplacement(RegisterPage());
                        }
                        if (type == "login") {
                          NavigatorManager.pushReplacement(LoginPage());
                        }
                        if (type == "visitor") {
                          NavigatorManager.pushReplacement(TabNavigation());
                        }
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              )
            ],
          )
        ); 
      },
    );
  }

  // 退出程序
  static Future<void> exit() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
