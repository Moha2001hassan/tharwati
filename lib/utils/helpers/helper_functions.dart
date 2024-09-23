import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

class MyHelperFunctions {
  static bool isDarkMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  String formatDuration(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }

  static Future<DateTime> calculateExpireDate(int monthsNumber) async {
    DateTime currentTime = await NTP.now();
    return currentTime.add(Duration(days: monthsNumber * 30));
  }

}
