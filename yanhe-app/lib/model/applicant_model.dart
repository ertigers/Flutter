import 'package:boxApp/model/college_model.dart';
import 'package:boxApp/model/major_model.dart';

class ApplicantModel {
  int id;
  String applyAcademyCode;
  String applyCollegeCode;
  CollegeModel college;
  String applyMajorCode;
  int applyMajorId;
  MajorModel major;
  String applyDirection;
  String applyYear;
  int applyCount;
  int uid;

  ApplicantModel({this.id,
    this.applyAcademyCode,
    this.applyCollegeCode,
    this.college,
    this.applyMajorCode,
    this.applyMajorId,
    this.major,
    this.applyDirection,
    this.applyYear,
    this.applyCount,
    this.uid
  });

  ApplicantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applyAcademyCode = json['apply_academy_code'];
    applyCollegeCode = json['apply_college_code'];
    applyMajorCode = json['apply_major_code'];
    applyMajorId = json['apply_major_id'];
    applyYear = json['apply_year'];
    applyCount = json['apply_count'];
    uid = json['uid'];

    if (json['college'] != null) {
      college = CollegeModel.fromJson(json['college']);
    }
    if (json['major'] != null) {
      major = MajorModel.fromJson(json['major']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['apply_academy_code'] = this.applyAcademyCode;
    data['apply_college_code'] = this.applyCollegeCode;
    data['apply_major_code'] = this.applyMajorCode;
    data['apply_major_id'] = this.applyMajorId;
    data['apply_year'] = this.applyYear;
    data['apply_count'] = this.applyCount;
    data['uid'] = this.uid;
    
    if (this.college != null) {
      data['college'] = this.college.toJson();
    }
    if (this.major != null) {
      data['major'] = this.major.toJson();
    }

    return data;
  }
}