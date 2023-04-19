import 'package:boxApp/model/applicant_model.dart';
import 'package:boxApp/model/setting_item_model.dart';
import 'package:boxApp/model/subject_model.dart';
import 'package:boxApp/model/user_model.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class SettingPageModel with ChangeNotifier {
  
  bool loading = false;
  bool error = false;
  
  List<SettingItemModel> aboutList = [
    SettingItemModel(id: 1, title: "关于我们"),
    SettingItemModel(id: 2, title: "用户协议"),
    SettingItemModel(id: 3, title: "隐私政策"),
    SettingItemModel(id: 4, title: "清除缓存"),
    SettingItemModel(id: 4, title: "检查更新"),
  ];
  UserModel userInfo;
  ApplicantModel applicant;
  List<SubjectModel> subjectList = [];

  void loadData() async {
    final token = AppManager.prefs.getString('token');
    // 未登录
    if (token == null) {return;}

    // Future.wait([
    //   this.getUserInfo(refresh: false),
    //   this.getUserApplicant()
    // ]).then((res) {
    //   loading = false;
    //   error = false;

    // }).catchError((err) {
    //   loading = false;
    //   print(err);
    //   ToastUtils.showError(err.toString());

    // }).whenComplete(() => notifyListeners());
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
