import 'package:flutter/material.dart';

void checkURL(context, url, controller) {
  if (url == "https://jacua.org/") {
    controller.goBack();
    Navigator.pushNamed(context, "/");
  } else if (url == "https://jacua.org/technology/") {
    print(ModalRoute.of(context).settings.name);
    controller.goBack();
    Navigator.pushNamed(context, "/technology");
    print(ModalRoute.of(context).settings.name);
  } else if (url == "https://jacua.org/organization/") {
    controller.goBack();
    Navigator.pushNamed(context, "/organization");
  } else if (url == "https://jacua.org/processes/") {
    controller.goBack();
    Navigator.pushNamed(context, "/process");
  }
  /*else if (url == "https://jacua.org/reporting/") {
    controller.goBack();
    Navigator.pushNamed(context, "/reporting");
  } else if (url == "https://jacua.org/projects/") {
    controller.goBack();
    Navigator.pushNamed(context, "/projects");
  } else if (url == "https://jacua.org/trainings/") {
    controller.goBack();
    Navigator.pushNamed(context, "/trainings");
  }*/
  else if (url == "https://jacua.org/processes/help/") {
    controller.goBack();
    Navigator.pushNamed(context, "/process/help");
  } else if (url ==
      "https://jacua.org/%d0%ba%d0%be%d0%bc%d0%b0%d0%bd%d0%b4%d0%b0-%d0%bf%d0%bf%d0%be/") {
    controller.goBack();
    Navigator.pushNamed(context, "/command-ppo");
  }
}
