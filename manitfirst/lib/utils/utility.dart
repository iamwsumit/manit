import 'dart:io';

import 'package:flutter/material.dart';

import 'package:manitfirst/utils/storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../comps/progress_dialog.dart';

class Utils {
  static bool prime = false;
  final BuildContext context;
  var dialog;

  static String goal = 'main';

  Utils({required this.context});

  showLoaderDialog() {
    dialog ??= const AlertDialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      insetPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 24),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      content: ProgressDialog(),
    );
    AlertDialog alert = dialog;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  dismissDialog() {
    Navigator.pop(context);
  }

  static Future launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      Utils.showToast(msg: 'Could not launch the webpage');
    }
  }

  static bool isDarkTheme() {
    return LocalStorage.getBool('theme');
  }

  static const String API = "https://app.iitexpress.com/v1/";
  static const Map<String, String> HEADERS = {
    'package': 'com.sumit.iitexpress'
  };

  static void launchDesktop() {}

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static void removeFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void showError(String msg) {
    showToast(msg: msg);
  }

  static void shareApp() {
    String message = '📚 MANIT first-years, unite! 🎉 First year hitting you hard? The Study Portal is here to save the day! 🙌 Get all notes, assignments, and PYPs in one place. No more frantic searching or hustle! 💻📱 Available on mobile & desktop, and it even works offline, so you can study on the go or from the comfort of your room, even without internet access! Download the MANIT Study Portal now.\n\nLink: https://manitfirst.web.app/download';
    Share.share(message);
  }

  static void showToast({required String msg, backgroundColor}) {
    toastification.show(
        title: Text(
          softWrap: true,
          textAlign: TextAlign.center,
          maxLines: 2,
          msg,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: 'regular'),
        ),
        backgroundColor: backgroundColor ?? Colors.black,
        style: ToastificationStyle.simple,
        autoCloseDuration: const Duration(seconds: 2),
        alignment: Alignment.bottomCenter,
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(25),
        animationDuration: const Duration(milliseconds: 300),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(opacity: animation, child: child);
        });
  }
}
