import 'package:checkin/widget/global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:flutter/material.dart';

Widget imageThumb(String path, {double width, double height}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      border: Border.all(
        color: Colors.black12,
      ),
      image: DecorationImage(
        image:
            CachedNetworkImageProvider(ApiConstants.shared.getFullImage(path)),
        fit: BoxFit.fill,
      ),
    ),
  );
}
