import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';

import 'package:openjmu_lite/apis/api.dart';
import 'package:openjmu_lite/constants/constants.dart';
//import 'package:openjmu_lite/pages/user/user_page.dart';
import 'package:openjmu_lite/pages/web_page.dart';


class ScanQrCodePage extends StatefulWidget {
    @override
    _ScanQrCodePageState createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
    final GlobalKey<QrcodeReaderViewState> _key = GlobalKey();

    Widget backdrop({double width, double height, Widget child}) => Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        color: Color(0x99000000),
        child: child ?? null,
    );

    Future onScan(String data) async {
        if (API.urlReg.stringMatch(data) != null) {
            Navigator.of(context).pushReplacement(platformPageRoute(
                builder: (_) => WebPage(url: data, title: ""),
            ));
//        } else if (API.schemeUserPage.stringMatch(data) != null) {
//            Navigator.of(context).pushReplacement(platformPageRoute(
//                builder: (_) => UserPage(uid: int.parse(data.substring(API.schemeUserPage.pattern.length - 2))),
//            ));
        } else {
            await showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                    title: Text("扫码结果"),
                    content: Text(data),
                    actions: <Widget>[
                        CupertinoDialogAction(
                            child: Text("确认"),
                            onPressed: () => Navigator.pop(context),
                        )
                    ],
                ),
            );
            _key.currentState.startScan();
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Constants.appThemeColor,
                title: Text(
                    "扫描二维码",
                    style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                        fontSize: Constants.size(20.0),
                    ),
                ),
                centerTitle: true,
            ),
            body: QrcodeReaderView(key: _key, onScan: onScan),
        );
    }
}
