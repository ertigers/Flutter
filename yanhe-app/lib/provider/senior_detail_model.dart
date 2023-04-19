import 'package:boxApp/model/material_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class SeniorDetailModel with ChangeNotifier {

  SeniorDetailModel(this.seniorId);
  
  bool loading = false;
  bool error = false;

  int seniorId;

  MaterialModel materialModel;

  void loadData() async {
    // Future.wait([
    //   this.getSeniorInfo(refresh: false)
    // ]).then((res) {
    //   loading = false;
    //   error = false;

    // }).catchError((err) {
    //   loading = false;
    //   print(err);
    //   ToastUtils.showError(err.toString());

    // }).whenComplete(() => notifyListeners());
  }

  Future getSeniorInfo({bool refresh = true}) {
    return ApiService.request(ApiService.materialContent,
      params: {"senior_id": this.seniorId},
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
