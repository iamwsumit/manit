import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manitfirst/utils/storage.dart';
import 'package:manitfirst/utils/utility.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  late Utils utils;

  @override
  void initState() {
    utils = Utils(context: context);
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: Theme.of(context).brightness,
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 15,
                      children: [
                    Image.asset('assets/manit.png', height: 150, width: 150),
                    Text(
                      'MANIT Study Portal',
                      style: TextStyle(
                        fontFamily: 'regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Theme.of(context).textTheme.headlineSmall?.color,
                      ),
                    )
                  ])),
            )));
  }

  Future<void> fetchData() async {
    try {
      final client = http.Client();
      final response = await client
          .get(Uri.parse(
              "https://raw.githubusercontent.com/iamwsumit/manit/refs/heads/main/data.json"))
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          client.close();
          throw TimeoutException('Request timed out');
        },
      );

      if (response.statusCode == 200) {
        LocalStorage.writeString("data", response.body);
        openHome();
      } else {
        String existingData = LocalStorage.getString("data");
        if (existingData.isNotEmpty) {
          openHome();
        } else {
          Utils.showToast(msg: "Unable to fetch data");
          return; // Don't proceed further
        }
      }
    } on TimeoutException {
      String existingData = LocalStorage.getString("data");
      if (existingData.isNotEmpty) {
        openHome();
      } else {
        Utils.showToast(msg: "Request timed out. Please check your connection");
        return;
      }
    } catch (e) {
      debugPrint('$e');
      String existingData = LocalStorage.getString("data");
      if (existingData.isNotEmpty) {
        openHome();
      } else {
        Utils.showToast(msg: "Unable to fetch data");
        return;
      }
    }
  }

  void openHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }
}
