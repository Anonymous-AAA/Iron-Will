import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:iron_will/controller/appdata.dart';
import 'package:iron_will/model/entry.dart';
import 'package:iron_will/model/settings.dart';

class CircularCounter extends StatefulWidget {
  const CircularCounter({
    Key? key,
  }) : super(key: key);

  @override
  _CircularCounterState createState() => _CircularCounterState();
}

class _CircularCounterState extends State<CircularCounter> {
  String reason = "";
  int daysPassed = AppData.days();

  // int days()
  // {
  //   return DateTime.now().difference(AppData.getSettings().dateTime).inDays;
  // }

  // int seconds() {
  //   return DateTime.now().difference(AppData.getSettings().dateTime).inSeconds %86400;
  // }

  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          children:[ 
            const Spacer(),
            CircularCountDownTimer(
          duration: 86400,
          initialDuration: AppData.seconds(),
          controller: _controller,
          width: MediaQuery.of(context).size.width / 1.35,
          height: MediaQuery.of(context).size.height / 1.35,
          ringColor: Colors.grey.withOpacity(0.25),
          ringGradient: null,
          fillColor: Theme.of(context).colorScheme.primary,
          fillGradient: null,
          backgroundColor: Colors.transparent,
          backgroundGradient: null,
          strokeWidth: 7.5,
          strokeCap: StrokeCap.square,
          textStyle: TextStyle(
            fontSize: 25.0,
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.normal,
          ),
          textFormat: CountdownTextFormat.HH_MM_SS,
          isReverse: false,
          isReverseAnimation: false,
          isTimerTextShown: true,
          autoStart: true,

          onStart: () {
            // print('Countdown Started');
          },
          onComplete: () {
            setState(() {
              daysPassed = AppData.days();
              _controller.restart();
            });
          },
        ),
        const Spacer(),
        
          ]
        
        ),
        
        Positioned(
          child: Text(
            "$daysPassed ${daysPassed == 1 ? "day" : "days"}",
            style: TextStyle(
                fontSize: 40.0,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          top: 200,
        ),
        
        Positioned(
          child:SizedBox(
            child:Text(
            AppData.currentRank(),
            style:TextStyle(

                fontSize: 25.0,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal),
                textAlign: TextAlign.center,
                 ),
                 width:MediaQuery.of(context).size.width / 1.7,
                 ),
           
          top:350 ,
          ),
        Positioned(
          child: ElevatedButton(
            onPressed: () {
              openDialog();
              setState(() {
                daysPassed = AppData.days();
              });
            },
            child: const Icon(
              Icons.replay,
              color: Colors.black,
            ),
            style: ElevatedButton.styleFrom(primary: Colors.redAccent,
            fixedSize: const Size(60, 25)),
          ),
          top: 350,
          right: 0 ,

          
        )
      ],
      alignment: AlignmentDirectional.topCenter,
      
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Reset"),
          content: TextField(
            decoration: const InputDecoration(hintText: "reason/short note"),
            onChanged: (str) {
              setState(() {
                reason = str;
              });
            },
          ),
          actions: [
            TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
                child: const Text("Reset"),
                onPressed: () async {
                  DateTime t = DateTime.now();
                  await AppData.addEntry(Entry(
                      start: AppData.getSettings().dateTime,
                      end: t,
                      reason: reason));
                  await AppData.updateSettings(
                      Settings(dateTime: t, dark: AppData.getSettings().dark));
                  _controller.restart();
                  Navigator.of(context).pop();
                })
          ],
        ),
      );
}
