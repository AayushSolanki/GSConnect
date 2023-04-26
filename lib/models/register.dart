
class Register {
  String? username;
  String? phone;
  String? gender;
  String? passingyear;
  String? about;
  bool publicphone = false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.username;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['about'] = this.about;
    data['public_phone'] = this.publicphone;
    data['phone'] = this.phone;
    return data;
  }
}
