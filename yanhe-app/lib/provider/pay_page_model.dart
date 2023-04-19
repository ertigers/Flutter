import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class PayPageModel with ChangeNotifier {

  bool loading = false;
  bool error = false;

  void loadData() async {
    // ApiService.request(ApiService.static_domain,
    //   success: (result) {
        
        
    //     loading = false;
    //     error = false;
    //   },
    //   fail: (e) {
    //     ToastUtils.showError(e.toString());
    //     loading = false;
    //     error = true;
    //   },
    //   complete: () => notifyListeners()
    // );
  }
  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
