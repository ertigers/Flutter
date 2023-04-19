import 'package:boxApp/model/common_menu_model.dart';
import 'package:boxApp/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class CoursePageModel with ChangeNotifier {
  List<CommonMenuModel> menuList = [
    CommonMenuModel(id: 1, title: '公开课程', iconUrl: 'assets/images/course_menu_open.png'),
    CommonMenuModel(id: 2, title: '院校资讯', iconUrl: 'assets/images/course_menu_info.png'),
    CommonMenuModel(id: 3, title: '学长经验', iconUrl: 'assets/images/course_menu_experience.png'),
    CommonMenuModel(id: 4, title: '专业题库', iconUrl: 'assets/images/course_menu_exam.png'),
    CommonMenuModel(id: 5, title: '讲义资料', iconUrl: 'assets/images/course_menu_material.png'),
    CommonMenuModel(id: 6, title: '小班课程', iconUrl: 'assets/images/course_menu_smallclass.png'),
    CommonMenuModel(id: 7, title: '全科定制', iconUrl: 'assets/images/course_menu_customize.png'),
    CommonMenuModel(id: 8, title: '学长学姐', iconUrl: 'assets/images/course_menu_senior.png')
  ];
  List<CourseModel> liveCourseList = [
    CourseModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    CourseModel(id: 2, name: "在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    CourseModel(id: 3, name: "在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
  ];
  List<CourseModel> hotCourseList = [
    CourseModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    CourseModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    CourseModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
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
