class AddressModel {
  int id;
  String receiver;
  String mobile;
  String province;
  String city;
  String district;
  String area;
  String address;
  int isDefault;

  AddressModel({
    this.id,
    this.receiver,
    this.mobile,
    this.province,
    this.city,
    this.district,
    this.area,
    this.address,
    this.isDefault
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiver = json['receiver'];
    mobile = json['mobile'];
    province = json['province'];
    city = json['city'];
    district = json['district'];
    area = json['area'];
    address = json['address'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['receiver'] = this.receiver;
    data['mobile'] = this.mobile;
    data['province'] = this.province;
    data['city'] = this.city;
    data['district'] = this.district;
    data['area'] = this.area;
    data['address'] = this.address;
    data['is_default'] = this.isDefault;

    return data;
  }
}