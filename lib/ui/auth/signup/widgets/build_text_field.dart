import 'package:flutter/material.dart';

import '../../../../utils/constants/text_strings.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String labelText,
  required IconData prefixIcon,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      labelText: labelText,
    ),
    validator: (value) => value!.isEmpty ? MyTexts.emptyField : null,
  );
}
