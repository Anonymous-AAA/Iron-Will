import 'dart:convert';
import 'dart:math';
import 'package:iron_will/model/entry.dart';
import 'package:iron_will/model/rank.dart';
import 'package:iron_will/model/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static final List<Rank> _globalRankList = [
    Rank(name: "Just Started", days: 0),
    Rank(name: "Scout", days: 1),
    Rank(name: "Private", days: 3),
    Rank(name: "Corporal", days: 5),
    Rank(name: "Sergeant", days: 7),
    Rank(name: "Master Sergeant", days: 10),
    Rank(name: "Knight", days: 14),
    Rank(name: "Knight-Lieutenant", days: 21),
    Rank(name: "Knight-Captain", days: 30),
    Rank(name: "Knight-Champion", days: 60),
    Rank(name: "Champion of the Light", days: 90),
    Rank(name: "Commander", days: 120),
    Rank(name: "Conqueror", days: 150),
    Rank(name: "Marshal", days: 180),
    Rank(name: "Field Marshal", days: 240),
    Rank(name: "Grand Marshal", days: 300),
    Rank(name: "High Overload", days: 365),
    Rank(name: "The Immortal", days: 500),
    Rank(name: "Infinity", days: 99999999999)
  ];

  static final List<String> _quotes = [
    '“Nothing is impossible. The word itself says \'I\'m possible!\'”\n\n— Audrey Hepburn',
    '“There is nothing impossible to they who will try.”\n\n— Alexander the Great',
    '"The best time to plant a tree was 20 years ago.The second best time is now."\n\n— Chinese proverb',
    '“The bad news is time flies. The good news is you\'re the pilot.”\n\n— Michael Altshuler',
    '“Keep your face always toward the sunshine, and shadows will fall behind you.”\n\n— Walt Whitman',
    '“Success is not final, failure is not fatal: it is the courage to continue that counts.”\n\n— Winston Churchill',
    '“Belief creates the actual fact.”\n\n— William James'
  ];

  static List<Entry> _entryList = [];
  static List<Settings> _settingsList = [];

  static List<String> _jsonSettings = [];
  static late SharedPreferences _sharedPreferences;
  static List<String> _jsonEntryList = [];

  static Future<void> initEntry() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    final _tempJsonEntryList = _sharedPreferences.getStringList("entryList");
    final _tempJsonSettings = _sharedPreferences.getStringList("iron_settings");
    if (_tempJsonEntryList != null) {
      _jsonEntryList = _tempJsonEntryList;
      _entryList =
          _tempJsonEntryList.map((e) => Entry.fromJson(jsonDecode(e))).toList();
    }
    if (_tempJsonSettings != null) {
      _jsonSettings = _tempJsonSettings;
      _settingsList = _tempJsonSettings
          .map((e) => Settings.fromJson(jsonDecode(e)))
          .toList();
    } else {
      final init = Settings(dateTime: DateTime.now());
      _settingsList = [init];
      _jsonSettings.add(jsonEncode(init));
      await _sharedPreferences.setStringList("iron_settings", _jsonSettings);
    }
  }

  static List<Entry> getEntry() {
    return _entryList.reversed.toList();
  }

  static Settings getSettings() {
    return _settingsList[0];
  }

  static Future<void> updateSettings(Settings settings) async {
    _settingsList = [settings];
    _jsonSettings = [jsonEncode(settings)];

    await _sharedPreferences.setStringList('iron_settings', _jsonSettings);
  }

  static Future<void> addEntry(Entry entry) async {
    _entryList.add(entry);
    _jsonEntryList.add(jsonEncode(entry));

    await _sharedPreferences.setStringList('entryList', _jsonEntryList);
  }

  static Future<void> clearEntries() async {
    _entryList = [];
    _jsonEntryList = [];

    await _sharedPreferences.setStringList('entryList', _jsonEntryList);
  }

  static List<Rank> getRank() {
    return _globalRankList;
  }

  static String getQuote() {
    var rng = Random();

    return _quotes[rng.nextInt(_quotes.length)];
  }

  static int days() {
    return DateTime.now().difference(_settingsList[0].dateTime).inDays;
  }

  static int seconds() {
    return DateTime.now().difference(_settingsList[0].dateTime).inSeconds %
        86400;
  }

  static bool colour(int index) {
    int k = days();
    if (k >= _globalRankList[index].days &&
        k < _globalRankList[index + 1].days) {
      return true;
    }

    return false;
  }

  static String currentRank() {
    int k = days();
    for (int index = 0; index < _globalRankList.length; index++) {
      if (k >= _globalRankList[index].days &&
          k < _globalRankList[index + 1].days) {
        return _globalRankList[index].name;
      }

      
    }
    return "";
  }
}
