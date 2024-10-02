import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tharwati/utils/helpers/navigation.dart';
import '../../../../data/datasources/auth_firebase.dart';
import '../../../../data/datasources/user_firebase.dart';
import '../../../../data/hive/hive_user_service.dart';
import '../../../../data/models/user.dart';
import '../../../../data/shared_pref/local_storage.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/handle_auth_error.dart';
import '../../../../utils/routing/routes.dart';
import 'forget_password_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Email
            TextFormField(
              validator: (value) => value!.isEmpty ? MyTexts.emptyField : null,
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: MyTexts.email,
              ),
            ),
            const SizedBox(height: 12),

            // Password
            TextFormField(
              validator: (value) => value!.isEmpty ? MyTexts.emptyField : null,
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: MyTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash),
                  onPressed: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                ),
              ),
            ),

            const ForgetPasswordWidget(),

            // Sign In Button
            _isLoading
                ? const CircularProgressIndicator()
                : _buildLoginButton(),
            const SizedBox(height: 12),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.pushNamed(Routes.signupScreen),
                child: const Text(MyTexts.createAccount),
              ),
            ),
            const SizedBox(height: 23),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formState.currentState!.validate()) {
            setState(() => _isLoading = true);
            _login(context);
          }
        },
        child: const Text(MyTexts.signIn),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: password,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: MyTexts.password,
        prefixIcon: const Icon(Iconsax.password_check),
        suffixIcon: IconButton(
          icon: Icon(_isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash),
          onPressed: () {
            setState(() => _isPasswordVisible = !_isPasswordVisible);
          },
        ),
      ),
      validator: (value) => value!.isEmpty ? MyTexts.emptyField : null,
    );
  }

  Future<void> _login(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      if (userCredential.user != null && userCredential.user!.emailVerified && context.mounted) {
        String userId = userCredential.user!.uid;
        // Fetch user data from Firestore
        MyUser? myUser = await getUserData(userId);

        debugPrint("________Saving login status: true");
        await FirebaseAuthService().saveLoginStatus(true);
        debugPrint("________Login status saved");

        if (myUser != null) {
          await storeUserLocally(myUser);
          // save userId in shared preferences
          await saveUserId(userId);
          saveIsGuest(false);
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
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(MyTexts.verifyYourEmail)),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      handleAuthError(e, context);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
