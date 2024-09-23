import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tharwati/utils/helpers/navigation.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/routing/routes.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(MyTexts.passwordResitEmail),
            backgroundColor: Colors.green,
          ),
        );
        context.pushReplacementNamed(Routes.loginScreen);
      } catch (e) {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(MyTexts.notFoundEmail),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image
                const Image(
                  height: 200,
                  image: AssetImage(MyImages.resetPassImg),
                ),
                const SizedBox(height: 25),

                // Headings
                const Text(
                  MyTexts.forgetPassword,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 12),
                const Text(
                  textAlign: TextAlign.center,
                  MyTexts.forgetPasswordSubtitle,
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 32),

                // Text Fields
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: MyTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return MyTexts.emptyField;
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return MyTexts.invalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: resetPassword,
                    child: const Text(MyTexts.submit),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
