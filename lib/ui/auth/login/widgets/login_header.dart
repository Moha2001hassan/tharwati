import 'package:flutter/material.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 15),
        Image(
          image: AssetImage(MyImages.loginImg),
          height: 200,
        ),
        SizedBox(height: 12),
        Text(
          MyTexts.loginTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
