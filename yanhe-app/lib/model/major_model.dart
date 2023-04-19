import 'package:boxApp/model/subject_model.dart';

class MajorModel {
  int id;
  String name;
  String code;
  int majorId;
  String directionCode;
  String directionName;
  String categoryName;
  int learn;
  List<SubjectModel> subjects;

  MajorModel({this.id,
    this.name,
    this.code,
    this.directionCode,
    this.directionName,
    this.categoryName,
    this.learn,
    this.subjects
  });

  MajorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    directionCode = json['direction_code'];
    directionName = json['direction_name'];
    categoryName = json['category_name'];
    learn = json['learn'];

    if (json['subjects'] != null) {
      subjects = (json['subjects'] as List).map((item) => SubjectModel.fromJson(item)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['direction_code'] = this.directionCode;
    data['direction_name'] = this.directionName;
    data['category_name'] = this.categoryName;
    data['learn'] = this.learn;

    if (this.subjects != null) {
      data['subjects'] = this.subjects.map((item) => item.toJson()).toList();
    } else {
      data['subjects'] = this.subjects;
    }

    return data;
  }
}