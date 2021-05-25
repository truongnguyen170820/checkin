
class JDIResponse {
  final String ErrorCode;
  final String ErrorMessage;
  final int Total;
  final List<dynamic> Data;


  JDIResponse.create(String errorCode, String errorMessage, this.Total, this.Data): ErrorCode = errorCode, ErrorMessage = errorMessage;

  JDIResponse.fromJson(Map<String, dynamic> json)
      : ErrorCode = json["ErrorCode"],
        ErrorMessage = json["ErrorMessage"],
        Total = json["Total"],
        Data = json["Data"];
}