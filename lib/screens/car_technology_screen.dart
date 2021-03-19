import 'package:flutter/material.dart';
import 'package:jacua/widgets/main_drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:jacua/functions/launch_url.dart';
import 'package:jacua/functions/wp-api.dart';
import 'package:hive/hive.dart';

class CarTechologyScreen extends StatefulWidget {
  final String car;

  CarTechologyScreen(this.car);

  @override
  _CarTechologyScreenState createState() => _CarTechologyScreenState();
}

class _CarTechologyScreenState extends State<CarTechologyScreen> {
  bool showSpinner = false;
  Map cars = {
    "S2": {},
    "S3": {},
    "S4": {},
    "S5": {},
    "J2": {},
    "J4": {},
    "J5": {},
    "T8": {},
    "IEV7S": {},
    "Sunray": {},
    "N56": {},
    "N75": {},
    "N120": {},
    "Технічні бюлетені": {},
    "Спеціальний інструмент": {},
    "Коди красок": {},
  };

  void getCarTechnology() async {
    cars = await fetchCarsTechonlogy();
    try {
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }
    var box = Hive.box('jac');
    box.put('cars', cars);
  }

  @override
  void initState() {
    var box = Hive.box('jac');
    if (box.get("cars") != null) {
      cars = box.get("cars");
    } else {
      showSpinner = true;
    }
    super.initState();
    getCarTechnology();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.car != "Технічні бюлетені" &&
        widget.car != "Спеціальний інструмент" &&
        widget.car != "Коди красок") {
      return Scaffold(
        drawer: MainDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width / 16 * 9,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(
                    "Технологія ${widget.car}",
                    style: TextStyle(color: Colors.white),
                  ),
                  background: Hero(
                    tag: widget.car,
                    child: Image.asset(
                      "images/${widget.car}.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: ListView.builder(
              itemCount: cars[widget.car].keys.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(cars[widget.car].keys.toList()[index]),
                  onTap: () async {
                    try {
                      await launchURL(
                          context, cars[widget.car].values.toList()[index]);
                    } catch (e) {
                      print(e);
                    }
                  },
                );
              },
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text(
            "${widget.car}",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: ListView.builder(
            itemCount: cars[widget.car].keys.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(cars[widget.car].keys.toList()[index]),
                onTap: () async {
                  try {
                    await launchURL(
                        context, cars[widget.car].values.toList()[index]);
                  } catch (e) {
                    print(e);
                  }
                },
              );
            },
          ),
        ),
      );
    }
  }
}
