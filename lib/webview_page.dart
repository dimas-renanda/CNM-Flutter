import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:network_info_plus/network_info_plus.dart';

class webviewpage extends StatefulWidget {
  webviewpage({Key? key}) : super(key: key);

  @override
  State<webviewpage> createState() => _webviewpageState();
}

class _webviewpageState extends State<webviewpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
      ),
      body: const WebView(
        initialUrl: 'https://google.co.id',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
