import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tharwati/data/shared_pref/local_storage.dart';
import 'package:tharwati/utils/helpers/navigation.dart';
import '../../../data/datasources/auth_firebase.dart';
import '../../../data/datasources/user_firebase.dart';
import '../../../data/hive/hive_user_service.dart';
import '../../../data/models/user.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/handle_auth_error.dart';
import '../../../utils/routing/routes.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo, Title & Subtitle
                const LoginHeader(),

                // Form
                const LoginForm(),

                MaterialButton(
                  color: Colors.orange,
                  onPressed: () {
                    saveIsGuest(true);
                    _loginAsGuest(context);
                  },
                  child: const Text("Enter as guest"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _loginAsGuest(BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'nevef24056@abatido.com',
      password: '123456#',
    );
    if (userCredential.user != null && userCredential.user!.emailVerified && context.mounted) {
      String userId = userCredential.user!.uid;
      MyUser? myUser = await getUserData(userId);
      await FirebaseAuthService().saveLoginStatus(true);
      if (myUser != null) {
        await storeUserLocally(myUser);
        await saveUserId(userId);
        context.pushNamedAndRemoveUntil(
          Routes.homeScreen,
          predicate: (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('بيانات المستخدم غير موجودة'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else if (userCredential.user == null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(MyTexts.emailOrPassNotTrue),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(MyTexts.verifyYourEmail)),
      );
    }
  } on FirebaseAuthException catch (e) {
    handleAuthError(e, context);
  }
}
