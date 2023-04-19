import 'package:boxApp/model/college_model.dart';
import 'package:boxApp/model/major_model.dart';
import 'package:boxApp/model/subject_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/navigation/tab_navigation.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class MajorPageModel with ChangeNotifier {

  bool loading = false;
  bool error = false;

  CollegeModel  collegeModel;
  MajorModel majorModel;
  List<SubjectModel> subjectList = [];

  String year;
  set setYear(String year) {
    this.year = year;
    notifyListeners();
  }

  int times;
  set setTimes(int times) {
    this.times = times;
    notifyListeners();
  }

  List<String> getYears() {
    final now = DateTime.now();
    List<String> list = [];
    list.add((now.year + 1).toString());
    list.add((now.year + 2).toString());
    list.add((now.year + 3).toString());
    list.add((now.year + 4).toString());
    return list;
  }

  List<Map<String, dynamic>> getTimes() {
    List<Map<String, dynamic>> list = [];
    list.add({'label': '一次', 'value': 1});
    list.add({'label': '二次', 'value': 2});
    list.add({'label': '三次', 'value': 3});
    return list;
  }

  bool verify() {
    return (this.year != null && this.times != null && this.collegeModel != null && this.majorModel != null && this.subjectList.length > 0);
  }

  void submit() {
    Map<String, dynamic> data = {
      'apply_year': this.year,
      'apply_count': this.times,
      'college_code': this.collegeModel.code,
      'major_id': this.majorModel.id,
      'subject_ids': this.subjectList.map((e) => e.id).toList()
    };

    ApiService.request(ApiService.userApplicant,
      method: 'post',
      data: data,
      success: (result) async {
        ToastUtils.showSuccess('基本信息设置成功');
        // 切换当前路径
        NavigatorManager.pushAndRemoveUntil(TabNavigation());
      },
      fail: (e) {
        print(e);
      }
    );
  }

  void loadData() async {
    ApiService.request(ApiService.static_domain,
        success: (result) {
          // List responseList = result as List;
          // List<CourseModel> courseList = responseList
          //     .map((model) => CourseModel.fromJson(model))
          //     .toList();
          // this.list = courseList;
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
