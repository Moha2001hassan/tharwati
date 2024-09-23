import 'package:flutter/material.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Image(image: AssetImage(MyImages.signupImg), height: 200),
        SizedBox(height: 20),
        Text(
          MyTexts.signupTitle,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
