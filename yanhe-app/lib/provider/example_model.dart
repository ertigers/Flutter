import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/model/example_model.dart';
import 'package:boxApp/util/toast_util.dart';

class ExamplePageModel with ChangeNotifier {
  List<ExampleModel> list = [];
  bool loading = false;
  bool error = false;

  void loadData() async {
    ApiService.request(ApiService.static_domain,
        success: (result) {
          List responseList = result as List;
          List<ExampleModel> categoryList = responseList
              .map((model) => ExampleModel.fromJson(model))
              .toList();
          this.list = categoryList;
          loading = false;
          error = false;
        },
        fail: (e) {
          ToastUtils.showError(e.toString());
          loading = false;
          error = true;
        },
        complete: () => notifyListeners());
  }
  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
