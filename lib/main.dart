import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sivisoft_cc/pages/dashboardscreen.dart';
import 'package:flutter_sivisoft_cc/pages/loginscreen.dart';
import 'package:flutter_sivisoft_cc/pages/selectcomparecurernyscreen.dart';
import 'package:flutter_sivisoft_cc/pages/selectcurernybasescreen.dart';
import 'package:flutter_sivisoft_cc/provider/home_provider.dart';
import 'package:flutter_sivisoft_cc/provider/login_provider.dart';
import 'package:flutter_sivisoft_cc/utils/constants.dart';
import 'package:flutter_sivisoft_cc/utils/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //for check life cycle
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  FirebaseApp defaultApp = await Firebase.initializeApp();

  runApp(
      /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
      MultiProvider(
    providers: [
      ChangeNotifierProvider<HomeProvider>(
        create: (context) => HomeProvider(),
      ),
      ChangeNotifierProvider<LoginProvider>(
        create: (context) => LoginProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '${Routes.routeNameHome}': (context) => DashBoardScreen(),
        '${Routes.routeNameLogin}': (context) => LoginScreen(),
        '${Routes.routeNameSelecteBaseCurrency}': (context) => SelectCurrencyBaseScreen(),
        '${Routes.routeNameSelectBaseCurrencyCompare}': (context) =>
            SelectCompareCurrencyBaseScreen(),

      },
    );
  }
}
