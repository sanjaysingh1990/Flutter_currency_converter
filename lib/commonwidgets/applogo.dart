import 'package:flutter/cupertino.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/verticalspace.dart';
import 'package:flutter_sivisoft_cc/resources/class%20ResString.dart';
import 'package:flutter_sivisoft_cc/utils/themes_styles.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        VerticalSpace(value: 100),
        Text(
          ResString().get("company_name"),
          style: TextThemes.appNameThemeOne,
        ),
        VerticalSpace(
          value: 30,
        ),
        Text(
          ResString().get("app_name"),
          style: TextThemes.appNameThemeTwo,
        ),
      ],
    );
  }
}
