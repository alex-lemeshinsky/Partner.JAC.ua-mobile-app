import 'package:flutter/material.dart';
import 'package:jacua/widgets/main_drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:jacua/widgets/main_popup_menu_button.dart';
import 'package:jacua/widgets/data_search.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:share/share.dart';

class CommandPPO extends StatefulWidget {
  @override
  _CommandPPOState createState() => _CommandPPOState();
}

class _CommandPPOState extends State<CommandPPO> {
  bool showSpinner = false;

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
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return cards[index];
          },
          itemCount: cards.length,
          viewportFraction: 0.9,
          scale: 0.9,
          loop: false,
        ),
      ),
    );
  }
}

List cards = [
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("images/SL.webp"),
      Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Сергій Лемешинський",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Директор з Післяпродажного обслуговування",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
                "Області відповідальності: загальне керівницвто ППО; розвиток та керівництво дилерської мережі; маркетинг сервісу; задоволеність клієнтів; навчання."),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.phone),
                  color: Colors.blueGrey,
                  iconSize: 60.0,
                  onPressed: () async {
                    const url = 'tel:+38 073 269 87 29';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.email),
                  color: Colors.blueGrey,
                  iconSize: 60.0,
                  onPressed: () async {
                    const url = 'mailto:serhii.lemeshynskyi@jac.ua';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                /*IconButton(
                  icon: Icon(Icons.share),
                  color: Colors.blueGrey,
                  iconSize: 60.0,
                  onPressed: () async {
                    Share.shareFiles(['files/Сергій_Лемешинський.vcf']);
                  },
                ),*/
              ],
            ),
          ],
        ),
      ),
    ],
  ),
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("images/DH.webp"),
      Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Дмитро Галка",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Начальник Відділу Післяпродажного Обслуговування",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
                "Зони відповідальності: Запчастини, Гарантія, Технічна допомога"),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.phone),
                  color: Colors.blueGrey,
                  iconSize: 60.0,
                  onPressed: () async {
                    const url = 'tel:+380732687835';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.email),
                  color: Colors.blueGrey,
                  iconSize: 60.0,
                  onPressed: () async {
                    const url = 'mailto:dmytro.halka@jac.ua';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                /*IconButton(
                  icon: Icon(Icons.share),
                  color: Colors.blueGrey,
                  iconSize: 60.0,
                  onPressed: () async {
                    Share.shareFiles(['files/Дмитро_Галка.vcf']);
                  },
                ),*/
              ],
            ),
          ],
        ),
      ),
    ],
  ),
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("images/JAC.jpg"),
      Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Peech software",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Developer of this app",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
                "If you have issues or feature request you can contact me on github."),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(MaterialCommunityIcons.github_circle),
                  color: Colors.blueGrey,
                  iconSize: 60.0,
                  onPressed: () async {
                    const url =
                        'https://github.com/alex-lemeshinsky/Partner.JAC.ua-mobile-app';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
];
