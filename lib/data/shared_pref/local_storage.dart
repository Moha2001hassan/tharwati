import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveIsGuest(bool isGuest) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isGuest', isGuest);
}
Future<bool> getIsGuest() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isGuest') ?? false;
}