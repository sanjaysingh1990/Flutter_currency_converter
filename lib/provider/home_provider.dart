import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sivisoft_cc/model/apierror.dart';
import 'package:flutter_sivisoft_cc/model/currencyvalueresponse.dart';

import 'package:flutter_sivisoft_cc/networkmodel/APIHandler.dart';
import 'package:flutter_sivisoft_cc/networkmodel/APIs.dart';
import 'package:flutter_sivisoft_cc/utils/constants.dart';


class HomeProvider with ChangeNotifier {
  var _isLoading = false;

  getLoading() => _isLoading;

  Future<dynamic> getExchangeCurrencyInfo(String base,BuildContext context) async {
    Completer<dynamic> completer = new Completer<dynamic>();
    var url = "${APIs.getLatestExchangeRate}?base=$base";
    var response = await APIHandler.get(
      context: context,
      url: url,
    );
      hideLoader();

    if (response is APIError) {
      completer.complete(response);
      notifyListeners();
      return completer.future;
    } else {
      CurrencyValueResponse currencyValueResponse =
          new CurrencyValueResponse.fromJson(response);
      completer.complete(currencyValueResponse);
      notifyListeners();
      return completer.future;
    }
  }

  void hideLoader() {
    _isLoading = false;
    notifyListeners();
  }

  void setLoading() {
    _isLoading = true;
    notifyListeners();
  }
}
