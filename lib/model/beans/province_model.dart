class ProvinceModel {
  String code;
  // Null createdBy;
  // Null createdDate;
  String createdDateStr;
  bool isDeleted;
  // Null deletedBy;
  // Null deletedDate;
  String deletedDateStr;
  String description;
  String name;
  bool isActive;
  String countryId;
  String countryIdStr;
  // Null countryInfo;
  String fullName;
  // Null zipCode;
  String alternateName;
  // Null textScore;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  ProvinceModel(
      {this.code,
        // this.createdBy,
        // this.createdDate,
        this.createdDateStr,
        this.isDeleted,
        // this.deletedBy,
        // this.deletedDate,
        this.deletedDateStr,
        this.description,
        this.name,
        this.isActive,
        this.countryId,
        this.countryIdStr,
        // this.countryInfo,
        this.fullName,
        // this.zipCode,
        this.alternateName,
        // this.textScore,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    // createdBy = json['CreatedBy'];
    // createdDate = json['CreatedDate'];
    createdDateStr = json['CreatedDateStr'];
    isDeleted = json['IsDeleted'];
    // deletedBy = json['DeletedBy'];
    // deletedDate = json['DeletedDate'];
    deletedDateStr = json['DeletedDateStr'];
    description = json['Description'];
    name = json['Name'];
    isActive = json['IsActive'];
    countryId = json['CountryId'];
    countryIdStr = json['CountryIdStr'];
    // countryInfo = json['CountryInfo'];
    fullName = json['FullName'];
    // zipCode = json['ZipCode'];
    alternateName = json['AlternateName'];
    // textScore = json['textScore'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    // data['CreatedBy'] = this.createdBy;
    // data['CreatedDate'] = this.createdDate;
    data['CreatedDateStr'] = this.createdDateStr;
    data['IsDeleted'] = this.isDeleted;
    // data['DeletedBy'] = this.deletedBy;
    // data['DeletedDate'] = this.deletedDate;
    data['DeletedDateStr'] = this.deletedDateStr;
    data['Description'] = this.description;
    data['Name'] = this.name;
    data['IsActive'] = this.isActive;
    data['CountryId'] = this.countryId;
    data['CountryIdStr'] = this.countryIdStr;
    // data['CountryInfo'] = this.countryInfo;
    data['FullName'] = this.fullName;
    // data['ZipCode'] = this.zipCode;
    data['AlternateName'] = this.alternateName;
    // data['textScore'] = this.textScore;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}
