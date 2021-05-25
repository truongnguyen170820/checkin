import 'package:checkin/utils/app_constant.dart';

class BaseRequest {

  String sessionId;

  BaseRequest({this.sessionId});

  Map<String, String> toHeaderMap() {
    Map<String, String> map = new Map();
    map["AppKey"] = AppConstants.APP_KEY;
    if(sessionId != null) {
      map["SessionId"] = this.sessionId;
    }
    return map;
  }
}
