class TeacherModel {
  int id;
  String name;
  String avatar;
  String description;
  String detail;
  String mobile;
  String label;
  num score;

  TeacherModel({
    this.id,
    this.name,
    this.avatar,
    this.description,
    this.detail,
    this.mobile,
    this.label,
    this.score
  });

  TeacherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    description = json['description'];
    detail = json['detail'];
    mobile = json['mobile'];
    label = json['label'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['description'] = this.description;
    data['detail'] = this.detail;
    data['mobile'] = this.mobile;
    data['label'] = this.label;
    data['score'] = this.score;
    
    return data;
  }
}