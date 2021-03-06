import 'package:flutter/material.dart';
import 'package:jacua/functions/launch_url.dart';

class MainPopupMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem(
          value: "/process/parts",
          child: Text("Замовлення запчастин"),
        ),
        PopupMenuItem(
          value: "/process/warranty",
          child: Text("Відшкодування по гарантії"),
        ),
        PopupMenuItem(
          value: "/process/help",
          child: Text("Технічна допомога"),
        ),
      ],
      onSelected: (String value) async {
        if (value == "/process/help") {
          Navigator.pushNamed(
            context,
            value,
          );
        } else {
          try {
            await launchURL(context, "https://jacua.org$value/#main");
          } catch (e) {
            print(e);
          }
        }
      },
    );
  }
}
