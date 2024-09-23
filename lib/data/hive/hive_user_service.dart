import 'package:hive_flutter/adapters.dart';
import '../../utils/constants/keys.dart';
import '../models/user.dart';

Future<void> storeUserLocally(MyUser user) async {
  var box = await Hive.openBox<MyUser>(MyKeys.userBox);
  await box.put(MyKeys.currentUser, user);
}

Future<void> saveUserId(String userId) async {
  var box = await Hive.openBox<String>(MyKeys.userIdBox);
  await box.put(MyKeys.userId, userId);
}

Future<String?> getUserId() async {
  var idBox = await Hive.openBox<String>(MyKeys.userIdBox);
  return idBox.get(MyKeys.userId);
}


Future<MyUser?> getUserFromLocal() async {
  try {
    var box = await Hive.openBox<MyUser>(MyKeys.userBox);
    return box.get(MyKeys.currentUser);
  } catch (e) {
    print("Error retrieving user from Hive: $e");
    return null;
  }
}

Future<void> updateUserIfExists(MyUser user) async {
  var box = await Hive.openBox<MyUser>(MyKeys.userBox);
  if (box.containsKey(MyKeys.currentUser)) {
    await box.put(MyKeys.currentUser, user);
  } else {
    print("No user found to update.");
  }
}

