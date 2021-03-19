import 'package:flutter/material.dart';
import 'package:jacua/widgets/main_drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:jacua/widgets/main_popup_menu_button.dart';
import 'package:jacua/widgets/data_search.dart';
import 'package:jacua/functions/wp-api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

class PdiScreen extends StatefulWidget {
  @override
  _PdiScreenState createState() => _PdiScreenState();
}

class _PdiScreenState extends State<PdiScreen> {
  bool showSpinner = true;
  String page = "";

  void getPage() async {
    page = await fetchPdiPage();
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getPage();
  }

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
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Html(
                  data: page,
                ),
              ),
              TextButton(
                onPressed: () async {
                  const url =
                      'mailto:dmytro.halka@jac.ua?subject=Запит на оренду обладнання';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text(
                  "Надіслати запит",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              )
            ],
          )),
    );
  }
}
