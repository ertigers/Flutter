class InfoModel {
  int id;
  String name;
  String cover;
  String description;
  String label;
  int createTime;

  InfoModel({
    this.id,
    this.name,
    this.cover,
    this.description,
    this.label,
    this.createTime
  });

  InfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    description = json['description'];
    label = json['label'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['label'] = this.label;
    data['create_time'] = this.createTime;
    return data;
  }
}