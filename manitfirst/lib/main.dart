import 'package:flutter/material.dart';
import 'package:manitfirst/splash.dart';
import 'package:manitfirst/utils/storage.dart';
import 'package:manitfirst/utils/theme.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.initialize();

  final MyTheme theme = MyTheme();
  await theme.loadTheme();
  OneSignal.initialize('18f8141f-389d-447e-89c5-d2b3f1e124e6');
  runApp(ChangeNotifierProvider(
      create: (context) => MyTheme(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyTheme>(builder: (context, theme, _) {
      return ToastificationWrapper(child:MaterialApp(
        title: 'Manit Study Portal',
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: theme.mode,
        debugShowCheckedModeBanner: false,
        home: const Splash(),
      ));
    });
  }
}