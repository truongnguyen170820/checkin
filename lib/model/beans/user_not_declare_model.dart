class NotDeclareModel {
  String employeeId;
  String departmentId;
  String date;
  String dateStr;
  String createdTime;
  String createdTimeStr;
  bool isDeleted;
  // Null textScore;
  EmployeeInfo employeeInfo;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  NotDeclareModel(
      {this.employeeId,
        this.departmentId,
        this.date,
        this.dateStr,
        this.createdTime,
        this.createdTimeStr,
        this.isDeleted,
        // this.textScore,
        this.employeeInfo,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  NotDeclareModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    departmentId = json['DepartmentId'];
    date = json['Date'];
    dateStr = json['DateStr'];
    createdTime = json['CreatedTime'];
    createdTimeStr = json['CreatedTimeStr'];
    isDeleted = json['IsDeleted'];
    // textScore = json['textScore'];
    employeeInfo = json['EmployeeInfo'] != null
        ? new EmployeeInfo.fromJson(json['EmployeeInfo'])
        : null;
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeId'] = this.employeeId;
    data['DepartmentId'] = this.departmentId;
    data['Date'] = this.date;
    data['DateStr'] = this.dateStr;
    data['CreatedTime'] = this.createdTime;
    data['CreatedTimeStr'] = this.createdTimeStr;
    data['IsDeleted'] = this.isDeleted;
    // data['textScore'] = this.textScore;
    if (this.employeeInfo != null) {
      data['EmployeeInfo'] = this.employeeInfo.toJson();
    }
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}

class EmployeeInfo {
  String employeeCode;
  String name;
  String mobile;
  // Null email;
  String address;
  String gender;
  bool isDeleted;
  String createdBy;
  // Null identity;
  num status;
  String createdDate;
  String createdDateStr;
  num enrollNumber;
  DeparmentInfo deparmentInfo;
  // Null startDate;
  String startDateStr;
  // Null signedDate;
  String signedDateStr;
  // Null outDate;
  String outDateStr;
  // Null dateOfBirth;
  String dateOfBirthStr;
  num jobType;
  num salary;
  String positionId;
  String positionIdStr;
  PositionInfo positionInfo;
  // Null username;
  // Null password;
  num accountStatus;
  // Null fingerData;
  // Null cardCode;
  // Null zalo;
  // Null viber;
  String imageAvatar;
  // Null note;
  // Null textScore;
  bool isSelected;
  String manageId;
  String manageIdStr;
  String departmentId;
  String departmentIdStr;
  // Null departmentName;
  String employeeGroupId;
  String employeeGroupIdStr;
  bool allowCheckinAllDep;
  String structureDepartmentId;
  bool appInstalled;
  bool isSupervisor;
  String structureDepartmentIdStr;
  String structureDepartmentName;
  String provinceId;
  String provinceIdStr;
  String districtId;
  String communeId;
  String districtIdStr;
  String communeIdStr;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  EmployeeInfo(
      {this.employeeCode,
        this.name,
        this.mobile,
        // this.email,
        this.address,
        this.gender,
        this.isDeleted,
        this.createdBy,
        // this.identity,
        this.status,
        this.createdDate,
        this.createdDateStr,
        this.enrollNumber,
        this.deparmentInfo,
        // this.startDate,
        this.startDateStr,
        // this.signedDate,
        this.signedDateStr,
        // this.outDate,
        this.outDateStr,
        // this.dateOfBirth,
        this.dateOfBirthStr,
        this.jobType,
        this.salary,
        this.positionId,
        this.positionIdStr,
        this.positionInfo,
        // this.username,
        // this.password,
        this.accountStatus,
        // this.fingerData,
        // this.cardCode,
        // this.zalo,
        // this.viber,
        this.imageAvatar,
        // this.note,
        // this.textScore,
        this.isSelected,
        this.manageId,
        this.manageIdStr,
        this.departmentId,
        this.departmentIdStr,
        // this.departmentName,
        this.employeeGroupId,
        this.employeeGroupIdStr,
        this.allowCheckinAllDep,
        this.structureDepartmentId,
        this.appInstalled,
        this.isSupervisor,
        this.structureDepartmentIdStr,
        this.structureDepartmentName,
        this.provinceId,
        this.provinceIdStr,
        this.districtId,
        this.communeId,
        this.districtIdStr,
        this.communeIdStr,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  EmployeeInfo.fromJson(Map<String, dynamic> json) {
    employeeCode = json['EmployeeCode'];
    name = json['Name'];
    mobile = json['Mobile'];
    // email = json['Email'];
    address = json['Address'];
    gender = json['Gender'];
    isDeleted = json['IsDeleted'];
    createdBy = json['CreatedBy'];
    // identity = json['Identity'];
    status = json['Status'];
    createdDate = json['CreatedDate'];
    createdDateStr = json['CreatedDateStr'];
    enrollNumber = json['EnrollNumber'];
    deparmentInfo = json['DeparmentInfo'] != null
        ? new DeparmentInfo.fromJson(json['DeparmentInfo'])
        : null;
    // startDate = json['StartDate'];
    startDateStr = json['StartDateStr'];
    // signedDate = json['SignedDate'];
    signedDateStr = json['SignedDateStr'];
    // outDate = json['OutDate'];
    outDateStr = json['OutDateStr'];
    // dateOfBirth = json['DateOfBirth'];
    dateOfBirthStr = json['DateOfBirthStr'];
    jobType = json['JobType'];
    salary = json['Salary'];
    positionId = json['PositionId'];
    positionIdStr = json['PositionIdStr'];
    positionInfo = json['PositionInfo'] != null
        ? new PositionInfo.fromJson(json['PositionInfo'])
        : null;
    // username = json['Username'];
    // password = json['Password'];
    accountStatus = json['AccountStatus'];
    // fingerData = json['FingerData'];
    // cardCode = json['CardCode'];
    // zalo = json['Zalo'];
    // viber = json['Viber'];
    imageAvatar = json['ImageAvatar'];
    // note = json['Note'];
    // textScore = json['textScore'];
    isSelected = json['IsSelected'];
    manageId = json['ManageId'];
    manageIdStr = json['ManageIdStr'];
    departmentId = json['DepartmentId'];
    departmentIdStr = json['DepartmentIdStr'];
    // departmentName = json['DepartmentName'];
    employeeGroupId = json['EmployeeGroupId'];
    employeeGroupIdStr = json['EmployeeGroupIdStr'];
    allowCheckinAllDep = json['AllowCheckinAllDep'];
    structureDepartmentId = json['StructureDepartmentId'];
    appInstalled = json['AppInstalled'];
    isSupervisor = json['IsSupervisor'];
    structureDepartmentIdStr = json['StructureDepartmentIdStr'];
    structureDepartmentName = json['StructureDepartmentName'];
    provinceId = json['ProvinceId'];
    provinceIdStr = json['ProvinceIdStr'];
    districtId = json['DistrictId'];
    communeId = json['CommuneId'];
    districtIdStr = json['DistrictIdStr'];
    communeIdStr = json['CommuneIdStr'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeCode'] = this.employeeCode;
    data['Name'] = this.name;
    data['Mobile'] = this.mobile;
    // data['Email'] = this.email;
    data['Address'] = this.address;
    data['Gender'] = this.gender;
    data['IsDeleted'] = this.isDeleted;
    data['CreatedBy'] = this.createdBy;
    // data['Identity'] = this.identity;
    data['Status'] = this.status;
    data['CreatedDate'] = this.createdDate;
    data['CreatedDateStr'] = this.createdDateStr;
    data['EnrollNumber'] = this.enrollNumber;
    if (this.deparmentInfo != null) {
      data['DeparmentInfo'] = this.deparmentInfo.toJson();
    }
    // data['StartDate'] = this.startDate;
    data['StartDateStr'] = this.startDateStr;
    // data['SignedDate'] = this.signedDate;
    data['SignedDateStr'] = this.signedDateStr;
    // data['OutDate'] = this.outDate;
    data['OutDateStr'] = this.outDateStr;
    // data['DateOfBirth'] = this.dateOfBirth;
    data['DateOfBirthStr'] = this.dateOfBirthStr;
    data['JobType'] = this.jobType;
    data['Salary'] = this.salary;
    data['PositionId'] = this.positionId;
    data['PositionIdStr'] = this.positionIdStr;
    if (this.positionInfo != null) {
      data['PositionInfo'] = this.positionInfo.toJson();
    }
    // data['Username'] = this.username;
    // data['Password'] = this.password;
    data['AccountStatus'] = this.accountStatus;
    // data['FingerData'] = this.fingerData;
    // data['CardCode'] = this.cardCode;
    // data['Zalo'] = this.zalo;
    // data['Viber'] = this.viber;
    data['ImageAvatar'] = this.imageAvatar;
    // data['Note'] = this.note;
    // data['textScore'] = this.textScore;
    data['IsSelected'] = this.isSelected;
    data['ManageId'] = this.manageId;
    data['ManageIdStr'] = this.manageIdStr;
    data['DepartmentId'] = this.departmentId;
    data['DepartmentIdStr'] = this.departmentIdStr;
    // data['DepartmentName'] = this.departmentName;
    data['EmployeeGroupId'] = this.employeeGroupId;
    data['EmployeeGroupIdStr'] = this.employeeGroupIdStr;
    data['AllowCheckinAllDep'] = this.allowCheckinAllDep;
    data['StructureDepartmentId'] = this.structureDepartmentId;
    data['AppInstalled'] = this.appInstalled;
    data['IsSupervisor'] = this.isSupervisor;
    data['StructureDepartmentIdStr'] = this.structureDepartmentIdStr;
    data['StructureDepartmentName'] = this.structureDepartmentName;
    data['ProvinceId'] = this.provinceId;
    data['ProvinceIdStr'] = this.provinceIdStr;
    data['DistrictId'] = this.districtId;
    data['CommuneId'] = this.communeId;
    data['DistrictIdStr'] = this.districtIdStr;
    data['CommuneIdStr'] = this.communeIdStr;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}

class DeparmentInfo {
  String deparmentCode;
  String name;
  String description;
  // Null parentCode;
  // Null parentInfo;
  String createdDate;
  String createdDateStr;
  num cardCodeLengthFrom;
  num cardCodeLengthTo;
  String createdBy;
  bool isDeleted;
  // Null deletedDate;
  String deletedDateStr;
  // Null deletedBy;
  // Null companyCode;
  String address;
  String mobileNumber;
  String phoneNumber;
  num type;
  num numOrder;
  // Null path;
  String email;
  double lng;
  double lat;
  bool hasTrainerService;
  bool freeParking;
  bool towelRent;
  bool freeWater;
  // Null numroductionText;
  // Null website;
  bool isPublic;
  String parentId;
  String parentIdStr;
  // Null textScore;
  List<String> imageList;
  bool isAutoBlockOnMachine;
  String logoUrl;
  // Null domainInfo;
  bool allowMultiActivatedService;
  bool isUnCheckMobile;
  String iPPublic;
  List<String> otherIpList;
  bool checkAccessIp;
  // Null otherIpListStr;
  bool usingSystemSmtp;
  SmtpInfo smtpInfo;
  bool autoSendBirthdayEmail;
  String domainEmailTemplateId;
  String domainEmailTemplateIdStr;
  num ponumToMoneyRate;
  bool autoCheckinClass;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  DeparmentInfo(
      {this.deparmentCode,
        this.name,
        this.description,
        // this.parentCode,
        // this.parentInfo,
        this.createdDate,
        this.createdDateStr,
        this.cardCodeLengthFrom,
        this.cardCodeLengthTo,
        this.createdBy,
        this.isDeleted,
        // this.deletedDate,
        this.deletedDateStr,
        // this.deletedBy,
        // this.companyCode,
        this.address,
        this.mobileNumber,
        this.phoneNumber,
        this.type,
        this.numOrder,
        // this.path,
        this.email,
        this.lng,
        this.lat,
        this.hasTrainerService,
        this.freeParking,
        this.towelRent,
        this.freeWater,
        // this.numroductionText,
        // this.website,
        this.isPublic,
        this.parentId,
        this.parentIdStr,
        // this.textScore,
        this.imageList,
        this.isAutoBlockOnMachine,
        this.logoUrl,
        // this.domainInfo,
        this.allowMultiActivatedService,
        this.isUnCheckMobile,
        this.iPPublic,
        this.otherIpList,
        this.checkAccessIp,
        // this.otherIpListStr,
        this.usingSystemSmtp,
        this.smtpInfo,
        this.autoSendBirthdayEmail,
        this.domainEmailTemplateId,
        this.domainEmailTemplateIdStr,
        this.ponumToMoneyRate,
        this.autoCheckinClass,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  DeparmentInfo.fromJson(Map<String, dynamic> json) {
    deparmentCode = json['DeparmentCode'];
    name = json['Name'];
    description = json['Description'];
    // parentCode = json['ParentCode'];
    // parentInfo = json['ParentInfo'];
    createdDate = json['CreatedDate'];
    createdDateStr = json['CreatedDateStr'];
    cardCodeLengthFrom = json['CardCodeLengthFrom'];
    cardCodeLengthTo = json['CardCodeLengthTo'];
    createdBy = json['CreatedBy'];
    isDeleted = json['IsDeleted'];
    // deletedDate = json['DeletedDate'];
    deletedDateStr = json['DeletedDateStr'];
    // deletedBy = json['DeletedBy'];
    // companyCode = json['CompanyCode'];
    address = json['Address'];
    mobileNumber = json['MobileNumber'];
    phoneNumber = json['PhoneNumber'];
    type = json['Type'];
    numOrder = json['NumOrder'];
    // path = json['Path'];
    email = json['Email'];
    lng = json['Lng'];
    lat = json['Lat'];
    hasTrainerService = json['HasTrainerService'];
    freeParking = json['FreeParking'];
    towelRent = json['TowelRent'];
    freeWater = json['FreeWater'];
    // numroductionText = json['numroductionText'];
    // website = json['Website'];
    isPublic = json['IsPublic'];
    parentId = json['ParentId'];
    parentIdStr = json['ParentIdStr'];
    // textScore = json['textScore'];
    imageList = json['ImageList'].cast<String>();
    isAutoBlockOnMachine = json['IsAutoBlockOnMachine'];
    logoUrl = json['LogoUrl'];
    // domainInfo = json['DomainInfo'];
    allowMultiActivatedService = json['AllowMultiActivatedService'];
    isUnCheckMobile = json['IsUnCheckMobile'];
    iPPublic = json['IPPublic'];
    otherIpList = json['OtherIpList'].cast<String>();
    checkAccessIp = json['CheckAccessIp'];
    // otherIpListStr = json['OtherIpListStr'];
    usingSystemSmtp = json['UsingSystemSmtp'];
    smtpInfo = json['SmtpInfo'] != null
        ? new SmtpInfo.fromJson(json['SmtpInfo'])
        : null;
    autoSendBirthdayEmail = json['AutoSendBirthdayEmail'];
    domainEmailTemplateId = json['DomainEmailTemplateId'];
    domainEmailTemplateIdStr = json['DomainEmailTemplateIdStr'];
    ponumToMoneyRate = json['PonumToMoneyRate'];
    autoCheckinClass = json['AutoCheckinClass'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeparmentCode'] = this.deparmentCode;
    data['Name'] = this.name;
    data['Description'] = this.description;
    // data['ParentCode'] = this.parentCode;
    // data['ParentInfo'] = this.parentInfo;
    data['CreatedDate'] = this.createdDate;
    data['CreatedDateStr'] = this.createdDateStr;
    data['CardCodeLengthFrom'] = this.cardCodeLengthFrom;
    data['CardCodeLengthTo'] = this.cardCodeLengthTo;
    data['CreatedBy'] = this.createdBy;
    data['IsDeleted'] = this.isDeleted;
    // data['DeletedDate'] = this.deletedDate;
    data['DeletedDateStr'] = this.deletedDateStr;
    // data['DeletedBy'] = this.deletedBy;
    // data['CompanyCode'] = this.companyCode;
    data['Address'] = this.address;
    data['MobileNumber'] = this.mobileNumber;
    data['PhoneNumber'] = this.phoneNumber;
    data['Type'] = this.type;
    data['NumOrder'] = this.numOrder;
    // data['Path'] = this.path;
    data['Email'] = this.email;
    data['Lng'] = this.lng;
    data['Lat'] = this.lat;
    data['HasTrainerService'] = this.hasTrainerService;
    data['FreeParking'] = this.freeParking;
    data['TowelRent'] = this.towelRent;
    data['FreeWater'] = this.freeWater;
    // data['numroductionText'] = this.numroductionText;
    // data['Website'] = this.website;
    data['IsPublic'] = this.isPublic;
    data['ParentId'] = this.parentId;
    data['ParentIdStr'] = this.parentIdStr;
    // data['textScore'] = this.textScore;
    data['ImageList'] = this.imageList;
    data['IsAutoBlockOnMachine'] = this.isAutoBlockOnMachine;
    data['LogoUrl'] = this.logoUrl;
    // data['DomainInfo'] = this.domainInfo;
    data['AllowMultiActivatedService'] = this.allowMultiActivatedService;
    data['IsUnCheckMobile'] = this.isUnCheckMobile;
    data['IPPublic'] = this.iPPublic;
    data['OtherIpList'] = this.otherIpList;
    data['CheckAccessIp'] = this.checkAccessIp;
    // data['OtherIpListStr'] = this.otherIpListStr;
    data['UsingSystemSmtp'] = this.usingSystemSmtp;
    if (this.smtpInfo != null) {
      data['SmtpInfo'] = this.smtpInfo.toJson();
    }
    data['AutoSendBirthdayEmail'] = this.autoSendBirthdayEmail;
    data['DomainEmailTemplateId'] = this.domainEmailTemplateId;
    data['DomainEmailTemplateIdStr'] = this.domainEmailTemplateIdStr;
    data['PonumToMoneyRate'] = this.ponumToMoneyRate;
    data['AutoCheckinClass'] = this.autoCheckinClass;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}

class SmtpInfo {
  // Null smtpServer;
  num port;
  String smtpEmailAddress;
  // Null smtpUserName;
  String smtpPassword;
  bool smtpEnableSsl;

  SmtpInfo(
      {
        // this.smtpServer,
        this.port,
        this.smtpEmailAddress,
        // this.smtpUserName,
        this.smtpPassword,
        this.smtpEnableSsl});

  SmtpInfo.fromJson(Map<String, dynamic> json) {
    // smtpServer = json['SmtpServer'];
    port = json['Port'];
    smtpEmailAddress = json['SmtpEmailAddress'];
    // smtpUserName = json['SmtpUserName'];
    smtpPassword = json['SmtpPassword'];
    smtpEnableSsl = json['SmtpEnableSsl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['SmtpServer'] = this.smtpServer;
    data['Port'] = this.port;
    data['SmtpEmailAddress'] = this.smtpEmailAddress;
    // data['SmtpUserName'] = this.smtpUserName;
    data['SmtpPassword'] = this.smtpPassword;
    data['SmtpEnableSsl'] = this.smtpEnableSsl;
    return data;
  }
}

class PositionInfo {
  String name;
  String positionCode;
  // Null description;
  String createdBy;
  String createDate;
  String createDateStr;
  bool isDeleted;
  // Null deletedBy;
  // Null deletedDate;
  String deletedDateStr;
  // Null textScore;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  PositionInfo(
      {this.name,
        this.positionCode,
        // this.description,
        this.createdBy,
        this.createDate,
        this.createDateStr,
        this.isDeleted,
        // this.deletedBy,
        // this.deletedDate,
        this.deletedDateStr,
        // this.textScore,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  PositionInfo.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    positionCode = json['PositionCode'];
    // description = json['Description'];
    createdBy = json['CreatedBy'];
    createDate = json['CreateDate'];
    createDateStr = json['CreateDateStr'];
    isDeleted = json['IsDeleted'];
    // deletedBy = json['DeletedBy'];
    // deletedDate = json['DeletedDate'];
    deletedDateStr = json['DeletedDateStr'];
    // textScore = json['textScore'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['PositionCode'] = this.positionCode;
    // data['Description'] = this.description;
    data['CreatedBy'] = this.createdBy;
    data['CreateDate'] = this.createDate;
    data['CreateDateStr'] = this.createDateStr;
    data['IsDeleted'] = this.isDeleted;
    // data['DeletedBy'] = this.deletedBy;
    // data['DeletedDate'] = this.deletedDate;
    data['DeletedDateStr'] = this.deletedDateStr;
    // data['textScore'] = this.textScore;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}
