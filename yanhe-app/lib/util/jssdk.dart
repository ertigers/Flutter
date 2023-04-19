import 'dart:convert';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/webview/browser.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:boxApp/page/webview/browser.dart';

// 约定JavaScript调用方法时的统一模板
class JSModel {
  String method; // 方法名
  Map params; // 参数
  String callback; // 回调名

  JSModel(this.method, this.params, this.callback);

  // jsonEncode方法中会调用实体类的这个方法。如果实体类中没有这个方法，会报错。
  Map toJson() {
    Map map = new Map();
    map["method"] = this.method;
    map["params"] = this.params;
    map["callback"] = this.callback;
    return map;
  }

  // jsonDecode(jsonStr)方法返回的是Map<String, dynamic>类型，需要这里将map转换成实体类
  static JSModel fromMap(Map<String, dynamic> map) {
    JSModel model = new JSModel(map['method'], map['params'], map['callback']);
    return model;
  }

  @override
  String toString() {
    return "JSModel: {method: $method, params: $params, callback: $callback}";
  }
}

class JsSDK {
  static WebViewController controller;

  // 格式化参数
  static JSModel parseJson(String jsonStr) {
    try {
      return JSModel.fromMap(jsonDecode(jsonStr));
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String toast(context, JSModel jsBridge) {
    String msg = jsBridge.params['message'] ?? '';
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
    return 'success'; // 接口返回值，会透传给JS注册的回调函数
  }

  // 打开原生页面
  static String open(context, JSModel jsBridge) {
    String type = jsBridge.params['type'] ?? '';
    print(jsBridge);
    if (type == 'BrowserFull' && jsBridge.params['url'] != null) {
      NavigatorManager.push(Browser(url: jsBridge.params['url'] ?? '', isFull: true));
    } else if (type == 'Browser' && jsBridge.params['url'] != null) {
      NavigatorManager.push(Browser(url: jsBridge.params['url'] ?? ''));
    }
    return 'success'; // 接口返回值，会透传给JS注册的回调函数
  }

  /// 向H5暴露接口调用
  static void executeMethod(
      BuildContext context, WebViewController controller, String message) {
    var model = JsSDK.parseJson(message);

    // ignore: invalid_use_of_visible_for_testing_member
    final SystemUiOverlayStyle statusBarStyle = SystemChrome.latestStyle;

    var handlers = {
      // test toast
      'toast': () {
        return JsSDK.toast(context, model);
      },
      'goBack': () async {
        if (await controller.canGoBack()) {
          controller.goBack();
        } else {
          // 关闭时恢复原来的状态栏风格
          if (statusBarStyle != null) {
            SystemChrome.setSystemUIOverlayStyle(statusBarStyle);
          }
          Navigator.of(context).pop();
        }
      },
      'goClose': () {
        // 关闭时恢复原来的状态栏风格
        if (statusBarStyle != null) {
          SystemChrome.setSystemUIOverlayStyle(statusBarStyle);
        }
        Navigator.of(context).pop();
      },
      // 调用callJS上的方法
      'checkGoBack': () async {
        return await controller.canGoBack();
      },
      'getDeviceInfo': () async {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["statusBarHeight"] = MSizeFit.statusBarHeight;
        data["bottomBarHeight"] = MSizeFit.bottomBarHeight;
        return data;
      },
      'getUserInfo': () async {
        var userInfo = AppManager.prefs.getString('userInfo');
        return jsonDecode(userInfo);
      },
      'open': () {
        return JsSDK.open(context, model);
      },
      'setStatusBarStyle': () {
        String style = model.params['style'] ?? '';
        if (style != null) {
          SystemChrome.setSystemUIOverlayStyle(style == 'light'
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark);
        }
      }
    };

    // 运行method对应方法实现
    var method = model.method;
    dynamic result;
    if (handlers.containsKey(method)) {
      try {
        result = handlers[method]();
      } catch (e) {
        print(e);
      }
    } else {
      print('无$method对应接口实现');
    }

    // 统一处理JS注册的回调函数
    if (model.callback != null) {
      var callback = model.callback;
      void runCallBack(res) {
        var resultStr = jsonEncode(res ?? '');
        print('resultStr: $resultStr');
        controller.evaluateJavascript('$callback($resultStr);');
      }

      if (result is Future) {
        result.then((value) {
          print('jssdk value: $value');
          runCallBack(value);
        });
      } else {
        print('jssdk value: $result');
        runCallBack(result);
      }
    }
  }
}
