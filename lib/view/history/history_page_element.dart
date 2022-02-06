import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iron_will/model/entry.dart';


class HistoryPageElement extends StatelessWidget {
  const HistoryPageElement({Key? key,
  required this.entry,
  }) : super(key: key);

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return Card(


        child:ListTile(
          isThreeLine: true,
          title:Text("${entry.days} ${entry.days==1?"day":"days"}",textAlign:TextAlign.left,),
          subtitle: Text("${DateFormat("dd/MM/yyyy hh:mm a").format(entry.start)} --> ${DateFormat("dd/MM/yyyy hh:mm a").format(entry.end)}\n${entry.reason}",textAlign:TextAlign.left),

        )


    );
  }
}
