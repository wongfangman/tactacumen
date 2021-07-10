import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tactacumen/user/payment/paydetail.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayScreen extends StatefulWidget {
  final PayDetails paydetails;

  const PayScreen({
    Key key,
    this.paydetails,
  }) : super(key: key);

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('PAYMENT',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl:
                      'https://hubbuddies.com/271221/tactacumen/php/generate_bill.php?email=' +
                          widget.paydetails.email +
                          '&mobile=' +
                          widget.paydetails.phone +
                          '&name=' +
                          widget.paydetails.name +
                          '&amount=' +
                          widget.paydetails.amount,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
