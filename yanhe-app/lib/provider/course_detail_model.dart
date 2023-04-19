import 'package:boxApp/model/course_chapter_model.dart';
import 'package:boxApp/model/course_model.dart';
import 'package:boxApp/model/teacher_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class CourseDetailModel with ChangeNotifier {

  CourseDetailModel(this.courseId);

  bool loading = true;
  bool error = false;

  int courseId;
  
  List<CourseChapterModel> chapterList = [];
  List<TeacherModel> teacherList = [];
  CourseModel courseModel;

  void loadData() async {
    Future.wait([
      this.getCoureContent(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getCoureContent({bool refresh = true}) {
    return ApiService.request(ApiService.courseContent,
      params: {"course_id": this.courseId},
      success: (result) {
        List cList = result['data']['chapters'] as List;
        List tList = result['data']['teachers'] as List;
        this.chapterList = cList.map((model) => CourseChapterModel.fromJson(model)).toList();
        this.teacherList = tList.map((model) => TeacherModel.fromJson(model)).toList();
        this.courseModel = CourseModel.fromJson(result['data']);
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
