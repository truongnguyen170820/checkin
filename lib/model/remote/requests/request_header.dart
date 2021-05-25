import 'package:checkin/utils/app_constant.dart';
import 'package:checkin/utils/global_cache.dart';

abstract class Header {
  // This class is intended to be used as a mixin, and should not be
  // extended directly.
  factory Header._() => null;

  Map<String, String> getHeader() {
    Map<String, String> map = new Map();
    map["AppKey"] = AppConstants.APP_KEY;
    if(GlobalCache().loginData!=null) {
      map["SessionId"] = GlobalCache().loginData.sessionId;
    }
    return map;
  }
}