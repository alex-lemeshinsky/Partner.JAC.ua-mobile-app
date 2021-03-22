import 'package:flutter/material.dart';
import 'package:jacua/widgets/main_drawer.dart';
import 'package:jacua/widgets/main_popup_menu_button.dart';
import 'package:jacua/widgets/data_search.dart';
import 'package:jacua/widgets/main_card.dart';
import 'package:jacua/constants/cars.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TechnologyScreen extends StatefulWidget {
  @override
  _TechnologyScreenState createState() => _TechnologyScreenState();
}

class _TechnologyScreenState extends State<TechnologyScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> _models = models;

    if (!_models.contains("Технічні бюлетені")) {
      _models.add("Технічні бюлетені");
      _models.add("Спеціальний інструмент");
      _models.add("Коди красок");
    }

    int getCrossAxisCount(context) {
      int crossAxisCount;
      if (MediaQuery.of(context).size.width < 600) {
        crossAxisCount = 1;
      } else if (MediaQuery.of(context).size.width >= 600 &&
          MediaQuery.of(context).size.width < 1000) {
        crossAxisCount = 2;
      } else if (MediaQuery.of(context).size.width >= 1000) {
        crossAxisCount = 3;
      }
      return crossAxisCount;
    }

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
      body: StaggeredGridView.countBuilder(
        crossAxisCount: getCrossAxisCount(context),
        itemCount: _models.length,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        itemBuilder: (BuildContext context, int index) {
          return MainCard(
            "Технологія ${_models[index]}",
            null,
            "images/${_models[index]}.jpg",
            "/technology/${_models[index]}",
            _models[index],
            getCrossAxisCount(context),
          );
        },
      ),
    );
  }
}
