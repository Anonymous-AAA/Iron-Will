import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iron_will/controller/appdata.dart';
import 'package:iron_will/model/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  DateTime? date;
  TimeOfDay? time;
  late final DateTime dateTime;

  String getText() {
    // if(dateTime==null){
    //   return 'Select DateTime';
    // }
    // else
    //   return DateFormat("dd/MM/yyyy hh:mm a").format(dateTime!);
    return DateFormat("dd/MM/yyyy hh:mm a")
        .format(AppData.getSettings().dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
            icon: const  Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(padding:const EdgeInsets.only(left: 5,right: 5),
          child:Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Dark Theme",
              //       style: TextStyle(fontSize: 20, color: Colors.blueGrey[75]),
              //     ),
              //     Switch(
              //         value: AppData.getSettings().dark,
              //         onChanged: (change) {
              //           setState(() {
              //             AppData.updateSettings(Settings(
              //                 dateTime: AppData.getSettings().dateTime,
              //                 dark: !AppData.getSettings().dark));
              //           });
              //         })
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Start date and time",
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey[75]),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        pickDateTime(context);
                      },
                      child: Text(
                        getText(),
                        style: const TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      )),
                ],
              )
            ],
          ),
      ),

    );
  }

  Future<void> pickDate(BuildContext context) async {
    final initialDate = AppData.getSettings().dateTime;
    final newDate = await showDatePicker(
        context: context,
        initialDate: date ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now());
    if (newDate == null) return;

    setState(() {
      date = newDate;
    });
  }

  Future<void> pickTime(BuildContext context) async {
    const initialTime =  TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context, initialTime: time ?? initialTime);

    if (newTime == null) return;

    setState(() {
      time = newTime;
    });
  }

  Future pickDateTime(BuildContext context) async {
    await pickDate(context);
    if (date == null) return;

    await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
          date!.year, date!.month, date!.day, time!.hour, time!.minute);

      AppData.updateSettings(
          Settings(dateTime: dateTime, dark: AppData.getSettings().dark));
    });
  }
}
