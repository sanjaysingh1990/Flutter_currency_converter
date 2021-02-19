// Checks Internet connection
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sivisoft_cc/utils/AppColors.dart';
import 'package:flutter_sivisoft_cc/utils/themes_styles.dart';

Future<bool> hasInternetConnection({
  bool mounted,
  @required Function onSuccess,
  @required Function onFail,
  bool canShowAlert = true,
}) async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 5));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      onSuccess();
      return true;
    } else {
      if (canShowAlert) {
        onFail();
      }
    }
  } catch (_) {
    onFail();
  }
  return false;
}

Widget getTextField(
    String labelText,
    TextEditingController controller,
    FocusNode focusNodeCurrent,
    FocusNode focusNodeNext,
    TextInputType textInputType,
    BuildContext context,
    {bool obsectextType}) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.all(Radius.circular(8))),

    child: new TextField(
      textCapitalization: TextCapitalization.characters,
      controller: controller,
      keyboardType: textInputType,
      obscureText: false,
      focusNode: focusNodeCurrent,
      maxLength: 3,
           onSubmitted: (String value) {
        if (focusNodeCurrent == focusNodeNext) {
          focusNodeCurrent.unfocus();
        } else {
          FocusScope.of(context).autofocus(focusNodeNext);
        }
      },

      decoration: new InputDecoration(
          counterText: '',
        contentPadding:
            new EdgeInsets.only(top: 18.0, bottom: 18.0, left: 10, right: 10),
        hintText: labelText,
        hintStyle: TextThemes.greyTextFieldHintNormal,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    ),
  );
}
