class ApiConstants {
  //SURVEY APP
  static const String BASE_URL = "http://192.168.1.86:32001";
  // static const String BASE_URL = "http://nhamay.timeface.vn:8080";
  // static const String BASE_IMAGE_URL = "http://nhamay.timeface.vn:8080/";
  static const String BASE_IMAGE_URL = "http://192.168.1.86:32001/";
  static const String SIGNIN_ACCOUNT = "/api/user/login";
  static const String SIGNOUT_ACCOUNT = "/api/user/logout";
  static const String CHANGE_PWD_USER = "/api/user/changepassword";
  static const String GET_PROFILE = "/api/user/getprofile";
  static const String UPDATE_PROFILE = "/api/user/updateprofile";
  static const String CREATE_SURVEY = "/akssurvey/create";
  static const String UPDATE_SURVEY = "/akssurvey/update";
  static const String DELETE_SURVEY = "/akssurvey/delete";
  static const String GET_SURVEY_LIST = "/akssurvey/getPaging";
  static final String UPLOAD_IMAGE = "/api/file/upload";
  static final String GET_NOTIFICATION = "/api/notifymsg/gets";
  static final String RED_NOTIFICATION = "/api/notifymsg/read";
  static final String GET_DECLAREMANAGER = "/api/declarerpt/gets";
  static final String GET_NOT_DECLARE_LIST = "/api/declarerpt/getNotDeclare";
  static final String GET_HAS_PROBLEM_LIST = "/api/declarerpt/getDichTe";

  static const String UPDATE_AVATAR = "/api/user/changeAvatar";
  static const String UPLOAD_BASE64 = "/api/file/uploadbase64";
  // static const String REQUIRE_OTP = "/userapp/requireOTP";
  // static const String VALIDATE_OTP = "/userapp/validateOtp";
  static const String REGISTER = "/api/user/register";
  static const String RESET_PWD = "/api/user/setPassword";
  //main
  static const String GET_LIST_PATHOLOGY = "/api/commonList/benhList";
  static const String GET_LIST_DISTRICT = "/api/commonList/getDistricts";
  static const String GET_LIST_COUNTRY = "/api/commonList/countryList";
  static const String GET_LIST_PROVINCE = "/api/commonList/provinceList";
  static const String GET_LIST_COMMUNE = "/api/commonList/getCommunes";
  static const String ADD_DECLARATION = "/api/declare/insertFaceCustomer";
  static const String ADD_REPORT_INFO = "/api/complain/add";

  static const String GET_DECLARATION_HIS = "/api/declare/faceCustomerHis";
  static const String GET_LIST_POSITION = "/api/commonList/positionList";
  static const String GET_STRUCT_DEPLIST = "/api/commonList/StructDepList";
  static const String COUNT_NOTIFY_UNREAD = "/api/notifymsg/Summary";
  static const String UPDATE_DEVICE_ID = "/aksuser/updateDevice";
  static const String UPDATE_FIREBASE_TOKEN_ID = "/api/user/updatedevice";

  static ApiConstants shared = ApiConstants();

  String getFullImage(String url) {
    if (url == null || url.isEmpty) return "";
    if (url.startsWith("http://")) return url;
    return BASE_IMAGE_URL + url.toString();
  }
}
