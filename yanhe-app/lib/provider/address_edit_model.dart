import 'package:boxApp/model/address_model.dart';
import 'package:boxApp/model/exam_chapter_model.dart';
import 'package:boxApp/model/exam_model.dart';
import 'package:boxApp/util/content_util.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class AddressEditModel with ChangeNotifier {

  AddressEditModel({this.addressId});

  bool loading = true;
  bool error = false;

  int addressId;
  AddressModel addrsssModel = AddressModel();

  void loadData({Function callback}) async {
    if (addressId == null) {
      loading = false;
      error = false;
      notifyListeners();
      return;
    }
    Future.wait([
      this.getAddressInfo(refresh: false)
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

  Future getAddressInfo({bool refresh = true}) {
    return ApiService.request(ApiService.userAddress,
      params: {"id": this.addressId},
      success: (result) {
        this.addrsssModel = AddressModel.fromJson(result['data']);
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future userAddressCreate({Map<String, dynamic> data, bool refresh = true, Function callback}) {
    return ApiService.request(ApiService.userAddress,
      method: 'post',
      data: data,
      success: (result) {
        callback?.call(result);
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future userAddressUpdate({Map<String, dynamic> data, bool refresh = true, Function callback}) {
    return ApiService.request(ApiService.userAddress,
      method: 'put',
      data: data,
      success: (result) {
        callback?.call(result);
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
