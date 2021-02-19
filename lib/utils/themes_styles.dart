import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'AssetStrings.dart';

class TextThemes {
  static final TextStyle greyTextFieldHintNormal = TextStyle(
    fontSize: 16,
    color: Color.fromRGBO(183, 183, 183, 1.0),
  );

  static final TextStyle userNameStyle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.kBlack);

  static final TextStyle tournamentHistoryScoreTheme = TextStyle(
      fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.kWhite);
  static final TextStyle tournamentHistoryScoreTitleTheme = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.kWhite,
    height: 1.5,
  );

  static final TextStyle appNameThemeOne = TextStyle(
      fontFamily: AssetStrings.cartoonBoldStyle,
      fontSize: 35,
      letterSpacing: 5.0,
      color: AppColors.kWhite,
      fontWeight: FontWeight.w600);

  static final TextStyle appNameThemeTwo = TextStyle(
      fontSize: 22,
      color: AppColors.kWhite,
      letterSpacing: 1.0,
      fontWeight: FontWeight.w400);
}
