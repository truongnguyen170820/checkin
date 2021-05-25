import 'package:cached_network_image/cached_network_image.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget viewImage(String url, num width, num height, BuildContext context,
    {double radius = 5, BoxFit boxFit= BoxFit.cover}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: CachedNetworkImage(
        height: (height),
        width: (width),
        placeholder: (context, url) => Container(
              width: (width),
              height: (height),
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
        errorWidget: (context, url, error) => Image.asset(
              "assets/icons/ic_default_image.png",
              fit: boxFit,
              width: (width),
              height: (height),
            ),
        fit: boxFit,
        imageUrl: ApiConstants.shared.getFullImage(url == "" ? "" : url)),
  );
}
