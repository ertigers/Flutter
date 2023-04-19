import 'package:boxApp/model/common_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class SubjectPageModel with ChangeNotifier {

  SubjectPageModel(this.subjectId);
  
  bool loading = false;
  bool error = false;

  int subjectId;

  Map<String, dynamic> counts;

  List<CommonMenuModel> menuList = [
    CommonMenuModel(id: 1, title: '挑战刷题', subtitle: '业精于勤而荒于嬉，行成于思，毁于随。', iconUrl: 'assets/images/bg_exam_challenge.png'),
    CommonMenuModel(id: 2, title: '考点刷题', subtitle: '业精于勤而荒于嬉，行成于思，毁于随。', iconUrl: 'assets/images/bg_exam_point.png'),
    CommonMenuModel(id: 3, title: '历年真题', subtitle: '业精于勤而荒于嬉，行成于思，毁于随。', iconUrl: 'assets/images/bg_exam_really.png'),
    CommonMenuModel(id: 4, title: '书籍题库', subtitle: '业精于勤而荒于嬉，行成于思，毁于随。', iconUrl: 'assets/images/bg_exam_book.png'),
  ];

  void loadData() async {
    Future.wait([
      this.getSubjectCounts(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getSubjectCounts({bool refresh = true}) {
    return ApiService.request(ApiService.userSubjectCounts,
      method: 'get',
      params: {"subject_id": this.subjectId},
      success: (result) {
        this.counts = result['data'];
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
