import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class UploadImageBloc {
  // Future<ApiResponse<JDIResponse>> uploadFile(Uint8List filePath, File file) async{
  //   FormData formData = FormData.fromMap({
  //     "file": await MultipartFile.fromBytes(filePath,filename: path.basename(file.path) )
  //   });
  //   var response= await ApiService(ApiConstants.API_UPLOAD_IMAGE, null, null, formData: formData)
  //       .getResponse();
  //   return response;
  // }

  Future<JDIResponse> uploadFile(String filePath, String imageBase64) async {
    var data = Map<String, dynamic>();
    data['FileName'] = filePath;
    data['Base64Content'] = imageBase64;
    var response =
        await ApiService(ApiConstants.UPLOAD_BASE64, data, null).getResponse();
    if (response.status == Status.SUCCESS) {
      JDIResponse jdiResponse = response.data;
      return jdiResponse;
    } else {
      return JDIResponse.create("999999", "Lỗi không xác định", 0, null);
    }
  }

  Future<ApiResponse<JDIResponse>> uploadFileMultiPart(
      Uint8List filePath, File file) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromBytes(filePath,
          filename: path.basename(file.path))
    });
    var response = await ApiService(ApiConstants.UPLOAD_IMAGE, null, null,
            formData: formData)
        .getResponse();
    return response;
  }
}
