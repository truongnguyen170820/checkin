import 'package:checkin/model/beans/pathology_model.dart';
import 'package:checkin/model/beans/user/user_login_model.dart';

class GlobalCache {
  static GlobalCache _instance;

  factory GlobalCache() => _instance ??= new GlobalCache._();
  GlobalCache._();

  LoginModel loginData;
  List<PathologyModel> pathologyList;

  LoginModel getUser() {
    return loginData;
  }

  void setData(LoginModel _user) {
    this.loginData = _user;
  }

  void setListPathology(List<PathologyModel> list) {
    this.pathologyList = list;
  }
}

