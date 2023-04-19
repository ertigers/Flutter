class UserInfoModel {
  int id;
  int activityState;
  String avatar;
  int gender;
  int inviteNumber;
  String location;
  String username;
  bool locked;
  String nickname;
  int parentId;
  String parentTree;
  String role;
  String signature;
  int userType;
  String useremail;
  String userphone;
  String token;
  UserInfoModel(
      {this.id,
      this.activityState,
      this.avatar,
      this.gender,
      this.inviteNumber,
      this.location,
      this.userType,
      this.locked,
      this.parentId,
      this.parentTree,
      this.role,
      this.signature,
      this.useremail,
      this.username,
      this.userphone,
      this.nickname,
      this.token});

  UserInfoModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    activityState = json['activityState'];
    avatar = json['avatar'];
    gender = json['gender'];
    inviteNumber = json['inviteNumber'];
    nickname = json['nickname'];
    userType = json['userType'];
    locked = json['locked'];
    parentId = json['parentId'];
    parentTree = json['parentTree'];
    role = json['role'];
    signature = json['signature'];
    useremail = json['useremail'];
    username = json['username'];
    userphone = json['userphone'];
    userType = json['userType'];
    token = json['token'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['activityState'] = this.activityState;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['inviteNumber'] = this.inviteNumber;
    data['nickname'] = this.nickname;
    data['userType'] = this.userType;
    data['locked'] = this.locked;
    data['parentId'] = this.parentId;
    data['parentTree'] = this.parentTree;
    data['role'] = this.role;
    data['signature'] = this.signature;
    data['useremail'] = this.useremail;
    data['username'] = this.username;
    data['userphone'] = this.userphone;
    data['userType'] = this.userType;
    data['token'] = this.token;
    return data;
  }
}
