import 'dart:convert';

import 'package:manitfirst/utils/utility.dart';

class Data {
  static String data = '';

  static void setData(String data) {
    if (data.isEmpty) {
      Utils.showToast(
          msg:
              'Data is not available, please reopen the app to fetch the data');
    } else {
      Data.data = data;
    }
  }

  static Map<String, dynamic> getData() => json.decode(data);
}