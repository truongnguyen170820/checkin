class LoginModel {
  String sessionId;
  // Null userType;
  // Null userStatus;
  String userName;
  String iD;
  String domainName;
  UserInfo userInfo;
  String domainId;
  String domainIdStr;
  String domainLogo;
  String companyName;
  String companyHotLine;

  LoginModel(
      {this.sessionId,
      // this.userType,
      // this.userStatus,
      this.userName,
      this.iD,
      this.domainName,
      this.userInfo,
      this.domainId,
      this.domainIdStr,
      this.domainLogo,
      this.companyName,
      this.companyHotLine});

  LoginModel.fromJson(Map<String, dynamic> json) {
    sessionId = json['SessionId'];
    // userType = json['UserType'];
    // userStatus = json['UserStatus'];
    userName = json['UserName'];
    iD = json['ID'];
    domainName = json['DomainName'];
    userInfo = json['UserInfo'] != null
        ? new UserInfo.fromJson(json['UserInfo'])
        : null;
    domainId = json['DomainId'];
    domainIdStr = json['DomainIdStr'];
    domainLogo = json['DomainLogo'];
    companyName = json['CompanyName'];
    companyHotLine = json['CompanyHotLine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SessionId'] = this.sessionId;
    // data['UserType'] = this.userType;
    // data['UserStatus'] = this.userStatus;
    data['UserName'] = this.userName;
    data['ID'] = this.iD;
    data['DomainName'] = this.domainName;
    if (this.userInfo != null) {
      data['UserInfo'] = this.userInfo.toJson();
    }
    data['DomainId'] = this.domainId;
    data['DomainIdStr'] = this.domainIdStr;
    data['DomainLogo'] = this.domainLogo;
    data['CompanyName'] = this.companyName;
    data['CompanyHotLine'] = this.companyHotLine;
    return data;
  }
}

class UserInfo {
  String userName;
  String pwd;
  // Null userStatus;
  bool isLock;
  bool isDeleted;
  String salt;
  String email;
  String mobile;
  String fullName;
  String creationDate;
  String lastLognumime;
  num noOfWrongPwd;
  // Null lastActivityDate;
  // Null passwordQuestion;
  // Null passwordAnswer;
  bool isApproved;
  bool isManager;
  // Null lastPasswordChangedDate;
  // Null lastLockoutDate;
  // Null comment;
  // Null userType;
  // Null roles;
  Profile profile;
  String provinceName;
  String districtName;
  String communeName;
  String employeeCode;
  // Null domainRoles;
  // Null currentDepartment;
  // Null homeDepartment;
  // Null menu;
  String employeeId;
  String employeeIdStr;
  // Null employeeInfo;
  num remainNotify;
  // Null domainRolesId;
  bool allowCheckinAllDep;
  // Null lastResetPwd;
  // Null machineIdList;
  // Null machineIdStrList;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  UserInfo(
      {this.userName,
      this.pwd,
      // this.userStatus,
      this.isLock,
      this.isDeleted,
      this.salt,
      this.email,
      this.mobile,
      this.fullName,
      this.creationDate,
      this.lastLognumime,
      this.noOfWrongPwd,
      // this.lastActivityDate,
      // this.passwordQuestion,
      // this.passwordAnswer,
      this.isApproved,
        this.isManager,
      // this.lastPasswordChangedDate,
      // this.lastLockoutDate,
      // this.comment,
      // this.userType,
      // this.roles,
      this.profile,
      this.communeName,
      this.districtName,
      this.provinceName,
      this.employeeCode,
      // this.domainRoles,
      // this.currentDepartment,
      // this.homeDepartment,
      // this.menu,
      this.employeeId,
      this.employeeIdStr,
      // this.employeeInfo,
      this.remainNotify,
      // this.domainRolesId,
      this.allowCheckinAllDep,
      // this.lastResetPwd,
      // this.machineIdList,
      // this.machineIdStrList,
      this.sId,
      this.domainId,
      this.idStr,
      this.domainIdStr});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    pwd = json['Pwd'];
    // userStatus = json['UserStatus'];
    isLock = json['IsLock'];
    isDeleted = json['IsDeleted'];
    salt = json['Salt'];
    email = json['Email'];
    mobile = json['Mobile'];
    fullName = json['FullName'];
    creationDate = json['CreationDate'];
    lastLognumime = json['LastLognumime'];
    noOfWrongPwd = json['NoOfWrongPwd'];
    // lastActivityDate = json['LastActivityDate'];
    // passwordQuestion = json['PasswordQuestion'];
    // passwordAnswer = json['PasswordAnswer'];
    isApproved = json['IsApproved'];
    isManager = json['IsManager'];
    // lastPasswordChangedDate = json['LastPasswordChangedDate'];
    // lastLockoutDate = json['LastLockoutDate'];
    // comment = json['Comment'];
    // userType = json['UserType'];
    // roles = json['Roles'];
    profile =
        json['Profile'] != null ? new Profile.fromJson(json['Profile']) : null;
    provinceName = json['ProvinceName'];
    districtName = json['DistrictName'];
    communeName = json['CommuneName'];
    employeeCode = json['EmployeeCode'];
    // domainRoles = json['DomainRoles'];
    // currentDepartment = json['CurrentDepartment'];
    // homeDepartment = json['HomeDepartment'];
    // menu = json['Menu'];
    employeeId = json['EmployeeId'];
    employeeIdStr = json['EmployeeIdStr'];
    // employeeInfo = json['EmployeeInfo'];
    remainNotify = json['RemainNotify'];
    // domainRolesId = json['DomainRolesId'];
    allowCheckinAllDep = json['AllowCheckinAllDep'];
    // lastResetPwd = json['LastResetPwd'];
    // machineIdList = json['MachineIdList'];
    // machineIdStrList = json['MachineIdStrList'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['Pwd'] = this.pwd;
    // data['UserStatus'] = this.userStatus;
    data['IsLock'] = this.isLock;
    data['IsDeleted'] = this.isDeleted;
    data['Salt'] = this.salt;
    data['Email'] = this.email;
    data['Mobile'] = this.mobile;
    data['FullName'] = this.fullName;
    data['CreationDate'] = this.creationDate;
    data['LastLognumime'] = this.lastLognumime;
    data['NoOfWrongPwd'] = this.noOfWrongPwd;
    // data['LastActivityDate'] = this.lastActivityDate;
    // data['PasswordQuestion'] = this.passwordQuestion;
    // data['PasswordAnswer'] = this.passwordAnswer;
    data['IsApproved'] = this.isApproved;
    data['IsManager'] = this.isManager;
    // data['LastPasswordChangedDate'] = this.lastPasswordChangedDate;
    // data['LastLockoutDate'] = this.lastLockoutDate;
    // data['Comment'] = this.comment;
    // data['UserType'] = this.userType;
    // data['Roles'] = this.roles;
    if (this.profile != null) {
      data['Profile'] = this.profile.toJson();
    }
    data['ProvinceName'] = this.provinceName;
    data['DistrictName'] = this.districtName;
    data['CommuneName'] = this.communeName;
    data['EmployeeCode'] = this.employeeCode;
    // data['DomainRoles'] = this.domainRoles;
    // data['CurrentDepartment'] = this.currentDepartment;
    // data['HomeDepartment'] = this.homeDepartment;
    // data['Menu'] = this.menu;
    data['EmployeeId'] = this.employeeId;
    data['EmployeeIdStr'] = this.employeeIdStr;
    // data['EmployeeInfo'] = this.employeeInfo;
    data['RemainNotify'] = this.remainNotify;
    // data['DomainRolesId'] = this.domainRolesId;
    data['AllowCheckinAllDep'] = this.allowCheckinAllDep;
    // data['LastResetPwd'] = this.lastResetPwd;
    // data['MachineIdList'] = this.machineIdList;
    // data['MachineIdStrList'] = this.machineIdStrList;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}

class Profile {
  String fullName;
  String phone;
  String mobile;
  String address;
  String gender;
  String facebookAccount;
  String website;
  String birthday;
  String birthdayStr;
  String province;
  String country;
  String workingPlace;
  String avatarUrl;
  String signature;
  String activateKey;
  String activateId;
  String resetPasswordKey;
  String avatarImage;
  String avatarImageId;
  String email;
  // Null currentDepartment;
  String provinceId;
  String provinceIdStr;

  String districtId;
  String districtIdStr;
  String provinceName;
  String districtName;
  String communeName;
  String communeId;
  String communeIdStr;

  String employeeIdStr;
  String identifyNo;
  String employeeCode;
  String employeeId;
  String positionId;
  String structDepId;
  String insuranceNo;

  String positionIdStr;
  String structDepIdStr;

  String sId;
  String domainId;
  String idStr;
  String domainIdStr;
  String positionName;
  String structDepName;

  Profile(
      {this.fullName,
      this.phone,
      this.mobile,
      this.address,
      this.gender,
      this.facebookAccount,
      this.website,
      this.birthday,
      this.birthdayStr,
      this.province,
      this.country,
      this.workingPlace,
      this.avatarUrl,
      this.signature,
      this.activateKey,
      this.activateId,
      this.resetPasswordKey,
      this.avatarImage,
      this.avatarImageId,
      this.email,
      // this.currentDepartment,
      this.provinceId,
      this.provinceIdStr,
      this.provinceName,
      this.districtName,
      this.communeName,
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

  Profile.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    phone = json['Phone'];
    mobile = json['Mobile'];
    address = json['Address'];
    gender = json['Gender'];
    facebookAccount = json['FacebookAccount'];
    website = json['Website'];
    birthday = json['Birthday'];
    birthdayStr = json['BirthdayStr'];
    province = json['Province'];
    country = json['Country'];
    workingPlace = json['WorkingPlace'];
    avatarUrl = json['AvatarUrl'];
    signature = json['Signature'];
    activateKey = json['ActivateKey'];
    activateId = json['ActivateId'];
    resetPasswordKey = json['ResetPasswordKey'];
    avatarImage = json['AvatarImage'];
    avatarImageId = json['AvatarImageId'];
    email = json['Email'];
    // currentDepartment = json['CurrentDepartment'];
    provinceId = json['ProvinceId'];
    provinceIdStr = json['ProvinceIdStr'];
    districtId = json['DistrictId'];
    provinceName = json['ProvinceName'];
    districtName = json['DistrictName'];
    communeName = json['CommuneName'];
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
    data['Phone'] = this.phone;
    data['Mobile'] = this.mobile;
    data['Address'] = this.address;
    data['Gender'] = this.gender;
    data['FacebookAccount'] = this.facebookAccount;
    data['Website'] = this.website;
    data['Birthday'] = this.birthday;
    data['BirthdayStr'] = this.birthdayStr;
    data['Province'] = this.province;
    data['Country'] = this.country;
    data['WorkingPlace'] = this.workingPlace;
    data['AvatarUrl'] = this.avatarUrl;
    data['Signature'] = this.signature;
    data['ActivateKey'] = this.activateKey;
    data['ActivateId'] = this.activateId;
    data['ResetPasswordKey'] = this.resetPasswordKey;
    data['AvatarImage'] = this.avatarImage;
    data['AvatarImageId'] = this.avatarImageId;
    data['Email'] = this.email;
    // data['CurrentDepartment'] = this.currentDepartment;
    data['ProvinceId'] = this.provinceId;
    data['ProvinceIdStr'] = this.provinceIdStr;
    data['CommuneName'] = this.communeName;
    data['ProvinceName'] = this.provinceName;
    data['DistrictName'] = this.districtName;
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
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    data['PositionName'] = this.positionName;
    data['StructDepName'] = this.structDepName;

    return data;
  }
}
