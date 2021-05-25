class InfoUser {
  String fullName;
  // Null phone;
  String mobile;
  String address;
  String gender;
  String facebookAccount;
  // Null website;
  String birthday;
  String birthdayStr;
  String province;
  String provinceName;
  String districtName;
  String communeName;
  String country;
  String workingPlace;
  String avatarUrl;
  // Null signature;
  // Null activateKey;
  // Null activateId;
  // Null resetPasswordKey;
  String avatarImage;
  String avatarImageId;
  String email;
  // Null currentDepartment;
  String provinceId;

  String provinceIdStr;
  String districtId;
  String communeId;
  String districtIdStr;
  String identifyNo;
  String employeeCode;
  String employeeId;
  String positionId;
  String structDepId;
  String insuranceNo;
  String employeeIdStr;
  String positionIdStr;
  String structDepIdStr;
  String communeIdStr;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;
  String positionName;
  String structDepName;

  InfoUser(
      {this.fullName,
        // this.phone,
        this.mobile,
        this.address,
        this.gender,
        this.facebookAccount,
        // this.website,
        this.birthday,
        this.birthdayStr,
        this.province,
        this.provinceName,
        this.districtName,
        this.communeName,
        this.country,
        this.workingPlace,
        this.avatarUrl,
        // this.signature,
        // this.activateKey,
        // this.activateId,
        // this.resetPasswordKey,
        this.avatarImage,
        this.avatarImageId,
        this.email,
        // this.currentDepartment,
        this.provinceId,
        this.provinceIdStr,
        this.districtId,
        this.communeId,
        this.districtIdStr,
        this.identifyNo,
        this.employeeCode,
        this.employeeId,
        this.positionId,
        this.structDepId,
        this.insuranceNo,
        this.employeeIdStr,
        this.positionIdStr,
        this.structDepIdStr,
        this.communeIdStr,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr,
        this.positionName,
        this.structDepName
      });

  InfoUser.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    // phone = json['Phone'];
    mobile = json['Mobile'];
    address = json['Address'];
    gender = json['Gender'];
    facebookAccount = json['FacebookAccount'];
    // website = json['Website'];
    birthday = json['Birthday'];
    birthdayStr = json['BirthdayStr'];
    province = json['Province'];
    provinceName = json['ProvinceName'];
    districtName = json['DistrictName'];
    communeName = json['CommuneName'];
    country = json['Country'];
    workingPlace = json['WorkingPlace'];
    avatarUrl = json['AvatarUrl'];
    // signature = json['Signature'];
    // activateKey = json['ActivateKey'];
    // activateId = json['ActivateId'];
    // resetPasswordKey = json['ResetPasswordKey'];
    avatarImage = json['AvatarImage'];
    avatarImageId = json['AvatarImageId'];
    email = json['Email'];
    // currentDepartment = json['CurrentDepartment'];
    provinceId = json['ProvinceId'];
    provinceIdStr = json['ProvinceIdStr'];
    districtId = json['DistrictId'];
    communeId = json['CommuneId'];
    districtIdStr = json['DistrictIdStr'];
    identifyNo = json['IdentifyNo'];
    employeeCode = json['EmployeeCode'];
    employeeId = json['EmployeeId'];
    positionId = json['PositionId'];
    structDepId = json['StructDepId'];
    insuranceNo = json['InsuranceNo'];
    employeeIdStr = json['EmployeeIdStr'];
    positionIdStr = json['PositionIdStr'];
    structDepIdStr = json['StructDepIdStr'];
    communeIdStr = json['CommuneIdStr'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
    positionName = json['PositionName'];
    structDepName = json['StructDepName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FullName'] = this.fullName;
    // data['Phone'] = this.phone;
    data['Mobile'] = this.mobile;
    data['Address'] = this.address;
    data['Gender'] = this.gender;
    data['FacebookAccount'] = this.facebookAccount;
    // data['Website'] = this.website;
    data['Birthday'] = this.birthday;
    data['BirthdayStr'] = this.birthdayStr;
    data['Province'] = this.province;
    data['CommuneName'] = this.communeName;
    data['ProvinceName'] = this.provinceName;
    data['DistrictName'] = this.districtName;
    data['Country'] = this.country;
    data['WorkingPlace'] = this.workingPlace;
    data['AvatarUrl'] = this.avatarUrl;
    // data['Signature'] = this.signature;
    // data['ActivateKey'] = this.activateKey;
    // data['ActivateId'] = this.activateId;
    // data['ResetPasswordKey'] = this.resetPasswordKey;
    data['AvatarImage'] = this.avatarImage;
    data['AvatarImageId'] = this.avatarImageId;
    data['Email'] = this.email;
    // data['CurrentDepartment'] = this.currentDepartment;
    data['ProvinceId'] = this.provinceId;
    data['ProvinceIdStr'] = this.provinceIdStr;
    data['DistrictId'] = this.districtId;
    data['CommuneId'] = this.communeId;
    data['DistrictIdStr'] = this.districtIdStr;
    data['IdentifyNo'] = this.identifyNo;
    data['EmployeeCode'] = this.employeeCode;
    data['EmployeeId'] = this.employeeId;
    data['PositionId'] = this.positionId;
    data['StructDepId'] = this.structDepId;
    data['InsuranceNo'] = this.insuranceNo;
    data['EmployeeIdStr'] = this.employeeIdStr;
    data['PositionIdStr'] = this.positionIdStr;
    data['StructDepIdStr'] = this.structDepIdStr;
    data['CommuneIdStr'] = this.communeIdStr;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    data['PositionName'] = this.positionName;
    data['StructDepName'] = this.structDepName;
    return data;
  }
}