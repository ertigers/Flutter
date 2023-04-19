class SubjectModel {
  int id;
  int categoryId;
  int type;
  String collegeCode;
  String code;
  String name;
  String description;
  int selected;

  SubjectModel({
    this.id,
    this.categoryId,
    this.type,
    this.collegeCode,
    this.code,
    this.name,
    this.description,
    this.selected
  });

  SubjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    type = json['type'];
    collegeCode = json['college_code'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['type'] = this.type;
    data['college_code'] = this.collegeCode;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['selected'] = this.selected;
    
    return data;
  }
}