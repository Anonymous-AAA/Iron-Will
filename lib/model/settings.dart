import 'package:intl/intl.dart';

class Settings{

  bool dark;
  DateTime dateTime;

  Settings({this.dark=false,required this.dateTime});

  factory Settings.fromJson(Map<String,dynamic> data) =>Settings(dark:data['dark'],dateTime: DateFormat("dd/MM/yyyy hh:mm a").parse(data['dateTime']) );

  Map<String,dynamic> toJson()=>{
   'dark':dark,
    'dateTime':DateFormat("dd/MM/yyyy hh:mm a").format(dateTime)
  };

  // void toggleDarkMode()
  // {
  //   dark=!dark;
  // }
  


}