import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:network_info_plus/network_info_plus.dart';

class webviewpage extends StatefulWidget {
  final String urlnya;

  final String judulnya;
  webviewpage({Key? key, required this.urlnya, required this.judulnya})
      : super(key: key);

  @override
  State<webviewpage> createState() => _webviewpageState();
}

class _webviewpageState extends State<webviewpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.judulnya),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: WebView(
        initialUrl: widget.urlnya,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
