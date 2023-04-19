class MistakeFolderModel {
  int id;
  int uid;
  String name;
  int subjectId;
  int itemCount;

  MistakeFolderModel({
    this.id,
    this.uid,
    this.name,
    this.subjectId,
    this.itemCount
  });

  MistakeFolderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    subjectId = json['subject_id'];
    itemCount = json['item_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['subject_id'] = this.subjectId;
    data['item_count'] = this.itemCount;
    
    return data;
  }
}