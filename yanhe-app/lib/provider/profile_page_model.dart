import 'dart:convert';

import 'package:boxApp/model/applicant_model.dart';
import 'package:boxApp/model/setting_item_model.dart';
import 'package:boxApp/model/subject_model.dart';
import 'package:boxApp/model/user_model.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class ProfilePageModel with ChangeNotifier {
  
  bool loading = false;
  bool error = false;
  
  List<SettingItemModel> infoList = [
    SettingItemModel(id: 1, title: "头像", hint: '请设置头像'),
    SettingItemModel(id: 2, title: "昵称", hint: '请填写'),
    SettingItemModel(id: 3, title: "性别", hint: '请选择'),
    SettingItemModel(id: 4, title: "签名", hint: '请填写'),
  ];
  List<SettingItemModel> applicantList = [
    SettingItemModel(id: 1, title: "考研年份", hint: '请选择'),
    SettingItemModel(id: 2, title: "报考院校", hint: '请选择'),
    SettingItemModel(id: 3, title: "报考专业", hint: '请选择'),
    SettingItemModel(id: 4, title: "报考科目", hint: '请选择'),
  ];
  List<SettingItemModel> studentList = [
    SettingItemModel(id: 1, title: "院校目标", hint: '请选择'),
    SettingItemModel(id: 2, title: "备考状态", hint: '请选择'),
    SettingItemModel(id: 3, title: "本科院校", hint: '请选择'),
    SettingItemModel(id: 4, title: "本科专业", hint: '请填写'),
  ];
  UserModel userInfo;
  ApplicantModel applicant;
  List<SubjectModel> subjectList = [];

  void loadData() async {
    final token = AppManager.prefs.getString('token');
    // 未登录
    if (token == null) {return;}

    Future.wait([
      this.getUserInfo(refresh: false),
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
  Future getUserInfo({bool refresh = true}) {
    return ApiService.request(ApiService.userInfo,
      method: 'get',
      success: (result) async {
        final token = AppManager.prefs.getString('token');
        final userInfo = UserModel.fromJson(result['data']);
        userInfo.token = token;
        this.userInfo = userInfo;

        // 更新本地缓存
        AppManager.prefs.setString('userInfo', jsonEncode(userInfo.toJson()));
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  // 更新用户信息
  Future updateUserInfo({Map<String, dynamic> data}) {
    return ApiService.request(
      ApiService.userInfo,
      method: 'put',
      data: data,
      success: (result) async {
        getUserInfo();
      }
    );
  }

  // 用户报考信息
  Future getUserApplicant({bool refresh = true}) {
    return ApiService.request(ApiService.userApplicant,
      method: 'get',
      success: (result) async {
        final applicant = ApplicantModel.fromJson(result['data']);
        this.applicant = applicant;

        getSubjectList();
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  // 用户科目列表
  Future getSubjectList({bool refresh = true}) {
    Map<String, dynamic> params = {
      'isPaging': 0, 
      'major_id': this.applicant.applyMajorId,
      'college_code': this.applicant.applyCollegeCode
    };

    return ApiService.request(ApiService.majorSubjectList,
      params: params,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.subjectList = responseList.map((model) => SubjectModel.fromJson(model)).toList();
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  // 更新用户报考信息
  Future updateUserApplicant({Map<String, dynamic> data}) {
    data['id'] = this.applicant.id;
    return ApiService.request(
      ApiService.userApplicant,
      method: 'put',
      data: data,
      success: (result) async {
        getUserApplicant();
      }
    );
  }

  // 图片上传
  Future userImageUpload({dynamic data, Function callback}) {
    return ApiService.request(ApiService.uploadImage,
      method: 'post',
      data: data,
      success: (result) {
        callback?.call(result);
      }
    );
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
