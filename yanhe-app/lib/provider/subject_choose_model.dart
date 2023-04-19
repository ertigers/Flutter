import 'package:boxApp/model/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/api/api_service.dart';
import 'package:boxApp/util/toast_util.dart';

class SubjectChooseModel with ChangeNotifier {

  SubjectChooseModel({@required this.majorId, this.collegeCode});
  
  bool loading = false;
  bool error = false;

  List<SubjectModel> subjectList = [];

  int majorId;
  String collegeCode;

  void loadData() async {
    Future.wait([
      this.getSubjectList(refresh: false)
    ]).then((res) {
      loading = false;
      error = false;

    }).catchError((err) {
      loading = false;
      print(err);
      ToastUtils.showError(err.toString());

    }).whenComplete(() => notifyListeners());
  }

  Future getSubjectList({bool refresh = true}) {
    Map<String, dynamic> params = {'isPaging': 0, 'major_id': this.majorId};
    if (this.collegeCode != null) {
      params['college_code'] = this.collegeCode;
    }

    return ApiService.request(ApiService.majorSubjectList,
      params: params,
      success: (result) {
        List responseList = result['data']['list'] as List;
        this.subjectList = responseList.map((model) => SubjectModel.fromJson(model)).toList();
      },
      complete: () {
        if (refresh) {
          notifyListeners();
        }
      }
    );
  }

  void updateSubjectModel(SubjectModel subjectModel, {refresh = true}) {
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
