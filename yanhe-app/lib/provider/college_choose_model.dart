import 'package:boxApp/model/college_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class CollegeChooseModel with ChangeNotifier {
  
  bool loading = false;
  bool error = false;

  Map<String, List<CollegeModel>> collegeMaps = {};

  void loadData() async {
    Future.wait([
      this.getCollegeList(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getCollegeList({String keyword, bool refresh = true}) {
    Map<String, dynamic> params = {'isPaging': 0};
    if (keyword != null) {
      params['keyword'] = keyword;
    }

    return ApiService.request(ApiService.collegeList,
      params: params,
      success: (result) {
        var maps = Map<String, List<CollegeModel>>();
        var temps = result['data']['list'] as List;
        List<CollegeModel> list = [];
        
        temps.forEach((model) {
          list.add(CollegeModel.fromJson(model));
        });
        list.forEach((college) {
          maps[college.provinceName] = maps[college.provinceName] ?? [];
          maps[college.provinceName].add(college);
        });
        this.collegeMaps = maps;
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
