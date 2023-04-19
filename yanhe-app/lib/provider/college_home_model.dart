import 'package:boxApp/model/common_menu_model.dart';
import 'package:boxApp/model/course_model.dart';
import 'package:boxApp/model/exam_model.dart';
import 'package:boxApp/model/material_model.dart';
import 'package:boxApp/model/info_model.dart';
import 'package:boxApp/model/senior_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class AnchorModel {
  GlobalKey key;
  String name;
  bool active;
  AnchorModel({this.key, this.name, this.active = false});
}

class CollegeHomeModel with ChangeNotifier {
  bool loading = false;
  bool error = false;

  List<AnchorModel> anchorList = [
    AnchorModel(key: GlobalKey(), name: '公开课程', active: true),
    AnchorModel(key: GlobalKey(), name: '院校资讯'),
    AnchorModel(key: GlobalKey(), name: '学长经验'),
    AnchorModel(key: GlobalKey(), name: '专业题库'),
    AnchorModel(key: GlobalKey(), name: '讲义资料'),
    AnchorModel(key: GlobalKey(), name: '小班课程'),
    AnchorModel(key: GlobalKey(), name: '全科定制'),
    AnchorModel(key: GlobalKey(), name: '学长学姐')
  ];
  // 公开课程
  List<CourseModel> publiceCourseList = [
    CourseModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    CourseModel(id: 2, name: "在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    CourseModel(id: 3, name: "在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
  ];
  // 专业题库
  List<ExamModel> examList = [
    ExamModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    ExamModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    ExamModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
  ];
  // 小班课程
  List<CourseModel> smallCourseList = [
    CourseModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    CourseModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    CourseModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
  ];
  // 院校资讯
  List<InfoModel> infoList = [
    InfoModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    InfoModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    InfoModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
  ];
  // 学长经验
  List<InfoModel> experienceList = [
    InfoModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    InfoModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    InfoModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
  ];
  // 讲义资料
  List<MaterialModel> materialList = [
    MaterialModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    MaterialModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    MaterialModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
  ];
  // 全科定制
  List<CourseModel> customizeList = [
    CourseModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    CourseModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    CourseModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
  ];  
  // 学长学姐
  List<SeniorModel> seniorList = [
    SeniorModel(id: 1, nickname: "牛大爷", college: "荷兰大学", major: "投资管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 2, nickname: "好二爷", college: "山西大学", major: "营养管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 3, nickname: "张三爷", college: "浙江大学", major: "吹牛皮不打草稿学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 4, nickname: "赵四爷", college: "山里屯大学", major: "心理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 5, nickname: "马五爷", college: "湖北大学", major: "游泳管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
  ];

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

  void setAnchorActive(AnchorModel anchor) {
    anchorList.forEach((element) {
      if (element != anchor) {
        element.active = false;
      } 
    });
    notifyListeners();
  }

  AnchorModel getAnchor(String name) {
    return anchorList.firstWhere((element) => element.name == name);
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
