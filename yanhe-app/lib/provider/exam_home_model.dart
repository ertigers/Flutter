import 'package:boxApp/model/consult_model.dart';
import 'package:boxApp/model/exam_model.dart';
import 'package:boxApp/model/subject_model.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class ExamHomeModel with ChangeNotifier {

  bool loading = false;
  bool error = false;

  List<SubjectModel> userSubjectList = [];

  List<ConsultModel> userConsultList = [];

  List<ExamModel> recentExamList = [];

  void loadData() async {
    // final token = AppManager.prefs.getString('token');
    // // 未登录
    // if (token == null) {return;}
    
    Future.wait([
      this.getUserSubjectList(refresh: false),
      this.getUserConsultList(refresh: false),
      this.getUserExamRecent(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getUserSubjectList({bool refresh = true}) {
    return ApiService.request(ApiService.userSubjectList,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.userSubjectList = responseList.map((model) => SubjectModel.fromJson(model)).toList();
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future getUserConsultList({bool refresh = true}) {
    return ApiService.request(ApiService.userConsultList,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.userConsultList = responseList.map((model) => ConsultModel.fromJson(model)).toList();
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  Future getUserExamRecent({bool refresh = true}) {
    return ApiService.request(ApiService.userExamRecent,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.recentExamList = responseList.map((model) => ExamModel.fromJson(model)).toList();
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
