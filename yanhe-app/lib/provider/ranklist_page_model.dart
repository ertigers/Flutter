import 'package:boxApp/model/ranklist_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class RanklistPageModel with ChangeNotifier {
  List<RanklistModel> list = [
    RanklistModel(sort: 1, nickname: "肆叶", value: 100, avatar: 'https://www.koudaikaoyan.com/_nuxt/img/logo.4bdf098.png'),
    RanklistModel(sort: 1, nickname: "肆叶", value: 100, avatar: 'https://www.koudaikaoyan.com/_nuxt/img/logo.4bdf098.png'),
    RanklistModel(sort: 1, nickname: "肆叶", value: 100, avatar: 'https://www.koudaikaoyan.com/_nuxt/img/logo.4bdf098.png'),
    RanklistModel(sort: 1, nickname: "肆叶", value: 100, avatar: 'https://www.koudaikaoyan.com/_nuxt/img/logo.4bdf098.png'),
    RanklistModel(sort: 1, nickname: "肆叶", value: 100, avatar: 'https://www.koudaikaoyan.com/_nuxt/img/logo.4bdf098.png'),
    RanklistModel(sort: 1, nickname: "肆叶", value: 100, avatar: 'https://www.koudaikaoyan.com/_nuxt/img/logo.4bdf098.png'),
    RanklistModel(sort: 1, nickname: "肆叶", value: 100, avatar: 'https://www.koudaikaoyan.com/_nuxt/img/logo.4bdf098.png'),
    RanklistModel(sort: 1, nickname: "肆叶", value: 100, avatar: 'https://www.koudaikaoyan.com/_nuxt/img/logo.4bdf098.png'),
    RanklistModel(sort: 1, nickname: "肆叶", value: 100, avatar: 'https://www.koudaikaoyan.com/_nuxt/img/logo.4bdf098.png'),
    RanklistModel(sort: 1, nickname: "肆叶", value: 100, avatar: 'https://www.koudaikaoyan.com/_nuxt/img/logo.4bdf098.png'),
  ];
  bool loading = false;
  bool error = false;

  void loadData() async {
    ApiService.request(ApiService.static_domain,
        success: (result) {
          // List responseList = result as List;
          // List<ExampleModel> categoryList = responseList
          //     .map((model) => ExampleModel.fromJson(model))
          //     .toList();
          // this.list = categoryList;
          // loading = false;
          // error = false;
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
