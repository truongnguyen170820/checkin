class CountryModel {
  String code;
  String createdBy;
  String createdDate;
  String createdDateStr;
  bool isDeleted;
  // Null deletedBy;
  // Null deletedDate;
  String deletedDateStr;
  // Null description;
  String name;
  bool isActive;
  // Null textScore;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  CountryModel(
      {this.code,
        this.createdBy,
        this.createdDate,
        this.createdDateStr,
        this.isDeleted,
        // this.deletedBy,
        // this.deletedDate,
        this.deletedDateStr,
        // this.description,
        this.name,
        this.isActive,
        // this.textScore,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  CountryModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    createdDateStr = json['CreatedDateStr'];
    isDeleted = json['IsDeleted'];
    // deletedBy = json['DeletedBy'];
    // deletedDate = json['DeletedDate'];
    deletedDateStr = json['DeletedDateStr'];
    // description = json['Description'];
    name = json['Name'];
    isActive = json['IsActive'];
    // textScore = json['textScore'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['CreatedDateStr'] = this.createdDateStr;
    data['IsDeleted'] = this.isDeleted;
    // data['DeletedBy'] = this.deletedBy;
    // data['DeletedDate'] = this.deletedDate;
    data['DeletedDateStr'] = this.deletedDateStr;
    // data['Description'] = this.description;
    data['Name'] = this.name;
    data['IsActive'] = this.isActive;
    // data['textScore'] = this.textScore;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}