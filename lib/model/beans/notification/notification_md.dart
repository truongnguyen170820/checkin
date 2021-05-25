class NotificationModel {
  String userId;
  String senderUserId;
  String senderUserIdStr;
  String content;
  String title;
  num status;
  num notifyStatus;
  int type;
  num notifyNumRetry;
  String createdDate;
  String createdDateStr;
  // Null readTime;
  String readTimeStr;
  String departmentId;
  String fireBaseMsgId;
  String departmentIdStr;
  String fireBaseMsgIdStr;
  String sId;
  String domainId;
  String idStr;
  String domainIdStr;

  NotificationModel(
      {this.userId,
        this.senderUserId,
        this.senderUserIdStr,
        this.content,
        this.title,
        this.status,
        this.notifyStatus,
        this.type,
        this.notifyNumRetry,
        this.createdDate,
        this.createdDateStr,
        // this.readTime,
        this.readTimeStr,
        this.departmentId,
        this.fireBaseMsgId,
        this.departmentIdStr,
        this.fireBaseMsgIdStr,
        this.sId,
        this.domainId,
        this.idStr,
        this.domainIdStr});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    senderUserId = json['SenderUserId'];
    senderUserIdStr = json['SenderUserIdStr'];
    content = json['Content'];
    title = json['Title'];
    status = json['Status'];
    notifyStatus = json['NotifyStatus'];
    type = json['Type'];
    notifyNumRetry = json['NotifyNumRetry'];
    createdDate = json['CreatedDate'];
    createdDateStr = json['CreatedDateStr'];
    // readTime = json['ReadTime'];
    readTimeStr = json['ReadTimeStr'];
    departmentId = json['DepartmentId'];
    fireBaseMsgId = json['FireBaseMsgId'];
    departmentIdStr = json['DepartmentIdStr'];
    fireBaseMsgIdStr = json['FireBaseMsgIdStr'];
    sId = json['_id'];
    domainId = json['DomainId'];
    idStr = json['IdStr'];
    domainIdStr = json['DomainIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['SenderUserId'] = this.senderUserId;
    data['SenderUserIdStr'] = this.senderUserIdStr;
    data['Content'] = this.content;
    data['Title'] = this.title;
    data['Status'] = this.status;
    data['NotifyStatus'] = this.notifyStatus;
    data['Type'] = this.type;
    data['NotifyNumRetry'] = this.notifyNumRetry;
    data['CreatedDate'] = this.createdDate;
    data['CreatedDateStr'] = this.createdDateStr;
    // data['ReadTime'] = this.readTime;
    data['ReadTimeStr'] = this.readTimeStr;
    data['DepartmentId'] = this.departmentId;
    data['FireBaseMsgId'] = this.fireBaseMsgId;
    data['DepartmentIdStr'] = this.departmentIdStr;
    data['FireBaseMsgIdStr'] = this.fireBaseMsgIdStr;
    data['_id'] = this.sId;
    data['DomainId'] = this.domainId;
    data['IdStr'] = this.idStr;
    data['DomainIdStr'] = this.domainIdStr;
    return data;
  }
}