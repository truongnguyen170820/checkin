class AccountModel {
  String idStr;
  double balance;
  String createdDateStr;
  String description;
  double preBalance;
  String lastChangedDateStr;
  String accountNumber;
  String currency;
  String userIdStr;
  String username;
  int prePoint;
  int point;
  int level;
  int status;
  List<ReWards> reWards;
  int totalNumOfWinTurn;
  int pointLevel1;
  int pointLevel2;
  int pointLevel3;

  AccountModel(
      {this.idStr,
        this.balance,
        this.createdDateStr,
        this.description,
        this.preBalance,
        this.lastChangedDateStr,
        this.accountNumber,
        this.currency,
        this.userIdStr,
        this.username,
        this.prePoint,
        this.point,
        this.level,
        this.status,
        this.reWards,
        this.totalNumOfWinTurn,
        this.pointLevel1,
        this.pointLevel2,
        this.pointLevel3});

  AccountModel.fromJson(Map<String, dynamic> json) {
    idStr = json['IdStr'];
    balance = json['Balance'];
    createdDateStr = json['CreatedDateStr'];
    description = json['Description'];
    preBalance = json['PreBalance'];
    lastChangedDateStr = json['LastChangedDateStr'];
    accountNumber = json['AccountNumber'];
    currency = json['Currency'];
    userIdStr = json['UserIdStr'];
    username = json['Username'];
    prePoint = json['PrePoint'];
    point = json['Point'];
    level = json['Level'];
    status = json['Status'];
    if (json['ReWards'] != null) {
      reWards = new List<ReWards>();
      json['ReWards'].forEach((v) {
        reWards.add(new ReWards.fromJson(v));
      });
    }
    totalNumOfWinTurn = json['TotalNumOfWinTurn'];
    pointLevel1 = json['Point_Level1'];
    pointLevel2 = json['Point_Level2'];
    pointLevel3 = json['Point_Level3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdStr'] = this.idStr;
    data['Balance'] = this.balance;
    data['CreatedDateStr'] = this.createdDateStr;
    data['Description'] = this.description;
    data['PreBalance'] = this.preBalance;
    data['LastChangedDateStr'] = this.lastChangedDateStr;
    data['AccountNumber'] = this.accountNumber;
    data['Currency'] = this.currency;
    data['UserIdStr'] = this.userIdStr;
    data['Username'] = this.username;
    data['PrePoint'] = this.prePoint;
    data['Point'] = this.point;
    data['Level'] = this.level;
    data['Status'] = this.status;
    if (this.reWards != null) {
      data['ReWards'] = this.reWards.map((v) => v.toJson()).toList();
    }
    data['TotalNumOfWinTurn'] = this.totalNumOfWinTurn;
    data['Point_Level1'] = this.pointLevel1;
    data['Point_Level2'] = this.pointLevel2;
    data['Point_Level3'] = this.pointLevel3;
    return data;
  }
}

class ReWards {
  String id;
  String idStr;
  String taskId;
  String taskIdStr;
  int value;
  int rewardType;
  String createDate;
  String createDateStr;
  String expiredDate;
  String expiredDateStr;

  ReWards(
      {this.id,
        this.idStr,
        this.taskId,
        this.taskIdStr,
        this.value,
        this.rewardType,
        this.createDate,
        this.createDateStr,
        this.expiredDate,
        this.expiredDateStr});

  ReWards.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    idStr = json['IdStr'];
    taskId = json['TaskId'];
    taskIdStr = json['TaskIdStr'];
    value = json['Value'];
    rewardType = json['RewardType'];
    createDate = json['CreateDate'];
    createDateStr = json['CreateDateStr'];
    expiredDate = json['ExpiredDate'];
    expiredDateStr = json['ExpiredDateStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['IdStr'] = this.idStr;
    data['TaskId'] = this.taskId;
    data['TaskIdStr'] = this.taskIdStr;
    data['Value'] = this.value;
    data['RewardType'] = this.rewardType;
    data['CreateDate'] = this.createDate;
    data['CreateDateStr'] = this.createDateStr;
    data['ExpiredDate'] = this.expiredDate;
    data['ExpiredDateStr'] = this.expiredDateStr;
    return data;
  }
}
