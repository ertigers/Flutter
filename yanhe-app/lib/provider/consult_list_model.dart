import 'dart:convert';

import 'package:boxApp/model/consult_model.dart';
import 'package:boxApp/model/user_model.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class ConsultListModel with ChangeNotifier {
  bool loading = false;
  bool error = false;

  List<ConsultModel> consultList = [];

  List<ConsultModel> userConsultList = [];

  void loadData() async {
    Future.wait([
      this.getUserConsultList(refresh: false),
      this.getConsultList(refresh: false),
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getUserConsultList({bool refresh = true}) {
    return ApiService.request(ApiService.userConsultList,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.userConsultList = responseList.map((model) => ConsultModel.fromJson(model)).toList();
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future getConsultList({String keyword, bool refresh = true}) {
    Map<String, dynamic> params = {"combine": 0};
    if (keyword != null) {
      params['keyword'] = keyword;
    }
    return ApiService.request(ApiService.consultUsableList,
      params: params,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.consultList = responseList.map((model) => ConsultModel.fromJson(model)).toList();
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future userConsultAdd({int consultId, bool refresh = true}) {
    return ApiService.request(ApiService.userConsult,
    method: 'post',
      data: {"consult_id": consultId},
      success: (result) {
        this.loadData();
        ToastUtils.showSuccess('参考书添加成功');
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future userConsultRemove({int consultId, bool refresh = true}) {
    var userInfo = AppManager.prefs.getString('userInfo');
    UserModel userModel = UserModel.fromJson(jsonDecode(userInfo));
    return ApiService.request(ApiService.userConsult,
      method: 'delete',
      data: {"consult_id": consultId, "uid": userModel.id},
      success: (result) {
        this.loadData();
        ToastUtils.showSuccess('参考书删除成功');
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
