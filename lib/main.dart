import 'package:flutter/material.dart';
import 'package:jacua/screens/home_screen.dart';
import 'package:jacua/screens/technology_screen.dart';
import 'package:jacua/screens/car_technology_screen.dart';
import 'package:jacua/screens/organization_screen.dart';
import 'package:jacua/screens/process_screen.dart';
import 'package:jacua/screens/reporting_screen.dart';
import 'package:jacua/screens/projects_screen.dart';
import 'package:jacua/screens/trainings_screen.dart';
import 'package:jacua/screens/command_ppo.dart';
//import 'widgets/custom_webview.dart';
import 'screens/support_screen.dart';
import 'screens/pdi_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.openBox("jac");
  runApp(JAC());
}

class JAC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => HomeScreen(),
        "/technology": (context) => TechnologyScreen(),
        "/organization": (context) => OrganizationScreen(),
        "/process": (context) => ProcessScreen(),
        "/reporting": (context) => ReportingScreen(),
        "/projects": (context) => ProjectsScreen(),
        "/trainings": (context) => TrainingsScreen(),
        "/command-ppo": (context) => CommandPPO(),
      },
      // ignore: missing_return
      onGenerateRoute: (settings) {
        var path = settings.name.split("/");
        if (path[1] == "technology") {
          return MaterialPageRoute(
            builder: (context) => CarTechologyScreen(path[2]),
            settings: settings,
          );
        } else if (path[1] == "process") {
          if (path[2] == "help") {
            return MaterialPageRoute(
              builder: (context) => SupportScreen(),
              settings: settings,
            );
          } else if (path[2] == "pdi") {
            return MaterialPageRoute(
              builder: (context) => PdiScreen(),
              settings: settings,
            );
          }
        }
      },
    );
  }
}
