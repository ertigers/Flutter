import 'package:boxApp/model/info_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class InfoListModel with ChangeNotifier {

  InfoListModel();
  
  bool loading = false;
  bool error = false;

  List<InfoModel> infoList = [
    InfoModel(id: 1, name: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
    InfoModel(id: 2, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "高分英语"),
    InfoModel(id: 3, name: "在线讲解高频历史考点", description: "在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点在线讲解高频历史考点", cover: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png", label: "历史文学"),
  ];

  void loadData() async {
    // Future.wait([
    //   this.getInfoList(refresh: false)
    // ]).then((res) {
    //   loading = false;
    //   error = false;

    // }).catchError((err) {
    //   loading = false;
    //   print(err);
    //   ToastUtils.showError(err.toString());

    // }).whenComplete(() => notifyListeners());
  }

  Future getInfoList({bool refresh = true}) {
    Map<String, dynamic> params = {};
    return ApiService.request(ApiService.materialList,
      params: params,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.infoList = responseList.map((model) => InfoModel.fromJson(model)).toList();
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
