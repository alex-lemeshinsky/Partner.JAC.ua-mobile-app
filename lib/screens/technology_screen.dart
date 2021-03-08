import 'package:flutter/material.dart';
import 'package:jacua/widgets/main_drawer.dart';
import 'package:jacua/widgets/main_popup_menu_button.dart';
import 'package:jacua/widgets/data_search.dart';
import 'package:jacua/widgets/main_card.dart';
import 'package:jacua/constants/cars.dart';

class TechnologyScreen extends StatefulWidget {
  @override
  _TechnologyScreenState createState() => _TechnologyScreenState();
}

class _TechnologyScreenState extends State<TechnologyScreen> {
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
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return MainCard(
            "Технологія ${models[index]}",
            null,
            "images/${models[index]}.jpg",
            "/technology/${models[index]}",
            models[index],
          );
        },
        itemCount: models.length,
      ),
    );
  }
}
