import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sivisoft_cc/utils/AppColors.dart';
import 'package:flutter_sivisoft_cc/utils/AssetStrings.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback callback;
  final String buttonLabel;

  ActionButton({@required this.callback, @required this.buttonLabel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: InkWell(
        onTap: () {
          callback();
        },
        child: Text(
          buttonLabel,
          style: TextStyle(
              fontFamily: AssetStrings.cartoonBoldStyle,
              fontSize: 20,
              color: AppColors.kWhite,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
