class NotifyUnreadModel {
  int appType;
  int totanUnRead;

  NotifyUnreadModel({this.appType, this.totanUnRead});

  NotifyUnreadModel.fromJson(Map<String, dynamic> json) {
    appType = json['AppType'];
    totanUnRead = json['TotanUnRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppType'] = this.appType;
    data['TotanUnRead'] = this.totanUnRead;
    return data;
  }
}