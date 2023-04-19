class AuthorizeModel {
  int id;
  int authType;
  String authCode;
  dynamic expireTime;
  int trialCount;
  int status;
  bool authorized;

  AuthorizeModel({
    this.id,
    this.authType,
    this.authCode,
    this.expireTime,
    this.trialCount,
    this.status,
    this.authorized
  });

  AuthorizeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authType = json['auth_type'];
    authCode = json['auth_code'];
    expireTime = json['expire_time'];
    trialCount = json['trial_count'];
    status = json['status'];
    authorized = json['authorized'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['auth_type'] = this.authType;
    data['auth_code'] = this.authCode;
    data['expire_time'] = this.expireTime;
    data['trial_count'] = this.trialCount;
    data['status'] = this.status;
    data['authorized'] = this.authorized;

    return data;
  }
}