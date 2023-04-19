import 'package:boxApp/model/common_menu_model.dart';
import 'package:boxApp/model/course_model.dart';
import 'package:boxApp/model/material_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class HomePageModel with ChangeNotifier {
  List<CommonMenuModel> menuList = [
    CommonMenuModel(id: 1, title: '今日打卡', iconUrl: 'assets/images/course_menu_open.png'),
    CommonMenuModel(id: 2, title: '自习室', iconUrl: 'assets/images/course_menu_info.png'),
    CommonMenuModel(id: 3, title: '真题资料', iconUrl: 'assets/images/course_menu_experience.png'),
    CommonMenuModel(id: 4, title: '找学长', iconUrl: 'assets/images/course_menu_exam.png'),
  ];

  List<CourseModel> hotCourseList = [
    CourseModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    CourseModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    CourseModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
  ];

  List<MaterialModel> materialList = [
    MaterialModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    MaterialModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    MaterialModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
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
