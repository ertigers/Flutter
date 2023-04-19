import 'package:flutter/material.dart';

class SettingItemModel {
  int id;
  String title;
  String subtitle;
  String iconUrl;
  String hint;
  dynamic value;
  Widget child;
  Function onTap;

  SettingItemModel({
    this.id, 
    this.title, 
    this.subtitle, 
    this.iconUrl, 
    this.hint, 
    this.value, 
    this.child, 
    this.onTap
  });

  SettingItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    iconUrl = json['iconUrl'];
    hint = json['hint'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['iconUrl'] = this.iconUrl;
    data['hint'] = this.hint;
    data['value'] = this.value;

    return data;
  }
}