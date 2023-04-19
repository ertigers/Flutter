import 'package:boxApp/model/address_model.dart';
import 'package:boxApp/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';

class AddressPageModel with ChangeNotifier {

  AddressPageModel();

  bool loading = true;
  bool error = false;

  List<AddressModel> addressList = [];

  void loadData() async {
    Future.wait([
      this.getAddressList(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getAddressList({bool refresh = true}) {
    return ApiService.request(ApiService.userAddressList,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.addressList = responseList.map((model) => AddressModel.fromJson(model)).toList();
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future userAddressDelete({Map<String, dynamic> data, bool refresh = true, Function callback}) {
    return ApiService.request(ApiService.userAddress,
      method: 'delete',
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
