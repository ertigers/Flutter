import 'package:boxApp/model/exam_chapter_model.dart';
import 'package:boxApp/model/exam_model.dart';
import 'package:boxApp/util/content_util.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class ExamChapterPageModel with ChangeNotifier {

  ExamChapterPageModel(this.examId);

  bool loading = true;
  bool error = false;

  int examId;
  
  List<ExamChapterModel> chapterList = [];

  ExamModel examModel;

  void loadData() async {
    Future.wait([
      this.getExamContent(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getExamContent({bool refresh = true}) {
    return ApiService.request(ApiService.examContent,
      params: {"exam_id": this.examId},
      success: (result) {
        List responseList = result['data']['chapters'] as List;
        this.chapterList = responseList.map((model) => ExamChapterModel.fromJson(model)).toList();
        this.examModel = ExamModel.fromJson(result['data']);

        // 试用更新
        var authStatus = ContentUtils.computeExamAuthStatus(this.examModel);
        if (authStatus['status'] == 'try') {
          this.getExamTrial(refresh: false);
        }
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future getExamTrial({bool refresh = true}) {
    return ApiService.request(ApiService.userExamTrial,
      params: {"exam_id": this.examId},
      success: (result) {},
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
