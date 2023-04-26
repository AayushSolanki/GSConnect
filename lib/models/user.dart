import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? phone;
  String? photoUrl;
  String? passingyear;
  String? about;
  String? id;
  Timestamp? signedUpAt;
  Timestamp? lastSeen;
  bool? isOnline;

  UserModel(
      {this.username,
      this.phone,
      this.id,
      this.photoUrl,
      this.signedUpAt,
      this.isOnline,
      this.lastSeen,
      this.about,
      this.passingyear});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phone = json['phone'];
    passingyear = json['passingyear'];
    photoUrl = json['photoUrl'];
    signedUpAt = json['signedUpAt'];
    isOnline = json['isOnline'];
    lastSeen = json['lastSeen'];
    about = json['about'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['passingyear'] = this.passingyear;
    data['phone'] = this.phone;
    data['photoUrl'] = this.photoUrl;
    data['about'] = this.about;
    data['signedUpAt'] = this.signedUpAt;
    data['isOnline'] = this.isOnline;
    data['lastSeen'] = this.lastSeen;
    data['id'] = this.id;

    return data;
  }
}
