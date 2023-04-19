class CourseModel {
  int id;
  String name;
  String cover;
  String description;
  String detail;
  int hours;
  String label;
  num price;
  int type;
  num userCount;
  int expireTime;
  int createTime;

  CourseModel({
    this.id,
    this.name,
    this.cover,
    this.description,
    this.detail,
    this.hours,
    this.label,
    this.price,
    this.type,
    this.userCount,
    this.expireTime,
    this.createTime
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    description = json['description'];
    detail = json['detail'];
    hours = json['hours'];
    label = json['label'];
    price = json['price'];
    type = json['type'];
    userCount = json['user_count'];
    expireTime = json['expire_time'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['detail'] = this.detail;
    data['hours'] = this.hours;
    data['label'] = this.label;
    data['price'] = this.price;
    data['type'] = this.type;
    data['user_count'] = this.userCount;
    data['expire_time'] = this.expireTime;
    data['create_time'] = this.createTime;

    return data;
  }
}