import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/widget/global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:flutter/material.dart';

Widget circleAvatar(String path, String replaceName, {double radius = 36}) {
  radius = setWidth(radius);
  return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(
          child: Center(
            child: Text(
              Utilites.getAcronym(replaceName).toUpperCase(),
              style: FontUtils.SEMIBOLD.copyWith(color: Colors.white),
            ),
          ),
          color: Colors.black12,
          width: radius * 2,
          height: radius * 2,
        ),
        imageUrl: ApiConstants.shared.getFullImage(path),
      ));
}
