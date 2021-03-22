import 'package:flutter/material.dart';
import 'package:jacua/widgets/main_drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:jacua/widgets/main_popup_menu_button.dart';
import 'package:jacua/widgets/data_search.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:jacua/constants/cars.dart';
import 'package:jacua/widgets/main_dialog.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jacua/functions/wp-api.dart';
import 'dart:convert';

class ReportingScreen extends StatefulWidget {
  @override
  _ReportingScreenState createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  bool showSpinner = false;
  DateTime _dateTime = DateTime.now();
  String _vin;
  String _model;
  String _year;
  String _mileage;

  List<bool> _laborTypeSelected = [false, false, false, false, false, false];

  List<bool> _laborDetailsSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  String _dealerCode;
  bool _dealerCodeFieldEnabled = true;
  String _dealerName;
  bool _dealerNameFieldEnabled = true;
  String _email;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<String> _models = models;
    _models.add("value");

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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              DateTimeField(
                format: DateFormat("dd-MM-yyyy"),
                initialValue: _dateTime,
                decoration: InputDecoration(labelText: 'Дата автомобілезаїзду'),
                onChanged: (dt) => setState(() {
                  if (dt != null) {
                    setState(() {
                      _dateTime = dt;
                    });
                  }
                }),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                    context: context,
                    initialDate: _dateTime,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                  );
                },
                validator: (value) {
                  if (value == null) {
                    return "Поле обов'язкове для заповнення";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                maxLength: 17,
                decoration: InputDecoration(
                  labelText: "VIN автомобіля",
                  hintText: "Можна маленькими літерами",
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Поле обов'язкове для заповнення";
                  } else if (value.length < 17) {
                    return "Неправильний VIN код";
                  }
                  return null;
                },
                onSaved: (String value) {
                  _vin = value.toUpperCase();
                },
                onChanged: (String value) {
                  try {
                    if (value.length > 9) {
                      if (value[9].toUpperCase() == "D") {
                        _year = "2013";
                      } else if (value[9].toUpperCase() == "E") {
                        _year = "2014";
                      } else if (value[9].toUpperCase() == "F") {
                        _year = "2015";
                      } else if (value[9].toUpperCase() == "G") {
                        _year = "2016";
                      } else if (value[9].toUpperCase() == "H") {
                        _year = "2017";
                      } else if (value[9].toUpperCase() == "J") {
                        _year = "2018";
                      } else if (value[9].toUpperCase() == "K") {
                        _year = "2019";
                      } else if (value[9].toUpperCase() == "L") {
                        _year = "2020";
                      } else if (value[9].toUpperCase() == "M") {
                        _year = "2021";
                      } else if (value[9].toUpperCase() == "N") {
                        _year = "2022";
                      }
                    }
                  } catch (e) {}
                },
              ),
              SizedBox(height: 8),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: "Модель автомобіля"),
                items: _models.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  },
                ).toList(),
                value: _model,
                onChanged: (String value) {
                  setState(() {
                    _model = value;
                  });
                },
                onSaved: (String value) {
                  _model = value;
                },
                validator: (String value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Поле обов'язкове для заповнення";
                    }
                  } else {
                    return "Поле обов'язкове для заповнення";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Пробіг на момент автомобілезаїзду"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Поле обов'язкове для заповнення";
                  }
                  return null;
                },
                onSaved: (String value) {
                  _mileage = value;
                },
              ),
              SizedBox(height: 8),
              FormField(
                builder: (FormFieldState state) {
                  return ListTile(
                    title: Text("Тип робіт"),
                    onTap: () {
                      _showDialog(
                          context, "Тип робіт", laborTypes, _laborTypeSelected);
                    },
                  );
                },
                validator: (value) {
                  if (_laborTypeSelected.indexOf(true) != -1) {
                    return null;
                  } else {
                    _showDialog(
                        context, "Тип робіт", laborTypes, _laborTypeSelected);
                  }
                  return null;
                },
              ),
              FormField(
                builder: (FormFieldState state) {
                  return ListTile(
                    title: Text("Деталізація ремонтних робіт"),
                    onTap: () {
                      _showDialog(context, "Деталізація ремонтних робіт",
                          laborDetails, _laborDetailsSelected);
                    },
                  );
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Код дилера"),
                enabled: _dealerCodeFieldEnabled,
                onSaved: (newValue) {
                  _dealerCode = newValue;
                },
                onChanged: (String value) {
                  setState(() {
                    _dealerNameFieldEnabled = false;
                  });
                },
                validator: (value) {
                  // ignore: unnecessary_null_comparison
                  if (value.isEmpty && _dealerCode == null) {
                    return "Одне з цих полів має бути заповнене";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Назва дилера",
                    hintText: "Заповнюється у випадку відсутності коду дилера"),
                enabled: _dealerNameFieldEnabled,
                onSaved: (newValue) {
                  _dealerName = newValue;
                },
                onChanged: (String value) {
                  setState(() {
                    _dealerCodeFieldEnabled = false;
                  });
                },
                validator: (value) {
                  // ignore: unnecessary_null_comparison
                  if (_dealerCode == null && value.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Ваш email"),
                onSaved: (newValue) {
                  _email = newValue;
                },
                validator: MultiValidator(
                  [
                    RequiredValidator(
                        errorText: "Поле обов'язкове для заповнення"),
                    EmailValidator(errorText: "Неправильно введений email")
                  ],
                ),
              ),
              ElevatedButton(
                child: Text("ВІДПРАВИТИ"),
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    //return;
                  }

                  setState(() {
                    showSpinner = true;
                  });

                  _formKey.currentState.save();

                  var responce = await postReport(
                    _dateTime.toString().substring(0, 10),
                    _vin,
                    _year,
                    _model,
                    _mileage,
                    _getLaborTypes(),
                    _getLaborDetails(),
                    _dealerCode,
                    _dealerName,
                    _email,
                  );

                  Map parsedResponce = jsonDecode(responce.body);

                  setState(() {
                    showSpinner = false;
                  });
                  if (parsedResponce["status"] == "mail_sent") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Успішно надіслано!')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Помилка! ${parsedResponce["status"]}')));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _showDialog(BuildContext context, title, itemsName, itemsSelected) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return MainDialog(title, itemsName, itemsSelected);
      },
    );
  }

  List<String> _getLaborTypes() {
    List<String> _laborTypes = [];
    for (var index = 0; index < _laborTypeSelected.length; index++) {
      if (_laborTypeSelected[index]) {
        _laborTypes.add(laborTypes[index]);
      }
    }
    return _laborTypes;
  }

  List<String> _getLaborDetails() {
    List<String> _laborDetails = [];
    for (var index = 0; index < _laborDetailsSelected.length; index++) {
      if (_laborDetailsSelected[index]) {
        _laborDetails.add(laborDetails[index]);
      }
    }
    return _laborDetails;
  }
}
