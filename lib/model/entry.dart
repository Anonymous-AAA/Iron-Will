import 'package:intl/intl.dart';

class Entry{

  DateTime start,end;
  int days;
  String reason;


  Entry({ required this.start,required this.end,this.reason="",this.days=0})
  {
    days=end.difference(start).inDays;
  }

  factory Entry.fromJson(Map<String,dynamic> data) =>Entry(start: DateFormat("dd/MM/yyyy hh:mm a").parse(data["start"]), end: DateFormat("dd/MM/yyyy hh:mm a").parse(data["end"]),days: data["days"],reason: data["reason"]);

  Map<String,dynamic> toJson()=>{
    'start': DateFormat("dd/MM/yyyy hh:mm a").format(start),
    'end':DateFormat("dd/MM/yyyy hh:mm a").format(end),
    'days':days,
    'reason':reason
  };



}