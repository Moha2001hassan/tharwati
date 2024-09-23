import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../hive/hive_user_service.dart';
import '../../models/user.dart';
import '../user_firebase.dart';

class UserService {
  Future<MyUser?> fetchAndStoreUserData() async {
    try {
      String? userId = await getUserId();
      if (userId != null) { // true
        MyUser? updatedUser = await getUserData(userId);
        if (updatedUser != null) {
          print('Fetched User Data: ${updatedUser.toMap()}');  // Add debug output

          await storeUserLocally(updatedUser);
          return getUserFromLocal();
        } else {
          print('Error fetching and storing user data: User not found');
          return null;
        }
      }
    } catch (e) {
      print('Error fetching and storing user data: $e');
      return null;
    }
    return null;
  }


  Future<void> startGlobalTimer(int durationInSeconds) async {
    final DateTime networkTime = await NTP.now();
    final int startTime = networkTime.millisecondsSinceEpoch;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('prefStartTime', startTime);
    await prefs.setInt('prefDuration', durationInSeconds);
  }
}