class ExamSimulateModel {
  int id;
  String name;
  String cover;
  String description;
  int type;
  String detail;
  int createTime;

  ExamSimulateModel(
      {this.id,
        this.name,
        this.cover,
        this.description,
        this.type,
        this.detail,
        this.createTime});

  ExamSimulateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    description = json['description'];
    type = json['type'];
    detail = json['detail'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['type'] = this.type;
    data['detail'] = this.detail;
    data['create_time'] = this.createTime;
    return data;
  }
}