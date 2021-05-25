class UserHasDeclared {
  String code;
  String fullName;
  num type;
  // Null typeName;
  String mobile;
  // Null email;
  String identityNo;
  String address;
  String provinceId;
  String provinceIdStr;
  // Null provinceName;
  String depId;
  String depIdStr;
  String depName;
  bool checkHealthy1;
  bool checkHealthy2;
  bool checkHealthy3;
  bool checkHealthy4;
  num bodyTemperature;
  num tempType;
  bool near30Status1;
  bool near30Status2;
  bool near30Status3;
  bool near30Status4;
  bool near30Status5;
  bool near30Status6;
  // Null detailDes;
  String createdTime;
  String createdTimeStr;
  // Null ip;
  String updatedTime;
  String updatedTimeStr;
  String updatedBy;
  String faceUrl;
  String facePersionId;
  bool isDeleted;
  String registerDate;
  String registerDateStr;
  // Null base64Image;
  // Null textScore;
  String gender;
  num yearOfBirth;
  String districtId;
  // Null districtName;
  String communeId;
  // Null communeName;
  String districtIdStr;
  String communeIdStr;
  num registerChannel;
  // Null declareImageUrl;
  num personType;
  num jobType;
  // Null jobTypeName;
  // Null empCodeNo;
  // Null agentRegister;
  // Null regions;
  bool faceRegistered;
  // Null base64DeclareImage;
  // Null organization;
  // Null positionName;
  bool isCompletedPay;
  bool isEmployee;
  // Null payDateTime;
  String payDateTimeStr;
  String declaredUserId;
  String employeeId;
  String countries;
  bool checkHealthy5;
  bool checkHealthy6;
  bool checkHealthy7;
  bool checkHealthy8;
  bool checkHealthy9;
  bool checkHealthy10;
  List<String> benhIdList;
  String comandGroupId;
  bool isSendNotity;
  // Null benhIdListStr;
  bool dauHieu;
  // Null benhLy;
  // Null checkHealthy5Name;
  // Null checkHealthy6Name;
  // Null checkHealthy7Name;
  // Null checkHealthy8Name;
  // Null checkHealthy9Name;
  // Null checkHealthy10Name;
  // Null posIds;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  UserHasDeclared(
      {this.code,
        this.fullName,
        this.type,
        // this.typeName,
        this.mobile,
        // this.email,
        this.identityNo,
        this.address,
        this.provinceId,
        this.provinceIdStr,
        // this.provinceName,
        this.depId,
        this.depIdStr,
        this.depName,
        this.checkHealthy1,
        this.checkHealthy2,
        this.checkHealthy3,
        this.checkHealthy4,
        this.bodyTemperature,
        this.tempType,
        this.near30Status1,
        this.near30Status2,
        this.near30Status3,
        this.near30Status4,
        this.near30Status5,
        this.near30Status6,
        // this.detailDes,
        this.createdTime,
        this.createdTimeStr,
        // this.ip,
        this.updatedTime,
        this.updatedTimeStr,
        this.updatedBy,
        this.faceUrl,
        this.facePersionId,
        this.isDeleted,
        this.registerDate,
        this.registerDateStr,
        // this.base64Image,
        // this.textScore,
        this.gender,
        this.yearOfBirth,
        this.districtId,
        // this.districtName,
        this.communeId,
        // this.communeName,
        this.districtIdStr,
        this.communeIdStr,
        this.registerChannel,
        // this.declareImageUrl,
        this.personType,
        this.jobType,
        // this.jobTypeName,
        // this.empCodeNo,
        // this.agentRegister,
        // this.regions,
        this.faceRegistered,
        // this.base64DeclareImage,
        // this.organization,
        // this.positionName,
        this.isCompletedPay,
        this.isEmployee,
        // this.payDateTime,
        this.payDateTimeStr,
        this.declaredUserId,
        this.employeeId,
        this.countries,
        this.checkHealthy5,
        this.checkHealthy6,
        this.checkHealthy7,
        this.checkHealthy8,
        this.checkHealthy9,
        this.checkHealthy10,
        this.benhIdList,
        this.comandGroupId,
        this.isSendNotity,
        // this.benhIdListStr,
        this.dauHieu,
        // this.benhLy,
        // this.checkHealthy5Name,
        // this.checkHealthy6Name,
        // this.checkHealthy7Name,
        // this.checkHealthy8Name,
        // this.checkHealthy9Name,
        // this.checkHealthy10Name,
        // this.posIds,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  UserHasDeclared.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    fullName = json['FullName'];
    type = json['Type'];
    // typeName = json['TypeName'];
    mobile = json['Mobile'];
    // email = json['Email'];
    identityNo = json['IdentityNo'];
    address = json['Address'];
    provinceId = json['ProvinceId'];
    provinceIdStr = json['ProvinceIdStr'];
    // provinceName = json['ProvinceName'];
    depId = json['DepId'];
    depIdStr = json['DepIdStr'];
    depName = json['DepName'];
    checkHealthy1 = json['CheckHealthy1'];
    checkHealthy2 = json['CheckHealthy2'];
    checkHealthy3 = json['CheckHealthy3'];
    checkHealthy4 = json['CheckHealthy4'];
    bodyTemperature = json['BodyTemperature'];
    tempType = json['TempType'];
    near30Status1 = json['Near30Status1'];
    near30Status2 = json['Near30Status2'];
    near30Status3 = json['Near30Status3'];
    near30Status4 = json['Near30Status4'];
    near30Status5 = json['Near30Status5'];
    near30Status6 = json['Near30Status6'];
    // detailDes = json['DetailDes'];
    createdTime = json['CreatedTime'];
    createdTimeStr = json['CreatedTimeStr'];
    // ip = json['Ip'];
    updatedTime = json['UpdatedTime'];
    updatedTimeStr = json['UpdatedTimeStr'];
    updatedBy = json['UpdatedBy'];
    faceUrl = json['FaceUrl'];
    facePersionId = json['FacePersionId'];
    isDeleted = json['IsDeleted'];
    registerDate = json['RegisterDate'];
    registerDateStr = json['RegisterDateStr'];
    // base64Image = json['Base64Image'];
    // textScore = json['textScore'];
    gender = json['Gender'];
    yearOfBirth = json['YearOfBirth'];
    districtId = json['DistrictId'];
    // districtName = json['DistrictName'];
    communeId = json['CommuneId'];
    // communeName = json['CommuneName'];
    districtIdStr = json['DistrictIdStr'];
    communeIdStr = json['CommuneIdStr'];
    registerChannel = json['RegisterChannel'];
    // declareImageUrl = json['DeclareImageUrl'];
    personType = json['PersonType'];
    jobType = json['JobType'];
    // jobTypeName = json['JobTypeName'];
    // empCodeNo = json['EmpCodeNo'];
    // agentRegister = json['AgentRegister'];
    // regions = json['Regions'];
    faceRegistered = json['FaceRegistered'];
    // base64DeclareImage = json['Base64DeclareImage'];
    // organization = json['Organization'];
    // positionName = json['PositionName'];
    isCompletedPay = json['IsCompletedPay'];
    isEmployee = json['IsEmployee'];
    // payDateTime = json['PayDateTime'];
    payDateTimeStr = json['PayDateTimeStr'];
    declaredUserId = json['DeclaredUserId'];
    employeeId = json['EmployeeId'];
    countries = json['Countries'];
    checkHealthy5 = json['CheckHealthy5'];
    checkHealthy6 = json['CheckHealthy6'];
    checkHealthy7 = json['CheckHealthy7'];
    checkHealthy8 = json['CheckHealthy8'];
    checkHealthy9 = json['CheckHealthy9'];
    checkHealthy10 = json['CheckHealthy10'];

    benhIdList = json['BenhIdList']==null?[]: json['BenhIdList'].cast<String>();
    comandGroupId = json['ComandGroupId'];
    isSendNotity = json['IsSendNotity'];
    // benhIdListStr = json['BenhIdListStr'];
    dauHieu = json['DauHieu'];
    // benhLy = json['BenhLy'];
    // checkHealthy5Name = json['CheckHealthy5Name'];
    // checkHealthy6Name = json['CheckHealthy6Name'];
    // checkHealthy7Name = json['CheckHealthy7Name'];
    // checkHealthy8Name = json['CheckHealthy8Name'];
    // checkHealthy9Name = json['CheckHealthy9Name'];
    // checkHealthy10Name = json['CheckHealthy10Name'];
    // posIds = json['PosIds'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['FullName'] = this.fullName;
    data['Type'] = this.type;
    // data['TypeName'] = this.typeName;
    data['Mobile'] = this.mobile;
    // data['Email'] = this.email;
    data['IdentityNo'] = this.identityNo;
    data['Address'] = this.address;
    data['ProvinceId'] = this.provinceId;
    data['ProvinceIdStr'] = this.provinceIdStr;
    // data['ProvinceName'] = this.provinceName;
    data['DepId'] = this.depId;
    data['DepIdStr'] = this.depIdStr;
    data['DepName'] = this.depName;
    data['CheckHealthy1'] = this.checkHealthy1;
    data['CheckHealthy2'] = this.checkHealthy2;
    data['CheckHealthy3'] = this.checkHealthy3;
    data['CheckHealthy4'] = this.checkHealthy4;
    data['BodyTemperature'] = this.bodyTemperature;
    data['TempType'] = this.tempType;
    data['Near30Status1'] = this.near30Status1;
    data['Near30Status2'] = this.near30Status2;
    data['Near30Status3'] = this.near30Status3;
    data['Near30Status4'] = this.near30Status4;
    data['Near30Status5'] = this.near30Status5;
    data['Near30Status6'] = this.near30Status6;
    // data['DetailDes'] = this.detailDes;
    data['CreatedTime'] = this.createdTime;
    data['CreatedTimeStr'] = this.createdTimeStr;
    // data['Ip'] = this.ip;
    data['UpdatedTime'] = this.updatedTime;
    data['UpdatedTimeStr'] = this.updatedTimeStr;
    data['UpdatedBy'] = this.updatedBy;
    data['FaceUrl'] = this.faceUrl;
    data['FacePersionId'] = this.facePersionId;
    data['IsDeleted'] = this.isDeleted;
    data['RegisterDate'] = this.registerDate;
    data['RegisterDateStr'] = this.registerDateStr;
    // data['Base64Image'] = this.base64Image;
    // data['textScore'] = this.textScore;
    data['Gender'] = this.gender;
    data['YearOfBirth'] = this.yearOfBirth;
    data['DistrictId'] = this.districtId;
    // data['DistrictName'] = this.districtName;
    data['CommuneId'] = this.communeId;
    // data['CommuneName'] = this.communeName;
    data['DistrictIdStr'] = this.districtIdStr;
    data['CommuneIdStr'] = this.communeIdStr;
    data['RegisterChannel'] = this.registerChannel;
    // data['DeclareImageUrl'] = this.declareImageUrl;
    data['PersonType'] = this.personType;
    data['JobType'] = this.jobType;
    // data['JobTypeName'] = this.jobTypeName;
    // data['EmpCodeNo'] = this.empCodeNo;
    // data['AgentRegister'] = this.agentRegister;
    // data['Regions'] = this.regions;
    data['FaceRegistered'] = this.faceRegistered;
    // data['Base64DeclareImage'] = this.base64DeclareImage;
    // data['Organization'] = this.organization;
    // data['PositionName'] = this.positionName;
    data['IsCompletedPay'] = this.isCompletedPay;
    data['IsEmployee'] = this.isEmployee;
    // data['PayDateTime'] = this.payDateTime;
    data['PayDateTimeStr'] = this.payDateTimeStr;
    data['DeclaredUserId'] = this.declaredUserId;
    data['EmployeeId'] = this.employeeId;
    data['Countries'] = this.countries;
    data['CheckHealthy5'] = this.checkHealthy5;
    data['CheckHealthy6'] = this.checkHealthy6;
    data['CheckHealthy7'] = this.checkHealthy7;
    data['CheckHealthy8'] = this.checkHealthy8;
    data['CheckHealthy9'] = this.checkHealthy9;
    data['CheckHealthy10'] = this.checkHealthy10;
    data['BenhIdList'] = this.benhIdList;
    data['ComandGroupId'] = this.comandGroupId;
    data['IsSendNotity'] = this.isSendNotity;
    // data['BenhIdListStr'] = this.benhIdListStr;
    data['DauHieu'] = this.dauHieu;
    // data['BenhLy'] = this.benhLy;
    // data['CheckHealthy5Name'] = this.checkHealthy5Name;
    // data['CheckHealthy6Name'] = this.checkHealthy6Name;
    // data['CheckHealthy7Name'] = this.checkHealthy7Name;
    // data['CheckHealthy8Name'] = this.checkHealthy8Name;
    // data['CheckHealthy9Name'] = this.checkHealthy9Name;
    // data['CheckHealthy10Name'] = this.checkHealthy10Name;
    // data['PosIds'] = this.posIds;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}