import 'package:cloud_firestore/cloud_firestore.dart';

class bannerModel {
  String? id;
  String? mediaUrl;

  bannerModel({this.id, this.mediaUrl});


   bannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    mediaUrl = json['mediaUrl'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['mediaUrl'] = this.mediaUrl;

    return data;
  }

  


}
