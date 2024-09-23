import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/constants/constants.dart';
import '../../hive/hive_user_service.dart';
import '../../models/user.dart';
import '../user_firebase.dart';

class GlobalTimerService { // 86400
  static const int totalDurationInSeconds = 86400;
  static const String timerStatusKey = 'timer_status';

  Future<int?> loadStartTime() async {
    final uid = await getUserId();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("$prefStartTime/$uid");
  }

  Future<int> loadDuration() async {
    final uid = await getUserId();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("$prefDuration/$uid") ?? totalDurationInSeconds;
  }

  Future<void> saveStartTime(int startTime) async {
    final uid = await getUserId();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("$prefStartTime/$uid", startTime);
    await prefs.setInt("$prefDuration/$uid", totalDurationInSeconds);
  }

  Future<MyUser?> refetchAndStoreUserData() async {
    String? userId = await getUserId();
    if (userId != null) {
      MyUser? updatedUser = await getUserData(userId);
      if (updatedUser != null) {
        await storeUserLocally(updatedUser);
        return updatedUser;
      }
    }
    return null;
  }

  // Method to save the timer status ("on" or "off")
  Future<void> saveTimerStatus(String status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(timerStatusKey, status);
  }

  // Method to load the timer status ("on" or "off")
  Future<String?> loadTimerStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(timerStatusKey);
  }
}
