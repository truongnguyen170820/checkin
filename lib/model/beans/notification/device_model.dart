class DeviceIDModel {
  double latitude;
  double longitude;
  String devicePushId;
  int type;

  DeviceIDModel(this.latitude, this.longitude, this.devicePushId, this.type);

  DeviceIDModel.fromJson(Map<String, dynamic> json) {
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    devicePushId = json['DevicePushId'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['DevicePushId'] = this.devicePushId;
    data['Type'] = this.type;
    return data;
  }
}
