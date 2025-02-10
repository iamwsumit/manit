import 'package:flutter/material.dart';
import 'package:manitfirst/utils/storage.dart';
import 'package:manitfirst/utils/utility.dart';

class MyTheme extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  static final lightTheme = ThemeData(
    useMaterial3: true,
    disabledColor: Colors.grey,
    unselectedWidgetColor: Colors.grey,
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
          fontFamily: 'open'),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xfff4f4f4)),
    chipTheme: const ChipThemeData(
        backgroundColor: Colors.white,
        side: BorderSide(width: 1, color: Colors.grey)),
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
    textTheme: const TextTheme(headlineSmall: TextStyle(color: Colors.black)),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    disabledColor: Colors.grey[850],
    unselectedWidgetColor: const Color(0xffF7F2FA),
    scaffoldBackgroundColor: const Color(0xff212529),
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
          fontFamily: 'open'),
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
    radioTheme: const RadioThemeData(
        fillColor: WidgetStatePropertyAll(MyTheme.primary)),
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
    fontFamily: 'Open',
    chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[850],
        side: const BorderSide(width: 1, color: Color(0xffF7F2FA))),
    cardTheme: CardTheme(
      color: const Color(0xff212529),
      elevation: 0,
      shadowColor: null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: const Color(0x26ffffff))
      ),
      margin: EdgeInsets.zero,
    ),
    textTheme: const TextTheme(headlineSmall: TextStyle(color: Colors.white)),
  );

  ThemeMode get themeMode => mode;

  MyTheme() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    try {
      mode = Utils.isDarkTheme() ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    } catch (e) {
      Utils.showToast(msg: "Error loading theme");
    }
  }

  Future<void> setTheme() async {
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

  static const Color halkaPrimary =
      Color(0x260067ff); // Lighter blue, fully opaque
  static const Color primary = Color(0xFF388E3C);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color errorLightColor = Color(0x40D32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color successLight = Color(0x40388E3C);
  static const Color reviewColor = Color(0xFF5D3FD3);
  static const Color reviewLightColor = Color(0x405D3FD3);
}
