class UpdateProfileRequest {
  String fullName;
  String address;
  String gender;
  String birthdayStr;
  String email;
  String momoMobile;
  String momoName;
  UpdateProfileRequest(this.fullName, this.address, this.gender,
      this.birthdayStr, this.email, this.momoMobile, this.momoName);

  UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    address = json['Address'];
    gender = json['Gender'];
    birthdayStr = json['BirthdayStr'];
    email = json['Email'];
    momoMobile = json['MomoMobile'];
    momoName = json['MomoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FullName'] = this.fullName;
    data['Address'] = this.address;
    data['Gender'] = this.gender;
    data['BirthdayStr'] = this.birthdayStr;
    data['Email'] = this.email;
    data['MomoMobile'] = this.momoMobile;
    data['MomoName'] = this.momoName;
    return data;
  }
}
