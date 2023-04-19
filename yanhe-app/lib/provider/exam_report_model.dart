import 'package:boxApp/model/exam_exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class ExamReportPageModel with ChangeNotifier {

  ExamReportPageModel({@required this.parseId});

  bool loading = false;
  bool error = false;

  int parseId;

  ExamExerciseModel examExerciseModel;

  void loadData() async {
    Future.wait([
      this.getParseContent(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getParseContent({bool refresh = true}) {
    return ApiService.request(ApiService.userExamExercise,
      method: 'get',
      params: {"exercise_id": this.parseId},
      success: (result) {
        this.examExerciseModel = ExamExerciseModel.fromJson(result['data']);
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
