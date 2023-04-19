import 'package:boxApp/model/exam_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class ExamListModel with ChangeNotifier {

  ExamListModel({this.consultId, this.subjectId, this.examType = 1});

  bool loading = true;
  bool error = false;

  int subjectId;
  int consultId;
  int examType;
  
  List<ExamModel> examList = [];

  void loadData() async {
    Future.wait([
      this.getExamList(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getExamList({bool refresh = true}) {
    Map<String, dynamic> params = {};
    if (subjectId != null) {
      params['subject_id'] = subjectId;
    }
    if (consultId != null) {
      params['consult_id'] = consultId;
    }
    if (examType != null) {
      params['type'] = examType;
    }
    return ApiService.request(ApiService.examList,
      params: params,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.examList = responseList.map((model) => ExamModel.fromJson(model)).toList();
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
