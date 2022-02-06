import 'package:flutter/material.dart';
import 'package:iron_will/controller/appdata.dart';
import 'package:iron_will/view/home/home.dart';
import 'package:flutter/services.dart';
import 'model/themes.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppData.initEntry();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const Home(),
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        
        
    );
  }

}
