import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sendEmailVerification(User? user) async {
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await saveLoginStatus(false);
  }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> deleteAccount() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await user.delete();
        await saveLoginStatus(false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          // You need to prompt the user to re-authenticate and then try deleting again
          throw Exception('The user needs to re-authenticate before deleting the account.');
        }
      }
    }
  }

  Future<bool> reAuthenticateAndDelete(String password) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email != null) {
      try {
        // Re-authenticate the user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
        await FirebaseAuthService().deleteAccount();
        return true;
      } on FirebaseAuthException catch (e) {
        // Handle errors like wrong password, etc.
        print("Error during re-authentication: ${e.message}");
        return false;
      }
    }
    return false;
  }
// Add other authentication functions as needed
}
