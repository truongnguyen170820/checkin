import 'package:checkin/model/beans/province_model.dart';

class DistrictModel {
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
  String provinceId;
  String provinceIdStr;
  ProvinceModel provinceInfo;
  String fullName;
  String alternateName;
  // Null textScore;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  DistrictModel(
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
        this.provinceId,
        this.provinceIdStr,
        this.provinceInfo,
        this.fullName,
        this.alternateName,
        // this.textScore,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  DistrictModel.fromJson(Map<String, dynamic> json) {
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
    provinceId = json['ProvinceId'];
    provinceIdStr = json['ProvinceIdStr'];
    provinceInfo = json['ProvinceInfo'] != null
        ? new ProvinceModel.fromJson(json['ProvinceInfo'])
        : null;
    fullName = json['FullName'];
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
    data['ProvinceId'] = this.provinceId;
    data['ProvinceIdStr'] = this.provinceIdStr;
    if (this.provinceInfo != null) {
      data['ProvinceInfo'] = this.provinceInfo.toJson();
    }
    data['FullName'] = this.fullName;
    data['AlternateName'] = this.alternateName;
    // data['textScore'] = this.textScore;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}
