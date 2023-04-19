import 'package:boxApp/model/senior_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class SeniorListModel with ChangeNotifier {

  SeniorListModel();
  
  bool loading = false;
  bool error = false;

  List<SeniorModel> seniorList = [
    SeniorModel(id: 1, nickname: "牛大爷", college: "荷兰大学", major: "投资管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 2, nickname: "好二爷", college: "山西大学", major: "营养管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 3, nickname: "张三爷", college: "浙江大学", major: "吹牛皮不打草稿学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 4, nickname: "赵四爷", college: "山里屯大学", major: "心理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 5, nickname: "马五爷", college: "湖北大学", major: "游泳管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 1, nickname: "牛大爷", college: "荷兰大学", major: "投资管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 2, nickname: "好二爷", college: "山西大学", major: "营养管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 3, nickname: "张三爷", college: "浙江大学", major: "吹牛皮不打草稿学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 4, nickname: "赵四爷", college: "山里屯大学", major: "心理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 5, nickname: "马五爷", college: "湖北大学", major: "游泳管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 1, nickname: "牛大爷", college: "荷兰大学", major: "投资管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 2, nickname: "好二爷", college: "山西大学", major: "营养管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 3, nickname: "张三爷", college: "浙江大学", major: "吹牛皮不打草稿学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 4, nickname: "赵四爷", college: "山里屯大学", major: "心理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
    SeniorModel(id: 5, nickname: "马五爷", college: "湖北大学", major: "游泳管理学", label: "学长经验,讲义资料,专业题库,一对一", avatar: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png"),
  ];

  void loadData() async {
    // Future.wait([
    //   this.getSeniorList(refresh: false)
    // ]).then((res) {
    //   loading = false;
    //   error = false;

    // }).catchError((err) {
    //   loading = false;
    //   print(err);
    //   ToastUtils.showError(err.toString());

    // }).whenComplete(() => notifyListeners());
  }

  Future getSeniorList({bool refresh = true}) {
    // Map<String, dynamic> params = {};
    // return ApiService.request(ApiService.seniorList,
    //   params: params,
    //   success: (result) {
    //     List responseList = result['data']['list'] as List;
    //     this.seniorList = responseList.map((model) => MaterialModel.fromJson(model)).toList();
    //   },
    //   complete: () {
    //     if (refresh) {
    //       notifyListeners();
    //     }
    //   }
    // );
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
