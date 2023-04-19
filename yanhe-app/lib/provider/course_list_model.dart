import 'package:boxApp/model/common_menu_model.dart';
import 'package:boxApp/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class CourseListModel with ChangeNotifier {

  CourseListModel();
  
  bool loading = false;
  bool error = false;

  List<CourseModel> courseList = [
    CourseModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    CourseModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    CourseModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
  ];

  void loadData() async {
    Future.wait([
      this.getCourseList(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getCourseList({bool refresh = true}) {
    Map<String, dynamic> params = {};
    return ApiService.request(ApiService.courseList,
      params: params,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.courseList = responseList.map((model) => CourseModel.fromJson(model)).toList();
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
