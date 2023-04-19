class CollegeModel {
  int id;
  String name;
  String code;
  String provinceCode;
  String provinceName;

  CollegeModel({
    this.id,
    this.name,
    this.code,
    this.provinceCode
  });

  CollegeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    provinceCode = json['province_code'];
    provinceName = json['province_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['province_code'] = this.provinceCode;
    data['province_name'] = this.provinceName;

    return data;
  }
}