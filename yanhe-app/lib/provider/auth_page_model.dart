import 'dart:convert';
import 'package:boxApp/model/user_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/navigation/tab_navigation.dart';
import 'package:boxApp/page/major/major.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class AuthPageModel with ChangeNotifier {

  //验证码登入
  login(String mobile, String code) async {
    ApiService.request(ApiService.loginBySmsCode,
      method: 'post',
      data: <String, dynamic>{'code': code, 'mobile': mobile},
      success: (result) async {
        var userInfo = UserModel.fromJson(result['data']);
        AppManager.prefs.setString('token', userInfo.token);
        AppManager.prefs.setString('userInfo', jsonEncode(userInfo.toJson()));
        ToastUtils.showSuccess('登录成功');
        // 切换当前路径
        // NavigatorManager.pushAndRemoveUntil(TabNavigation());
        // NavigatorManager.pushAndRemoveUntil(MajorPage());   
        getUserApplicant();     
      },
      fail: (e) {
        print(e);
      },
      complete: () => notifyListeners()
    );
  }

  // 注册
  register(String mobile, String code) async {
    ApiService.request(ApiService.register,
      method: 'post',
      data: <String, dynamic>{'code': code, 'mobile': mobile},
      success: (result) async {
        var userInfo = UserModel.fromJson(result['data']);
        AppManager.prefs.setString('token', userInfo.token);
        AppManager.prefs.setString('userInfo', jsonEncode(userInfo.toJson()));
        ToastUtils.showSuccess('注册成功');
        // 切换当前路径
        // NavigatorManager.pushAndRemoveUntil(TabNavigation());
        // NavigatorManager.pushAndRemoveUntil(MajorPage()); 
        getUserApplicant();    
      },
      fail: (e) {
        ToastUtils.showError(e.error);
      },
      complete: () => notifyListeners()
    );
  }

  // 用户报考信息
  Future getUserApplicant({bool refresh = true}) {
    return ApiService.request(ApiService.userApplicant,
      method: 'get',
      success: (result) async {
        if (result['data'] == null) {
          NavigatorManager.pushAndRemoveUntil(MajorPage()); 
        } else {
          NavigatorManager.pushAndRemoveUntil(TabNavigation());
        }
      }
    );
  }
  
  //获取验证码
  getCode(String mobile) async {
    var result = await ApiService.request(
      ApiService.sendSmscode, 
      method: 'post', 
      data: <String, dynamic>{'mobile': mobile},
      fail: (err) => print(err)
    );
    if (result != null) {
      print(result['data']);
      ToastUtils.showSuccess('验证码已发送! ${result['data']}');
      return true;
    }
    return true;
  }
}
