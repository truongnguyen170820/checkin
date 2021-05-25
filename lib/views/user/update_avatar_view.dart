import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/blocs/user/update_avatar_bloc.dart';
import 'package:checkin/blocs/user/upload_image_bloc.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/widget/common_appbar.dart';
import 'package:checkin/widget/global.dart';
import 'package:checkin/widget/loading_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UpdateAvatar extends StatefulWidget {
  final String imagePath;

  UpdateAvatar(this.imagePath);

  @override
  State<StatefulWidget> createState() => _UpdateAvatarState(this.imagePath);
}

class _UpdateAvatarState extends State<UpdateAvatar>
    implements ApiResultListener<String> {
  String imagePath;
  ChangeAvatarBloc bloc = ChangeAvatarBloc();
  _UpdateAvatarState(this.imagePath);

  @override
  void initState() {
    super.initState();
    bloc.setListener(this);
  }

  upLoadImage(Asset asset) async {
    final filePath =
    await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
    if (filePath != null) {
      File file;
      if (filePath.toLowerCase().endsWith("heic")) {
        file = File(await HeicToJpg.convert(filePath));
      } else {
        file = File(filePath);
      }

      var bufferFile = await Utilites.compress(
          file.path, await Utilites.getQuantity(file.path));
      if (bufferFile == null) {
        Utilites.showToast(context, "Có lỗi khi tải ảnh");
        return;
      }
      // ignore: unrelated_type_equality_checks
      UploadImageBloc().uploadFileMultiPart(bufferFile, file).then(
            (response) {
          if (response.data.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            this.setState(() {
              imagePath = response.data.Data[0];
            });
            Utilites.showToast(context, "Chọn ảnh thành công");
          } else {
            Utilites.showToast(
                context,
                (response.data.ErrorMessage ?? "").isEmpty
                    ? response.data.ErrorCode
                    : response.data.ErrorMessage);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.backgroundColor,
      appBar: backAppBar(context, "Đổi ảnh check in", actions: [actionSave()]),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: setHeight(120)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: setHeight(90),
                    child: CircleAvatar(
                      radius: setHeight(90 - 3),
                      backgroundImage: CachedNetworkImageProvider(
                          ApiConstants.shared.getFullImage(imagePath)),
                    ),
                  ),
                  Positioned(
                    right: setWidth(10),
                    bottom: setWidth(10),
                    child: GestureDetector(
                      onTap: () async {
                        List<Asset> resultList =
                        await MultiImagePicker.pickImages(
                            maxImages: 1, enableCamera: true);
                        if (!mounted) return;
                        if (resultList.length > 0) {
                          var image = resultList.first;
                          upLoadImage(image);
                        }
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: ColorUtils.backgroundBoldColor,
                        child: Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
Widget actionSave(){
    return FlatButton(
      color: ColorUtils.transparent,
      child: Text(
        "Lưu",
        style: FontUtils.SEMIBOLD.copyWith(fontSize: setSp(18),),
      ),
      onPressed: () {
          print("đường dẫn: $imagePath");
          bloc.updateAvatar(this.imagePath);
      },
    );
}
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  void onError(String message) async {
    Utilites.showToast(context, message);
  }

  @override
  void onRequesting() {
  }

  @override
  void onSuccess(List<String> response) async {
    Navigator.pop(context, imagePath);
  }
}
