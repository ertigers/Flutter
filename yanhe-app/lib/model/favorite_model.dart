class FavoriteModel {
  int id;
  int uid;
  int refId;
  int refType;
  dynamic folderId;
  String name;
  int status;

  FavoriteModel({
    this.id,
    this.uid,
    this.refId,
    this.refType,
    this.folderId,
    this.name,
    this.status
  });

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    refId = json['ref_id'];
    refType = json['ref_type'];
    folderId = json['folder_id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['uid'] = this.uid;
    data['ref_id'] = this.refId;
    data['ref_type'] = this.refType;
    data['folder_id'] = this.folderId;
    data['name'] = this.name;
    data['status'] = this.status;
    
    return data;
  }
}