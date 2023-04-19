import 'dart:convert';

import 'package:boxApp/model/subject_model.dart';
import 'package:boxApp/model/user_model.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class SubjectListModel with ChangeNotifier {
  bool loading = false;
  bool error = false;

  List<SubjectModel> subjectList = [];

  List<SubjectModel> userSubjectList = [];

  void loadData() async {
    Future.wait([
      this.getUserSubjectList(refresh: false),
      this.getSubjectList(refresh: false),
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getUserSubjectList({bool refresh = true}) {
    return ApiService.request(ApiService.userSubjectList,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.userSubjectList = responseList.map((model) => SubjectModel.fromJson(model)).toList();
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future getSubjectList({String keyword, bool refresh = true}) {
    Map<String, dynamic> params = {"type": 1, "combine": 0};
    if (keyword != null) {
      params['keyword'] = keyword;
    }
    return ApiService.request(ApiService.subjectUsableList,
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

  Future userSubjectAdd({int subjectId, bool refresh = true}) {
    return ApiService.request(ApiService.userSubject,
    method: 'post',
      data: {"subject_id": subjectId},
      success: (result) {
        this.loadData();
        ToastUtils.showSuccess('科目添加成功');
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future userSubjectRemove({int subjectId, bool refresh = true}) {
    var userInfo = AppManager.prefs.getString('userInfo');
    UserModel userModel = UserModel.fromJson(jsonDecode(userInfo));
    return ApiService.request(ApiService.userSubject,
      method: 'delete',
      data: {"subject_id": subjectId, "uid": userModel.id},
      success: (result) {
        this.loadData();
        ToastUtils.showSuccess('科目删除成功');
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
