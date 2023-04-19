import 'package:boxApp/model/major_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class MajorChooseModel with ChangeNotifier {

  MajorChooseModel({@required this.collegeCode});
  
  bool loading = false;
  bool error = false;

  Map<String, List<MajorModel>> majorMaps = {};

  String collegeCode;

  void loadData() async {
    Future.wait([
      this.getMajorList(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getMajorList({String keyword, bool refresh = true}) {
    Map<String, dynamic> params = {'isPaging': 0, 'college_code': this.collegeCode};
    if (keyword != null) {
      params['keyword'] = keyword;
    }

    return ApiService.request(ApiService.collegeMajorList,
      params: params,
      success: (result) {
        var maps = Map<String, List<MajorModel>>();
        var temps = result['data']['list'] as List;
        List<MajorModel> list = [];
        
        temps.forEach((model) {
          list.add(MajorModel.fromJson(model));
        });
        list.forEach((college) {
          maps[college.categoryName] = maps[college.categoryName] ?? [];
          maps[college.categoryName].add(college);
        });
        this.majorMaps = maps;
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
