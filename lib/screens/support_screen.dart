import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:jacua/widgets/main_drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:jacua/widgets/main_popup_menu_button.dart';
import 'package:jacua/widgets/data_search.dart';
import 'package:jacua/functions/wp-api.dart';
import 'package:jacua/widgets/custom_webview.dart';

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  bool showSpinner = true;
  List posts = [];

  void getPage() async {
    posts = await fetchWpPosts();
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
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return OpenContainer(
              closedBuilder: (context, action) {
                return Card(
                  child: ListTile(
                    title: Text(posts[index]["title"]["rendered"]),
                    subtitle: Text(
                        "${posts[index]["date"][8]}${posts[index]["date"][9]}/${posts[index]["date"][5]}${posts[index]["date"][6]}/${posts[index]["date"][0]}${posts[index]["date"][1]}${posts[index]["date"][2]}${posts[index]["date"][3]}"),
                  ),
                );
              },
              openBuilder: (context, action) {
                return CustomWebView(posts[index]["slug"]);
              },
            );
          },
        ),
      ),
    );
  }
}
