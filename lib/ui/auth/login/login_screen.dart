import 'package:flutter/material.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo, Title & Subtitle
                LoginHeader(),

                // Form
                LoginForm(),

                // Divider
                //FormDivider(dividerText: MyTexts.loginDividerText),
                //SizedBox(height: 20),
                // Footer
                //SocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



