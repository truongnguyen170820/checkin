class DeclarationRequest {
  String domainIdStr;
  String code;
  String fullName;
  String faceUrl;
  num type;
  String typeName;
  String registerDateStr;
  String mobile;
  String email;
  String identityNo;
  String address;
  String provinceIdStr;
  String provinceName;
  String depIdStr;
  String depName;
  bool checkHealthy5;
  bool checkHealthy6;
  bool checkHealthy7;
  bool checkHealthy8;
  bool checkHealthy9;
  bool checkHealthy10;
  num bodyTemperature;
  num tempType;
  // bool near30Status1;
  // bool near30Status2;
  bool near30Status3;
  bool near30Status4;
  bool near30Status5;
  String detailDes;
  String gender;
  num yearOfBirth;
  String districtIdStr;
  String communeIdStr;
  String declareImageUrl;
  num personType;
  num jobType;
  String jobTypeName;
  List<String> benhIdListStr;
  String countries;

  DeclarationRequest(
      {this.domainIdStr,
        this.code,
        this.fullName,
        this.faceUrl,
        this.type,
        this.typeName,
        this.mobile,
        this.email,
        this.identityNo,
        this.registerDateStr,
        this.address,
        this.provinceIdStr,
        this.provinceName,
        this.depIdStr,
        this.depName,
        this.checkHealthy5,
        this.checkHealthy6,
        this.checkHealthy7,
        this.checkHealthy8,
        this.checkHealthy9,
        this.checkHealthy10,
        this.bodyTemperature,
        this.tempType,
        // this.near30Status1,
        // this.near30Status2,
        this.near30Status3,
        this.near30Status4,
        this.near30Status5,
        this.detailDes,
        this.gender,
        this.yearOfBirth,
        this.districtIdStr,
        this.communeIdStr,
        this.declareImageUrl,
        this.personType,
        this.jobType,
        this.benhIdListStr,
        this.countries,
        this.jobTypeName});

  DeclarationRequest.fromJson(Map<String, dynamic> json) {
    domainIdStr = json['DomainIdStr'];
    code = json['Code'];
    fullName = json['FullName'];
    faceUrl = json['FaceUrl'];
    type = json['Type'];
    typeName = json['TypeName'];
    mobile = json['Mobile'];
    email = json['Email'];
    identityNo = json['IdentityNo'];
    registerDateStr = json['RegisterDateStr'];
    address = json['Address'];
    provinceIdStr = json['ProvinceIdStr'];
    provinceName = json['ProvinceName'];
    depIdStr = json['DepIdStr'];
    depName = json['DepName'];
    checkHealthy5 = json['CheckHealthy5'];
    checkHealthy6 = json['CheckHealthy6'];
    checkHealthy7 = json['CheckHealthy7'];
    checkHealthy8 = json['CheckHealthy8'];
    checkHealthy9 = json['CheckHealthy9'];
    checkHealthy10 = json['CheckHealthy10'];
    bodyTemperature = json['BodyTemperature'];
    tempType = json['TempType'];
    // near30Status1 = json['Near30Status1'];
    // near30Status2 = json['Near30Status2'];
    near30Status3 = json['Near30Status3'];
    near30Status4 = json['Near30Status4'];
    near30Status5 = json['Near30Status5'];
    detailDes = json['DetailDes'];
    gender = json['Gender'];
    yearOfBirth = json['YearOfBirth'];
    districtIdStr = json['DistrictIdStr'];
    communeIdStr = json['CommuneIdStr'];
    declareImageUrl = json['DeclareImageUrl'];
    personType = json['PersonType'];
    jobType = json['JobType'];
    jobTypeName = json['JobTypeName'];
    benhIdListStr = json['BenhIdListStr'];
    countries = json['Countries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DomainIdStr'] = this.domainIdStr;
    data['Code'] = this.code;
    data['FullName'] = this.fullName;
    data['FaceUrl'] = this.faceUrl;
    data['RegisterDateStr'] = this.registerDateStr;
    data['Type'] = this.type;
    data['TypeName'] = this.typeName;
    data['Mobile'] = this.mobile;
    data['Email'] = this.email;
    data['IdentityNo'] = this.identityNo;
    data['Address'] = this.address;
    data['ProvinceIdStr'] = this.provinceIdStr;
    data['ProvinceName'] = this.provinceName;
    data['DepIdStr'] = this.depIdStr;
    data['DepName'] = this.depName;
    data['CheckHealthy5'] = this.checkHealthy5;
    data['CheckHealthy6'] = this.checkHealthy6;
    data['CheckHealthy7'] = this.checkHealthy7;
    data['CheckHealthy8'] = this.checkHealthy8;
    data['CheckHealthy9'] = this.checkHealthy9;
    data['CheckHealthy10'] = this.checkHealthy10;
    data['BodyTemperature'] = this.bodyTemperature;
    data['TempType'] = this.tempType;
    // data['Near30Status1'] = this.near30Status1;
    // data['Near30Status2'] = this.near30Status2;
    data['Near30Status3'] = this.near30Status3;
    data['Near30Status4'] = this.near30Status4;
    data['Near30Status5'] = this.near30Status5;
    data['DetailDes'] = this.detailDes;
    data['Gender'] = this.gender;
    data['YearOfBirth'] = this.yearOfBirth;
    data['DistrictIdStr'] = this.districtIdStr;
    data['CommuneIdStr'] = this.communeIdStr;
    data['DeclareImageUrl'] = this.declareImageUrl;
    data['PersonType'] = this.personType;
    data['JobType'] = this.jobType;
    data['JobTypeName'] = this.jobTypeName;
    data['BenhIdListStr'] = this.benhIdListStr;
    data['Countries'] = this.countries;
    return data;
  }
}
