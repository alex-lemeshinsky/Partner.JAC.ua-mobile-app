import 'package:flutter/material.dart';
import 'package:jacua/widgets/main_drawer.dart';
import 'package:jacua/widgets/main_popup_menu_button.dart';
import 'package:jacua/widgets/data_search.dart';
import 'package:jacua/functions/wp-api.dart';
import 'package:jacua/functions/launch_url.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hive/hive.dart';

class OrganizationScreen extends StatefulWidget {
  @override
  _OrganizationScreenState createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen> {
  bool showSpinner = false;
  List content = [];

  void getContent() async {
    content = await fetchOrganizationPage();
    setState(() {
      showSpinner = false;
    });
    var box = Hive.box('jac');
    box.put('organization', content);
  }

  @override
  void initState() {
    var box = Hive.box('jac');
    if (box.get("organization") != null) {
      content = box.get("organization");
    } else {
      setState(() {
        showSpinner = true;
      });
    }
    super.initState();
    getContent();
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
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: content.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: getPages(index),
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }

  List getPages(int index) {
    List<Widget> pages = [
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: Text(
          content[index]["name"],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    ];
    for (var page in content[index]["pages"]) {
      pages.add(
        ListTile(
          title: Text(page["name"]),
          onTap: () async {
            try {
              await launchURL(context, page["url"]);
            } catch (e) {
              print(e);
            }
          },
        ),
      );
    }
    return pages;
  }
}
