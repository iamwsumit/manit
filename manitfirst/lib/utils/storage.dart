import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static Future initialize() async {
    await Hive.initFlutter();
    await Hive.openBox('iit_express');
  }

  static void writeString(String key, String value) {
    Hive.box('iit_express').put(key, value);
  }

  static Future setBoolean(String key, bool value) async {
    await Hive.box('iit_express').put(key, value);
  }

  static bool getBool(String key) {
    return Hive.box('iit_express').get(key, defaultValue: false);
  }

  static String getString(String key) {
    final val = Hive.box('iit_express').get(key);
    return val ?? '';
  }

  static void clearStorage() {
    Hive.deleteBoxFromDisk('iit_express');
  }
}