class PathologyModel {
  String name;
  String description;
  bool active;
  // Null createdTime;
  String createdTimeStr;
  bool isDeleted;
  bool isChecked;
  // Null textScore;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  PathologyModel(
      {this.name,
        this.description,
        this.active,
        // this.createdTime,
        this.createdTimeStr,
        this.isDeleted,
        this.isChecked,
        // this.textScore,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  PathologyModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    active = json['Active'];
    // createdTime = json['CreatedTime'];
    createdTimeStr = json['CreatedTimeStr'];
    isDeleted = json['IsDeleted'];
    isChecked = false;
    // textScore = json['textScore'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Active'] = this.active;
    // data['CreatedTime'] = this.createdTime;
    data['CreatedTimeStr'] = this.createdTimeStr;
    data['IsDeleted'] = this.isDeleted;
    // data['textScore'] = this.textScore;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}
