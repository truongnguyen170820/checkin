class ReportInfoRequest {
  List<int> type;
  String provinceIdStr;
  String districtIdStr;
  String communeIdStr;
  String address;
  String timeStr;
  String content;

  ReportInfoRequest(
      {this.type,
        this.provinceIdStr,
        this.districtIdStr,
        this.communeIdStr,
        this.address,
        this.timeStr,
        this.content});

  ReportInfoRequest.fromJson(Map<String, dynamic> json) {
    type = json['Type'].cast<int>();
    provinceIdStr = json['ProvinceIdStr'];
    districtIdStr = json['DistrictIdStr'];
    communeIdStr = json['CommuneIdStr'];
    address = json['Address'];
    timeStr = json['TimeStr'];
    content = json['Content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['ProvinceIdStr'] = this.provinceIdStr;
    data['DistrictIdStr'] = this.districtIdStr;
    data['CommuneIdStr'] = this.communeIdStr;
    data['Address'] = this.address;
    data['TimeStr'] = this.timeStr;
    data['Content'] = this.content;
    return data;
  }
}
