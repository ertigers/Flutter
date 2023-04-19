import 'package:boxApp/model/exam_model.dart';
import 'package:boxApp/model/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class ExamSimulateModel with ChangeNotifier {
  List<SubjectModel> selectedSubjectList = [
    SubjectModel(id: 1, name: "思想政治理论", code: "101"),
    SubjectModel(id: 2, name: "思想政治理论", code: "101"),
    SubjectModel(id: 3, name: "思想政治理论", code: "101"),
  ];
  List<ExamModel> simulateList = [
    ExamModel(id: 1, name: "2020-2021考研英语真题题库"),
    ExamModel(id: 2, name: "2020-2021考研英语真题题库"),
    ExamModel(id: 3, name: "2020-2021考研英语真题题库"),
  ];
  bool loading = false;
  bool error = false;

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
