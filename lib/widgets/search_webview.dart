import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SearchWebView extends StatefulWidget {
  final String question;

  SearchWebView(this.question);

  @override
  _SearchWebViewState createState() => _SearchWebViewState(question);
}

class _SearchWebViewState extends State<SearchWebView> {
  bool showSpinner = true;

  final String question;

  _SearchWebViewState(this.question);

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: WebView(
        initialUrl: "https://jacua.org/?s=$question/#main",
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (parameter) {
          setState(() {
            showSpinner = true;
          });
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
