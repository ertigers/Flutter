import 'package:boxApp/model/authorize_model.dart';

class ExamModel {
  int id;
  String name;
  String cover;
  String description;
  int type;
  String detail;
  int trialCount;
  dynamic vipDiscountRate;
  num price;
  num itemCount;
  AuthorizeModel auth;
  bool authVipStatus;
  int createTime;
  int subjectId;

  ExamModel({
    this.id,
    this.name,
    this.cover,
    this.description,
    this.type,
    this.detail,
    this.trialCount,
    this.vipDiscountRate,
    this.price,
    this.itemCount,
    this.auth,
    this.authVipStatus,
    this.createTime
  });

  ExamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    description = json['description'];
    type = json['type'];
    detail = json['detail'];
    trialCount = json['trial_count'];
    vipDiscountRate = json['vip_discount_rate'];
    price = json['price'];
    itemCount = json['item_count'];
    authVipStatus = json['auth_vip_status'];
    createTime = json['create_time'];
    if (json['auth'] != null) {
      auth = AuthorizeModel.fromJson(json['auth']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['type'] = this.type;
    data['detail'] = this.detail;
    data['trial_count'] = this.trialCount;
    data['vip_discount_rate'] = this.vipDiscountRate;
    data['price'] = this.price;
    data['item_count'] = this.itemCount;
    data['auth_vip_status'] = this.authVipStatus;
    data['create_time'] = this.createTime;
    if (this.auth != null) {
      data['auth'] = this.auth.toJson();
    }

    return data;
  }
}