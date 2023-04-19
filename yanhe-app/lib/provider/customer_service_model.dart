import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/model/example_model.dart';
import 'package:boxApp/util/toast_util.dart';

class CustomerServiceModel with ChangeNotifier {
  List<ExampleModel> list = [];
  bool loading = false;
  bool error = false;

  void loadData() async {
    
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
