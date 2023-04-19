import 'package:boxApp/model/material_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class MaterialDetailModel with ChangeNotifier {

  MaterialDetailModel(this.materialId);
  
  bool loading = false;
  bool error = false;

  int materialId;

  MaterialModel materialModel;

  void loadData() async {
    Future.wait([
      this.getMaterialInfo(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getMaterialInfo({bool refresh = true}) {
    return ApiService.request(ApiService.materialContent,
      params: {"material_id": this.materialId},
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
