import 'package:flutter/material.dart';
import 'package:iron_will/view/history/history_page_element.dart';
import 'package:iron_will/controller/appdata.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text("History"),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text("Clear History"),
                value: 0,
              )
            ],
            onSelected: (value) {
             
              openDialog();

              
            },
          )
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return HistoryPageElement(entry: AppData.getEntry()[index]);
        },
        itemCount: AppData.getEntry().length,
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Clear History"),
          content: const Text("Are you sure to clear history?"),
          actions: [
            TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
                child: const Text("OK"),
                onPressed: () async {
                  await AppData.clearEntries();
                  setState(() {});
                  Navigator.of(context).pop();
                })
          ],
        ),
      );
}
