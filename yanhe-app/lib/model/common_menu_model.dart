class CommonMenuModel {
  int id;
  String title;
  String subtitle;
  String iconUrl;
  Function onTap;

  CommonMenuModel({this.id, this.title, this.subtitle, this.iconUrl, this.onTap});

  CommonMenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    iconUrl = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['iconUrl'] = this.iconUrl;
    return data;
  }
}