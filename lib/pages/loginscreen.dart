import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sivisoft_cc/commonwidgets/applogo.dart';
import 'package:flutter_sivisoft_cc/provider/login_provider.dart';
import 'package:flutter_sivisoft_cc/utils/AppColors.dart';
import 'package:flutter_sivisoft_cc/utils/AssetStrings.dart';
import 'package:flutter_sivisoft_cc/utils/Messages.dart';
import 'package:flutter_sivisoft_cc/utils/routes.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeys = new GlobalKey<ScaffoldState>();
  bool isUserSignedIn = false;
  LoginProvider _loginProvider;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    initApp();
  }

  void initApp() async {
    await new Future.delayed(new Duration(milliseconds: 300));
    // immediately check whether the user is signed in
    checkIfUserIsSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    _loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bluePrimary,
      key: _scaffoldKeys,
      body: Container(
        color: AppColors.bluePrimary,
        child: new Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: AppLogo(),
            ),
            Align(
              alignment: Alignment.center,
              child: googleLoginButton,
            ),
            Visibility(
                visible: _loginProvider.getLoading(),
                child: Center(child: CircularProgressIndicator(),))
          ],
        ),
      ),
    );
  }

  get googleLoginButton => InkWell(
        onTap: () {
          _handleSignIn();
        },
        child: Container(
          width: MediaQuery.of(context).size.width*0.70,
          color: AppColors.kWhite,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    AssetStrings.googleLogo,
                    width: 28,
                    height: 28,
                  ),
                  SizedBox(width: 10),
                  Text("Sign in", style: TextStyle(color: AppColors.kBlack,fontSize: 16))
                ],
              )),
        ),
      );

  void showInSnackBar(String value) {
    _scaffoldKeys.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }



  Future<void> _handleSignIn() async {
    try {
      await _loginProvider.googleLogin();
      checkIfUserIsSignedIn();
    } catch (ex) {
      showInSnackBar(Messages.genericError);
    }
  }

  void checkIfUserIsSignedIn() async {
    _loginProvider.setLoading();
    var status = await _loginProvider.checkIfUserIsSignedIn();
    _loginProvider.hideLoader();
    //check if already logged in
    if (status) {
      _moveToNextScreen();
    }
  }

  void _moveToNextScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        '${Routes.routeNameSelecteBaseCurrency}', (Route<dynamic> route) => false);
  }
}
