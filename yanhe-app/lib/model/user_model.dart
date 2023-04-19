class UserModel {
  int id;
  String avatar;
  int gender;
  String username;
  String nickname;
  int role;
  String signature;
  String email;
  String mobile;
  String token;
  UserModel(
      {this.id,
      this.avatar,
      this.gender,
      this.username,
      this.nickname,
      this.role,
      this.signature,
      this.email,
      this.mobile,
      this.token});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    gender = json['gender'];
    username = json['username'];
    nickname = json['nickname'];
    role = json['role'];
    signature = json['signature'];
    email = json['email'];
    mobile = json['mobile'];
    token = json['token'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['role'] = this.role;
    data['signature'] = this.signature;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['token'] = this.token;

    return data;
  }
}
