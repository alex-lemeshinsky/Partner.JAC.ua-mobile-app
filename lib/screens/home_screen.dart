import 'package:flutter/material.dart';
import 'package:jacua/widgets/main_drawer.dart';
import 'package:jacua/widgets/main_card.dart';
import 'package:jacua/widgets/data_search.dart';
import 'package:jacua/widgets/main_popup_menu_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  int getCrossAxisCount(context) {
    int crossAxisCount;
    if (MediaQuery.of(context).size.width < 800) {
      crossAxisCount = 1;
    } else if (MediaQuery.of(context).size.width >= 800) {
      crossAxisCount = 2;
    }
    return crossAxisCount;
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
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
      body: StaggeredGridView.count(
        crossAxisCount: getCrossAxisCount(context),
        children: [
          MainCard(
            "Технологія",
            "Знання технології технічного обслуговування та ремонту є основою успішної реалізації робіт в сервісі.",
            "images/technology.webp",
            "/technology",
            null,
          ),
          MainCard(
            "Організація",
            "Правільна організація сервсу є основою для задоволенності клієнтів та прибутковості дилера або сервісного партрнера.",
            "images/organization.webp",
            "/organization",
            null,
          ),
          MainCard(
            "Процеси",
            "Оновою эффективних процесів на дилерському підприєтсві є регламанети. Слідуючи регламентам Ви достягнете успіху.",
            "images/process.webp",
            "/process",
            null,
          ),
          MainCard(
            "Звітність",
            "Звітніть є основю для сбору статистики та подальшого аналізу та планування ринку",
            "images/reporting.webp",
            "/reporting",
            "",
          ),
          MainCard(
            "Проекти",
            "Завжди є простір для покращень. Робіть завдання в рамках проектів дистрибютера, і ви вийдете на нові щаблі прибутковості та задоволеності кієнтів.",
            "images/projects.webp",
            "/projects",
            null,
          ),
          MainCard(
            "Навчання",
            "Світ і автомобільна техніка постійно розвиваються. Єдина можливість бути в русі цих змін – це постійне навчання!",
            "images/training.webp",
            "/trainings",
            null,
          ),
        ],
        staggeredTiles: const <StaggeredTile>[
          const StaggeredTile.fit(1),
          const StaggeredTile.fit(1),
          const StaggeredTile.fit(1),
          const StaggeredTile.fit(1),
          const StaggeredTile.fit(1),
          const StaggeredTile.fit(1),
        ],
      ),
    );
  }
}
