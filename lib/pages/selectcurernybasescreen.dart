import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/actionbutton.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/applogo.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/commonwidget.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/verticalspace.dart';
import 'package:flutter_sivisoft_cc/resources/class%20ResString.dart';
import 'package:flutter_sivisoft_cc/utils/AppColors.dart';
import 'package:flutter_sivisoft_cc/utils/routes.dart';

class SelectCurrencyBaseScreen extends StatefulWidget {
  @override
  _SelectCurrencyBaseScreenState createState() =>
      _SelectCurrencyBaseScreenState();
}

class _SelectCurrencyBaseScreenState extends State<SelectCurrencyBaseScreen> {
  TextEditingController _inputController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKeys = new GlobalKey<ScaffoldState>();
  FocusNode _inputField = new FocusNode();
  bool _isFromHome = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (routes != null) _isFromHome = routes['fromHome'] ?? false;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColors.bluePrimary,
      key: _scaffoldKeys,
      body: Container(
        color: AppColors.bluePrimary,
        child: new Stack(
          children: <Widget>[
            Align(alignment: Alignment.topCenter, child: AppLogo()),
            Align(
              alignment: Alignment.center,
              child: inputWidget,
            )
          ],
        ),
      ),
    );
  }

  get inputWidget => SingleChildScrollView(
        child: Container(
          margin: new EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ResString().get('select_base_currency'),
                style: TextStyle(fontSize: 18, color: AppColors.kWhite),
              ),
              VerticalSpace(
                value: 30,
              ),
              getTextField(ResString().get('currency_code'), _inputController,
                  _inputField, _inputField, TextInputType.text, context,
                  obsectextType: false),
              VerticalSpace(
                value: 60,
              ),
              ActionButton(
                callback: callback,buttonLabel: ResString().get('button_next'),
              )
            ],
          ),
        ),
      );

  VoidCallback callback() {
    var base = _inputController.text.toUpperCase();
    if (!_isFromHome)
      Navigator.pushNamed(
          context, '${Routes.routeNameSelectBaseCurrencyCompare}',
          arguments: {"base": base});
    else
      Navigator.pop(context, base);
  }

  void showInSnackBar(String value) {
    _scaffoldKeys.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
}
