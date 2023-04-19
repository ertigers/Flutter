import 'dart:convert';

import 'package:boxApp/model/applicant_model.dart';
import 'package:boxApp/model/common_menu_model.dart';
import 'package:boxApp/model/setting_item_model.dart';
import 'package:boxApp/model/user_model.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class MinePageModel with ChangeNotifier {
  
  bool loading = false;
  bool error = false;

  List<CommonMenuModel> menuList = [
    CommonMenuModel(id: 1, title: "今日任务", iconUrl: 'assets/images/mine_menu_task.png'),
    CommonMenuModel(id: 2, title: "我的题库", iconUrl: 'assets/images/mine_menu_exam.png'),
    CommonMenuModel(id: 3, title: "我的课程", iconUrl: 'assets/images/mine_menu_clockin.png'),
    CommonMenuModel(id: 4, title: "我的资料", iconUrl: 'assets/images/mine_menu_course.png'),
  ];
  List<SettingItemModel> settingList1 = [
    SettingItemModel(id: 1, title: "我的订单", iconUrl: 'assets/images/setting_menu_order.png'),
    SettingItemModel(id: 2, title: "我的消息", iconUrl: 'assets/images/setting_menu_message.png'),
    SettingItemModel(id: 3, title: "优惠券包", iconUrl: 'assets/images/setting_menu_coupon.png'),
  ];
  List<SettingItemModel> settingList2 = [
    SettingItemModel(id: 1, title: "地址管理", iconUrl: 'assets/images/setting_menu_order.png'),
    SettingItemModel(id: 2, title: "在线客服", iconUrl: 'assets/images/setting_menu_message.png'),
    SettingItemModel(id: 3, title: "学长认证", iconUrl: 'assets/images/setting_menu_coupon.png'),
  ];
  UserModel userInfo;
  ApplicantModel applicant;

  void loadData() async {
    final token = AppManager.prefs.getString('token');
    // 未登录
    if (token == null) {return;}

    Future.wait([
      this.getUserInfo(),
      this.getUserApplicant()
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  // 用户信息
  Future getUserInfo() {
    return ApiService.request(ApiService.userInfo,
      method: 'get',
      success: (result) async {
        final token = AppManager.prefs.getString('token');
        final userInfo = UserModel.fromJson(result['data']);
        userInfo.token = token;
        this.userInfo = userInfo;

        // 更新本地缓存
        AppManager.prefs.setString('userInfo', jsonEncode(userInfo.toJson()));
      }
    );
  }

  // 用户报考信息
  Future getUserApplicant() {
    return ApiService.request(ApiService.userApplicant,
      method: 'get',
      success: (result) async {
        final applicant = ApplicantModel.fromJson(result['data']);
        this.applicant = applicant;
      }
    );
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
