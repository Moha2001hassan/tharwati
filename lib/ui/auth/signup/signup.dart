import 'package:flutter/material.dart';
import 'widgets/signup_form.dart';
import 'widgets/signup_header.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, surfaceTintColor: Colors.white),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24,0,24,10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              SignupHeader(),

              // Form
              SignUpForm(),

              // Divider
              //FormDivider(dividerText: MyTexts.orSignupWith),
              //SizedBox(height: 15),
              // Social Buttons
              //SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}


