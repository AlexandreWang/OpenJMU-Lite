import 'package:flutter/material.dart';

import 'package:openjmu_lite/constants/constants.dart';
import 'package:openjmu_lite/pages/splash_page.dart';
import 'package:openjmu_lite/utils/net_utils.dart';
import 'package:openjmu_lite/utils/router_utils.dart';
import 'package:openjmu_lite/utils/shared_preference_utils.dart';


void main() async {
    await SpUtils.initSharedPreferences();
    runApp(LiteApp());
}

class LiteApp extends StatefulWidget {
    @override
    _LiteAppState createState() => _LiteAppState();
}

class _LiteAppState extends State<LiteApp> {

    @override
    void initState() {
        NetUtils.initConfig();
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: Constants.appTitle,
            routes: RouterUtils.routes,
            theme: ThemeData(
                primarySwatch: Colors.red,
            ),
            home: SplashPage(),
        );
    }
}