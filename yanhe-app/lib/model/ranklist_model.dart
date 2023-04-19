class RanklistModel {
  int sort;
  String nickname;
  String avatar;
  dynamic value;
  bool isMe;

  RanklistModel(
      {this.sort,
        this.nickname,
        this.avatar,
        this.value,
        this.isMe});

  RanklistModel.fromJson(Map<String, dynamic> json) {
    sort = json['sort'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    value = json['value'];
    isMe = json['isMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sort'] = this.sort;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['value'] = this.value;
    data['isMe'] = this.isMe;
    
    return data;
  }
}