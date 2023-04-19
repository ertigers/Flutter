class MaterialModel {
  int id;
  String name;
  String cover;
  List<String> pictures;
  String description;
  String label;
  num price;
  int createTime;

  MaterialModel({
    this.id,
    this.name,
    this.cover,
    this.pictures,
    this.description,
    this.label,
    this.price,
    this.createTime
  });

  MaterialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    description = json['description'];
    label = json['label'];
    price = json['price'];
    createTime = json['create_time'];  

    if (json['pictures'] != null) {
      pictures = (json['pictures'] as List).map((item) => item as String).toList();
    }  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['pictures'] = this.pictures;
    data['description'] = this.description;
    data['label'] = this.label;
    data['price'] = this.price;
    data['create_time'] = this.createTime;
    
    return data;
  }
}