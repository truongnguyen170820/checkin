class StructDepModel {
  String name;
  String code;
  // Null description;
  bool isDeleted;
  String createdDate;
  String createdDateStr;
  String parentId;
  String parentIdStr;
  // Null parentName;
  String departmentId;
  String departmentIdStr;
  // Null departmentName;
  String manageId;
  String manageIdStr;
  // Null manageName;
  // Null listChild;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  StructDepModel(
      {this.name,
        this.code,
        // this.description,
        this.isDeleted,
        this.createdDate,
        this.createdDateStr,
        this.parentId,
        this.parentIdStr,
        // this.parentName,
        this.departmentId,
        this.departmentIdStr,
        // this.departmentName,
        this.manageId,
        this.manageIdStr,
        // this.manageName,
        // this.listChild,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  StructDepModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    code = json['Code'];
    // description = json['Description'];
    isDeleted = json['IsDeleted'];
    createdDate = json['CreatedDate'];
    createdDateStr = json['CreatedDateStr'];
    parentId = json['ParentId'];
    parentIdStr = json['ParentIdStr'];
    // parentName = json['ParentName'];
    departmentId = json['DepartmentId'];
    departmentIdStr = json['DepartmentIdStr'];
    // departmentName = json['DepartmentName'];
    manageId = json['ManageId'];
    manageIdStr = json['ManageIdStr'];
    // manageName = json['ManageName'];
    // listChild = json['ListChild'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Code'] = this.code;
    // data['Description'] = this.description;
    data['IsDeleted'] = this.isDeleted;
    data['CreatedDate'] = this.createdDate;
    data['CreatedDateStr'] = this.createdDateStr;
    data['ParentId'] = this.parentId;
    data['ParentIdStr'] = this.parentIdStr;
    // data['ParentName'] = this.parentName;
    data['DepartmentId'] = this.departmentId;
    data['DepartmentIdStr'] = this.departmentIdStr;
    // data['DepartmentName'] = this.departmentName;
    data['ManageId'] = this.manageId;
    data['ManageIdStr'] = this.manageIdStr;
    // data['ManageName'] = this.manageName;
    // data['ListChild'] = this.listChild;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}