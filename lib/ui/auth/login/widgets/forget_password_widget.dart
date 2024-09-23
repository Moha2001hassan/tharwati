import 'package:flutter/material.dart';
import 'package:tharwati/utils/helpers/navigation.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/routing/routes.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Forget Password
        TextButton(
          onPressed: () => context.pushNamed(Routes.forgetPassword),
          child: const Text(
            MyTexts.forgetPassword,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
