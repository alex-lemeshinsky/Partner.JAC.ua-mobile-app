import 'package:flutter/material.dart';
import 'package:jacua/widgets/main_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:jacua/widgets/main_popup_menu_button.dart';
import 'package:jacua/widgets/data_search.dart';
import 'package:jacua/functions/check_url.dart';

class ProjectsScreen extends StatefulWidget {
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  bool showSpinner = true;
  WebViewController _controller;

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
          initialUrl: "https://jacua.org/start/",
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
      ),
    );
  }
}
