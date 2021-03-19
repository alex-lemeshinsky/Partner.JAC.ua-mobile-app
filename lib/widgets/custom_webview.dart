import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:jacua/functions/check_url.dart';
import 'main_popup_menu_button.dart';
import 'data_search.dart';
import 'main_drawer.dart';

class CustomWebView extends StatefulWidget {
  final String question;

  CustomWebView(this.question);

  @override
  _CustomWebViewState createState() => _CustomWebViewState(question);
}

class _CustomWebViewState extends State<CustomWebView> {
  bool showSpinner = true;
  WebViewController _controller;

  final String question;

  _CustomWebViewState(this.question);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Partner.JAC.ua"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          MainPopupMenuButton(),
        ],
      ),
      drawer: MainDrawer(),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: WebView(
          initialUrl: "https://jacua.org/$question/#main",
          javascriptMode: JavascriptMode.unrestricted,
          //initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
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
          onPageFinished: (parameter) async {
            setState(() {
              showSpinner = false;
            });
          },
        ),
      ),
    );
  }
}
