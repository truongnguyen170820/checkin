class NotifycationCountModel {
  // Null userName;
  String userId;
  int total;
  int totalUnread;
  String createdTime;
  String createdTimeStr;
  String userIdStr;

  NotifycationCountModel(
      {
        // this.userName,
        this.userId,
        this.total,
        this.totalUnread,
        this.createdTime,
        this.createdTimeStr,
        this.userIdStr});

  NotifycationCountModel.fromJson(Map<String, dynamic> json) {
    // userName = json['UserName'];
    userId = json['UserId'];
    total = json['Total'];
    totalUnread = json['TotalUnread'];
    createdTime = json['CreatedTime'];
    createdTimeStr = json['CreatedTimeStr'];
    userIdStr = json['UserIdStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['UserName'] = this.userName;
    data['UserId'] = this.userId;
    data['Total'] = this.total;
    data['TotalUnread'] = this.totalUnread;
    data['CreatedTime'] = this.createdTime;
    data['CreatedTimeStr'] = this.createdTimeStr;
    data['UserIdStr'] = this.userIdStr;
    return data;
  }
}
