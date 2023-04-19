import 'package:boxApp/model/favorite_folder_model.dart';
import 'package:boxApp/model/mistake_folder_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class ExamUserModel with ChangeNotifier {

  bool loading = false;
  bool error = false;

  List<FavoriteFolderModel> favoriteFolderList = [];
  List<MistakeFolderModel> mistakeFolderList = [];

  void loadData() async {
    Future.wait([
      this.getFavoriteFolderList(refresh: false),
      this.getMistakeFolderList(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  // 用户错题本列表
  Future getMistakeFolderList({bool refresh = true, Function callback}) {
    return ApiService.request(ApiService.userExamMistakeFolder,
    method: 'get',
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.mistakeFolderList = responseList.map((model) => MistakeFolderModel.fromJson(model)).toList();
        callback?.call(this.mistakeFolderList);
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  // 用户收藏夹列表
  Future getFavoriteFolderList({bool refresh = true, Function callback}) {
    return ApiService.request(ApiService.userFavoriteFolderList,
    method: 'get',
      params: {'type': 1},
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.favoriteFolderList = responseList.map((model) => FavoriteFolderModel.fromJson(model)).toList();
        callback?.call(this.favoriteFolderList);
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  // 用户收藏夹创建
  Future favoriteFolderCreate({Map<String, dynamic> data, bool refresh = true, Function callback}) {
    return ApiService.request(ApiService.userFavoriteFolder,
      method: 'post',
      data: data,
      success: (result) {
        callback?.call(result);
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  // 用户收藏夹删除
  Future favoriteFolderDestroy({Map<String, dynamic> data, bool refresh = true, Function callback}) {
    return ApiService.request(ApiService.userFavoriteFolder,
      method: 'delete',
      data: data,
      success: (result) {
        callback?.call(result);
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
