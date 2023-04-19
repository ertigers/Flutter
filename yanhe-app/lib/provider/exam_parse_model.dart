import 'package:boxApp/model/exam_item_model.dart';
import 'package:boxApp/model/favorite_folder_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class ExamParsePageModel with ChangeNotifier {

  ExamParsePageModel({@required this.exerciseId});

  bool loading = true;
  bool error = false;

  int exerciseId;

  List<ExamItemModel> itemList = [];
  List<ExamItemModel> tiledItemList = [];
  List<FavoriteFolderModel> favoriteFolderList = [];
  int examItemLength = 0;
  int showExamIndex = 0;
  int showIndex = 0;
  int showSubIndex = 0;
  ExamItemModel showItemModel;

  void loadData({Function callback}) async {
    Future.wait([
      this.getPaperItemList(refresh: false),
      this.getFavoriteFolderList(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

      callback?.call();

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getPaperItemList({bool refresh = true}) {
    return ApiService.request(ApiService.paperItemList,
      method: 'get',
      params: {"exercise_id": this.exerciseId, "parse": 1},
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.itemList = responseList.map((model) => ExamItemModel.fromJson(model)).toList();
        // 题目数量计算
        this.computeItemLength();
        // 设置初始索引
        this.setShowItemModel(0);
        // 设置索引值
        this.setItemIndex();
        // 平铺列表
        this.setTiledItemList();
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

  // 创建收藏
  Future userFavoriteCreate({Map<String, dynamic> data, bool refresh = true, Function callback}) {
    return ApiService.request(ApiService.userFavorite,
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

    // 删除收藏
  Future userFavoriteDestroy({Map<String, dynamic> data, bool refresh = true, Function callback}) {
    return ApiService.request(ApiService.userFavorite,
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

  void computeItemLength() {
    var length = 0;
    this.itemList.forEach((item) {
      if (item.children != null) {
        length += item.children.length;
      } else {
        length++;
      }
    });
    this.examItemLength = length;
  }

  int computeItemIndex(int idx) {
    var num = 0;
    
    for (var i = 0; i < this.itemList.length; i++) {
      if (i == idx) { break; }
      var item = this.itemList[i];
      if (item.children != null) {
        num += item.children.length;
      } else {
        num++;
      }
    }
    return num;
  }

  void setTiledItemList() {
    List<ExamItemModel> list = [];
    this.itemList.forEach((item) {
      if (item.children != null) {
        item.children.forEach((sub) {
          sub.showSolveGuide = true;
          list.add(sub);
        });
      } else {
        item.showSolveGuide = true;
        list.add(item);
      }
    });
    this.tiledItemList = list;
  }

  void setMoveIndex({int showIndex = 0, int showSubIndex = 0, bool refresh = true}) {
    this.showIndex = showIndex ?? 0;
    this.showSubIndex = showSubIndex ?? 0;

    if (refresh) {
      notifyListeners();
    }
  }

  void setItemIndex() {
    for (var i = 0; i < this.itemList.length; i++) {
      var item = this.itemList[i];
      item.index = i;
      if (item.children != null) {
        for (var j = 0; j < item.children.length; j++) {
          var subItem = item.children[j];
          subItem.index = i;
          subItem.subIndex = j;
        }
      }
    }
  }

  void updateShowItemIndex(int index, {refresh = true}) {
    this.showExamIndex = index;
    setShowItemModel(index);

    if (refresh) {
      notifyListeners();
    }
  }

  void setShowItemModel(int idx) {
    var num = 0;
    for (var i = 0; i < this.itemList.length; i++) {
      var item = this.itemList[i];
      if (item.children != null) {
        for (var j = 0; j < item.children.length; j++) {
          if (num == idx) {
            this.showItemModel = item.children[j];
            return;
          }
          num++;
        }
      } else {
        if (num == idx) {
          this.showItemModel = item;
          return;
        }
        num++;
      }      
    }
  }

  void updateItemModel(ExamItemModel itemModel, {refresh = true}) {
    if (refresh) {
      notifyListeners();
    }
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
