import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    child: Image(
                      image: AssetImage("images/JAC.jpg"),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Головна"),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/");
                  },
                ),
                ListTile(
                  title: Text("Технологія"),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/technology");
                  },
                ),
                ListTile(
                  title: Text("Організація"),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/organization");
                  },
                ),
                ListTile(
                  title: Text("Процеси"),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/process");
                  },
                ),
                ListTile(
                  title: Text("Звітність"),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/reporting");
                  },
                ),
                ListTile(
                  title: Text("Проекти"),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/projects");
                  },
                ),
                ListTile(
                  title: Text("Навчання"),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/trainings");
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Команда ППО"),
            onTap: () {
              Navigator.popAndPushNamed(context, "/command-ppo");
            },
          ),
        ],
      ),
    );
  }
}
