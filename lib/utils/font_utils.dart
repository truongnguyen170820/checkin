import 'package:checkin/widget/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_utils.dart';

class FontUtils {
  static final NORMAL = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: setSp(14),
    color: ColorUtils.TEXT_NORMAL,

  );

  static final MEDIUM = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: setSp(14),
    color: ColorUtils.TEXT_NORMAL,
  );

  static final SEMIBOLD = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: setSp(14),
    color: ColorUtils.TEXT_NORMAL,
  );
  static final BOLD = GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: setSp(14),
    color: ColorUtils.TEXT_NORMAL,
  );
}