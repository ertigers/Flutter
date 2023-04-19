import 'dart:convert';

import 'package:boxApp/model/address_model.dart';
import 'package:boxApp/model/user_model.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class BuyPageModel with ChangeNotifier {

  bool loading = true;
  bool error = false;

  AddressModel addrsssModel;
  UserModel userInfo;

  void loadData({Function callback}) async {
    getUserInfo();

    Future.wait([
      this.getUserAddressDefault(refresh: false),
    ]).then((res) {
      loading = false;
      error = false;

      callback?.call();

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getUserAddressDefault({bool refresh = true}) {
    return ApiService.request(ApiService.userAddress,
      params: {"is_default": 1},
      success: (result) {
        if (result['data'] != null) {
          this.addrsssModel = AddressModel.fromJson(result['data']);
        }        
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  UserModel getUserInfo() {
    if (this.userInfo == null) {
      var userInfo = AppManager.prefs.getString('userInfo');
      this.userInfo = UserModel.fromJson(jsonDecode(userInfo));
    }    
    return this.userInfo;
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
