import 'package:flutter/material.dart';
import 'package:manitfirst/utils/storage.dart';
import 'package:manitfirst/utils/utility.dart';

class MyTheme extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xfff4f4f4),
    primaryColor: MyTheme.primary,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: MyTheme.primary,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
    dialogBackgroundColor: Colors.white,
    fontFamily: 'regular',
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      surfaceTintColor: Colors.black,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
          fontFamily: 'regular'),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xfff4f4f4)),
    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shadowColor: null,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xffE9EEF2), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textTheme: TextTheme(
        headlineSmall: TextStyle(color: Colors.black),
        bodySmall: TextStyle(
            fontFamily: 'regular', fontSize: 12, color: Colors.grey[600])),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xff212121),
    primaryColor: MyTheme.primary,
    dialogTheme: DialogTheme(
      backgroundColor: const Color(0xff212529),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      surfaceTintColor: Colors.white,
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
          fontFamily: 'regular'),
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[900]),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: MyTheme.primary,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    fontFamily: 'regular',
    cardTheme: CardTheme(
      color: Colors.transparent,
      elevation: 0,
      shadowColor: null,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: const Color(0x26ffffff))),
      margin: EdgeInsets.zero,
    ),
    textTheme: TextTheme(
        headlineSmall: TextStyle(color: Colors.white),
        bodySmall: TextStyle(
            fontFamily: 'regular', fontSize: 12, fontWeight: FontWeight.w400, color: Color(
            0xbfdee2e6))),
  );

  ThemeMode get themeMode => mode;

  MyTheme() {
    loadTheme();
  }

  loadTheme() async {
    try {
      mode = Utils.isDarkTheme() ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    } catch (e) {
      Utils.showToast(msg: "Error loading theme");
    }
  }

  setTheme() async {
    try {
      mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
      await LocalStorage.setBoolean('theme', mode == ThemeMode.dark);
    } catch (e) {
      mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
      Utils.showToast(msg: "Failed to change theme");
    }
  }

  static const Color primary = Colors.orange;
  static const Color halkaPrimary = Color(0xFFFFE0B2); // Lighter blue, fully opaque
}
