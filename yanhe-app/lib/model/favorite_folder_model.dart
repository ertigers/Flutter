class FavoriteFolderModel {
  int id;
  int uid;
  String name;
  int type;
  int status;
  int itemCount;

  FavoriteFolderModel({
    this.id,
    this.uid,
    this.name,
    this.type,
    this.status,
    this.itemCount
  });

  FavoriteFolderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
    itemCount = json['item_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['type'] = this.type;
    data['status'] = this.status;
    data['item_count'] = this.itemCount;
    
    return data;
  }
}