import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/actionbutton.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/applogo.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/commonwidget.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/horizontalspace.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/verticalspace.dart';
import 'package:flutter_sivisoft_cc/model/dynamicinputcontroller.dart';
import 'package:flutter_sivisoft_cc/resources/class%20ResString.dart';
import 'package:flutter_sivisoft_cc/utils/AppColors.dart';
import 'package:flutter_sivisoft_cc/utils/routes.dart';

class SelectCompareCurrencyBaseScreen extends StatefulWidget {
  @override
  _SelectCompareCurrencyBaseScreenState createState() =>
      _SelectCompareCurrencyBaseScreenState();
}

class _SelectCompareCurrencyBaseScreenState
    extends State<SelectCompareCurrencyBaseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeys = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  List _inputWidgets;
  String _baseCurrency;
  bool _isFromHome = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _inputWidgets = List<DynamicInputContorllerControllers>();
    _addNewInput();
  }

  void _addNewInput() {
    TextEditingController inputController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    var widget = new Container(
      margin: new EdgeInsets.only(bottom: 10.0),
      child: getTextField(ResString().get('currency_code'), inputController,
          focusNode, focusNode, TextInputType.text, context,
          obsectextType: false),
    );

    var controllerAndWidget =
        DynamicInputContorllerControllers(inputController, widget, focusNode);
    _inputWidgets.add(controllerAndWidget);
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    _baseCurrency = routes['base'];
    _isFromHome = routes['fromHome'] ?? false;
    return Scaffold(
      backgroundColor: AppColors.bluePrimary,
      key: _scaffoldKeys,
      body: Container(
        color: AppColors.bluePrimary,
        child: new Column(
          children: <Widget>[
            AppLogo(),
            VerticalSpace(
              value: 80,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: inputWidget,
              ),
            )
          ],
        ),
      ),
    );
  }

  get inputWidget => Container(
        margin: new EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            baseCurrencyWidget,
            VerticalSpace(
              value: 30,
            ),
            Text(
              ResString().get('currency_to_compare'),
              style: TextStyle(fontSize: 18, color: AppColors.kWhite),
            ),
            VerticalSpace(
              value: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: dynamicInputFields(),
                ),
                HorizontalSpace(
                  value: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: InkWell(
                    onTap: () {
                      _addNewInput();
                      setState(() {});
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 36.0,
                    ),
                  ),
                ),
              ],
            ),
            VerticalSpace(
              value: 60,
            ),
            ActionButton(
                callback: callback, buttonLabel: ResString().get('button_next'))
          ],
        ),
      );

  Widget dynamicInputFields() {
    var viewsList = new List<Widget>();
    for (DynamicInputContorllerControllers data in _inputWidgets) {
      viewsList.add(data.widget);
    }
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: viewsList),
    );
  }

  void _fetchTheFieldValues() {
    if (_formKey.currentState.validate()) {
      var toCurrencyList = List<String>();
      for (DynamicInputContorllerControllers data in _inputWidgets) {
        var value = data.controller.text;
        //filter data if it's not blank
        if (value.isEmpty || value.length < 3 || value.length>3) {
          data.focusNode.requestFocus();
          showInSnackBar("Please enter valid input");
          return;

        } else {
          toCurrencyList.add(value.toUpperCase());
        }
      }
      if (!_isFromHome) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '${Routes.routeNameHome}', (Route<dynamic> route) => false,
            arguments: {'base': _baseCurrency, 'totype': toCurrencyList});
      } else {
        Navigator.pop(context, toCurrencyList);
      }
    }
  }

  VoidCallback callback() {
    _fetchTheFieldValues();
  }

  get baseCurrencyWidget => Text(
        "Base Currency : $_baseCurrency",
        style: TextStyle(
            fontSize: 20, color: AppColors.kWhite, fontWeight: FontWeight.w800),
      );

  void showInSnackBar(String value) {
    _scaffoldKeys.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
}
