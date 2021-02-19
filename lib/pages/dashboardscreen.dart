import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/actionbutton.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/applogo.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/commonwidget.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/horizontalspace.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/verticalspace.dart';
import 'package:flutter_sivisoft_cc/model/apierror.dart';
import 'package:flutter_sivisoft_cc/model/currencyvalueresponse.dart';
import 'package:flutter_sivisoft_cc/provider/home_provider.dart';
import 'package:flutter_sivisoft_cc/provider/login_provider.dart';
import 'package:flutter_sivisoft_cc/resources/class%20ResString.dart';
import 'package:flutter_sivisoft_cc/utils/AppColors.dart';
import 'package:flutter_sivisoft_cc/utils/Messages.dart';
import 'package:flutter_sivisoft_cc/utils/routes.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  HomeProvider _homeProvider;
  LoginProvider _loginProvider;
  final GlobalKey<ScaffoldState> _scaffoldKeys = new GlobalKey<ScaffoldState>();
  var _selectedCurrency = List<String>();
  String _baseCurrency;
  List _toCurrencyList;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _initArguments();
  }

  void _initArguments() async {
    await new Future.delayed(new Duration(milliseconds: 500));
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    _baseCurrency = routes['base'] ?? "";
    _toCurrencyList = routes['totype'];
    if (_baseCurrency.isEmpty) {
      _baseCurrency = "INR";
    }
    print("home base $_baseCurrency");
    print("to type ${_toCurrencyList.toString()}");
    _getData();
  }

  Future<void> _getData() async {
    _homeProvider.setLoading();

    //check internet conneciton first
    bool gotInternetConnection = await hasInternetConnection(
      mounted: mounted,
      canShowAlert: true,
      onFail: () {
        _homeProvider.hideLoader();
        showInSnackBar(Messages.noInternetError);
      },
      onSuccess: () {},
    );

    if (gotInternetConnection) {
      var response =
          await _homeProvider.getExchangeCurrencyInfo(_baseCurrency, context);
      if (response is APIError) {
        showInSnackBar(response.message ?? Messages.genericError);
      } else {
        //var selectedCurrency = ["INR", "USD", "ZAR", "CAD"];
        CurrencyValueResponse currencyValueResponse = response;
        _selectedCurrency.clear();
        for (String data in _toCurrencyList) {
          if (currencyValueResponse.rates.curencyMapping[data.toUpperCase()] !=
              null) {
            _selectedCurrency.add(
                "$data Value : ${currencyValueResponse.rates.curencyMapping[data.toUpperCase()]}");
          }
        }
        //to get the unqiue values
        _selectedCurrency = _selectedCurrency.toSet().toList();
        ;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = Provider.of<HomeProvider>(context);
    _loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      key: _scaffoldKeys,
      backgroundColor: AppColors.bluePrimary,
      body: Container(
        color: AppColors.bluePrimary,
        child: new Column(
          children: <Widget>[
            AppLogo(),
            VerticalSpace(
              value: 16,
            ),
            refreshWidget,
            VerticalSpace(
              value: 80,
            ),
            conversionWidget,
            Expanded(
              child: listItems,
            ),
            VerticalSpace(
              value: 30,
            ),
            ActionButton(
                callback: callback, buttonLabel: ResString().get('logout')),
            VerticalSpace(
              value: 30,
            ),
          ],
        ),
      ),
    );
  }

  get refreshWidget => InkWell(
        onTap: () {
          _getData();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh,
              color: Colors.blue,
              size: 24.0,
            ),
            HorizontalSpace(value: 5),
            Text(
              "Refresh",
              style: TextStyle(color: AppColors.kWhite, fontSize: 15),
            )
          ],
        ),
      );

  get conversionWidget => Container(
        margin: new EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            baseCurrencyWidget,
            VerticalSpace(
              value: 20,
            ),
            Divider(
              thickness: 2,
              color: AppColors.kWhite.withOpacity(0.5),
            ),
            VerticalSpace(
              value: 20,
            ),
            todayValueAndAddmoreCurrencyWidget,
            VerticalSpace(
              value: 10,
            ),
            loader
          ],
        ),
      );

  get loader => (_homeProvider.getLoading())
      ? Center(child: CircularProgressIndicator())
      : Container();

  get listItems => Container(
        margin: new EdgeInsets.only(
          left: 40.0,
        ),
        child: new ListView.builder(
          itemCount: _selectedCurrency.length,
          itemBuilder: (BuildContext context, int index) {
            return _listItem(_selectedCurrency[index]);
          },
        ),
      );

  Widget _listItem(String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Text(
        "$value",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.kWhite),
      ),
    );
  }

  VoidCallback callback() {
    _logout();
  }

  void _logout() async {
    await _loginProvider.logoutGoogleLoginIn();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '${Routes.routeNameLogin}', (Route<dynamic> route) => false);
  }

  get baseCurrencyWidget => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Base Currency: 1 $_baseCurrency",
            style: TextStyle(
                fontSize: 20,
                color: AppColors.kWhite,
                fontWeight: FontWeight.w800),
          ),
          InkWell(
            onTap: () async {
              var value = await Navigator.of(context).pushNamed(
                  '${Routes.routeNameSelecteBaseCurrency}',
                  arguments: {'fromHome': true});
              print("new base $value");
              if (value != null) {
                _baseCurrency = value;
                _getData();
              }
            },
            child: Text(
              ResString().get('edit_base_currency'),
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.kWhite.withOpacity(0.8),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );

  get todayValueAndAddmoreCurrencyWidget => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ResString().get('today_value'),
            style: TextStyle(
                fontSize: 20,
                color: AppColors.kWhite,
                fontWeight: FontWeight.w800),
          ),
          InkWell(
            onTap: () async {
              var value = await Navigator.of(context).pushNamed(
                  '${Routes.routeNameSelectBaseCurrencyCompare}',
                  arguments: {'fromHome': true,'base':_baseCurrency});
              print("new base $value");
              if (value != null) {
                _toCurrencyList.addAll(value);
                _getData();
              }
            },
            child: Text(
              ResString().get('add_more_currency'),
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.kWhite.withOpacity(0.8),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );

  void showInSnackBar(String value) {
    _scaffoldKeys.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
}
