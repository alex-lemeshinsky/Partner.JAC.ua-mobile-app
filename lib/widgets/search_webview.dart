import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:jacua/functions/check_url.dart';

class SearchWebView extends StatefulWidget {
  final String question;

  SearchWebView(this.question);

  @override
  _SearchWebViewState createState() => _SearchWebViewState(question);
}

class _SearchWebViewState extends State<SearchWebView> {
  bool showSpinner = true;
  WebViewController _controller;

  final String question;

  _SearchWebViewState(this.question);

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: WebView(
        initialUrl: "https://jacua.org/?s=$question#main",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController c) {
          _controller = c;
        },
        onPageStarted: (parameter) async {
          setState(() {
            showSpinner = true;
          });
          var url = await _controller.currentUrl();
          checkURL(context, url, _controller);
        },
        onPageFinished: (parameter) {
          setState(() {
            showSpinner = false;
          });
        },
      ),
    );
  }
}
