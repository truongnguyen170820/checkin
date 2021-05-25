class UserProfileModel {
  String idStr;
  String userName;
  String fullName;
  String address;
  String gender;
  String birthdayStr;
  String avatarUrl;
  String email;
  String mobile;
  String momoMobile;
  String momoName;

  UserProfileModel(
      {this.idStr,
      this.userName,
      this.fullName,
      this.address,
      this.gender,
      this.birthdayStr,
      this.avatarUrl,
      this.email,
      this.mobile,
      this.momoMobile,
      this.momoName});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    idStr = json['IdStr'];
    userName = json['UserName'];
    fullName = json['FullName'];
    address = json['Address'];
    gender = json['Gender'];
    birthdayStr = json['BirthdayStr'];
    avatarUrl = json['AvatarUrl'];
    email = json['Email'];
    mobile = json['Mobile'];
    momoMobile = json['MomoMobile'];
    momoName = json['MomoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdStr'] = this.idStr;
    data['UserName'] = this.userName;
    data['FullName'] = this.fullName;
    data['Address'] = this.address;
    data['Gender'] = this.gender;
    data['BirthdayStr'] = this.birthdayStr;
    data['AvatarUrl'] = this.avatarUrl;
    data['Email'] = this.email;
    data['Mobile'] = this.mobile;
    data['MomoMobile'] = this.momoMobile;
    data['MomoName'] = this.momoName;
    return data;
  }
}
