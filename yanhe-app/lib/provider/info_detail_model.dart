import 'package:boxApp/model/material_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class InfoDetailModel with ChangeNotifier {

  InfoDetailModel(this.infoId);
  
  bool loading = false;
  bool error = false;

  int infoId;

  MaterialModel materialModel;

  void loadData() async {
    // Future.wait([
    //   this.getMaterialInfo(refresh: false)
    // ]).then((res) {
    //   loading = false;
    //   error = false;

    // }).catchError((err) {
    //   loading = false;
    //   print(err);
    //   ToastUtils.showError(err.toString());

    // }).whenComplete(() => notifyListeners());
  }

  Future getMaterialInfo({bool refresh = true}) {
    return ApiService.request(ApiService.materialContent,
      params: {"info_id": this.infoId},
      success: (result) {
        this.materialModel = MaterialModel.fromJson(result['data']);
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
