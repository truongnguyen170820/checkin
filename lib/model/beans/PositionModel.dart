class PositionModel {
  String name;
  String positionCode;
  String description;
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

  PositionModel(
      {this.name,
        this.positionCode,
        this.description,
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

  PositionModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    positionCode = json['PositionCode'];
    description = json['Description'];
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
    data['Description'] = this.description;
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