// import 'package:flutter/cupertino.dart';
// import 'package:optimized_cached_image/widgets.dart';
//
// Widget networkImage(String url, double width, double height,
//     {double radius = 5, String assetImg = "assets/icons/ic_default_image.png"}) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(radius),
//     child: url != null || url == ''
//         ? Builder(builder: (context) {
//       return OptimizedCacheImage(
//           useScaleCacheManager: false,
//           height: (height),
//           width: (width),
//           placeholder: (context, url) => Container(
//             width: (width),
//             height: (height),
//             child: Center(
//               child: CupertinoActivityIndicator(),
//             ),
//           ),
//           errorWidget: (context, url, error) => Image.asset(
//               assetImg,
//               fit: BoxFit.cover,
//               width: (width),
//               height: (height)),
//           fit: BoxFit.cover,
//           imageUrl: url == '' ? url : url);
//     })
//         : Image.asset(
//       assetImg,
//       width: (width),
//       height: (height),
//       excludeFromSemantics: true,
//       gaplessPlayback: true,
//       cacheWidth: width.toInt(),
//       cacheHeight: height.toInt(),
//       fit: BoxFit.cover,
//     ),
//   );
// }
//
//
