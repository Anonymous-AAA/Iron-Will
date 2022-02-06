import 'package:flutter/material.dart';
import 'package:iron_will/controller/appdata.dart';
import 'package:iron_will/view/Rank/rank.dart';
import 'package:iron_will/view/history/history_page.dart';
import 'package:iron_will/view/home/circular_counter.dart';
import 'package:iron_will/view/settings/settings_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Iron Will'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  ).then((value) => setState(() {}));
                },
                icon: const Icon(Icons.settings))
          ],
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,

        ),
        body: Column(
          children: [
            Center(
              heightFactor: 0.75,
              child: CircularCounter(key: UniqueKey(),),
            ),
            const SizedBox(height: 15,),
            SizedBox(
              child:Padding(
                padding:const EdgeInsets.only(left: 10,right: 10),
                child: Text(
                  AppData.getQuote(),
                  style:const TextStyle(fontSize: 20, fontStyle: FontStyle.italic,),
                  textAlign:TextAlign.center,
                ),
              ),
              height: 125,
            ),

            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Rank(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.star,
                    size: 18,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  label:const Text(
                    "My Rank",
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.history,
                    size: 18,
                    color: Theme.of(context).colorScheme.secondary,

                  ),
                  label:const Text(
                    "History",
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                )
              ],
            )
          ],
        ),
        resizeToAvoidBottomInset: false);
  }
}
