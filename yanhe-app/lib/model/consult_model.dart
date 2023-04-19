class ConsultModel {
  int id;
  int categoryId;
  String name;
  String description;

  ConsultModel({this.id,
    this.categoryId,
    this.name,
    this.description
  });

  ConsultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    
    return data;
  }
}