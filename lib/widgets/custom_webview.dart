import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:jacua/functions/check_url.dart';
import 'main_popup_menu_button.dart';
import 'data_search.dart';
import 'main_drawer.dart';
//import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

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

  /*void _launchURL(BuildContext context) async {
    try {
      await launch(
        'https://jacua.org/application/',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            'org.gnu.icecat',
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }*/

  @override
  Widget build(BuildContext context) {
    /*_launchURL(context);
    return Container(
      width: 0,
      height: 0,
    );*/
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
