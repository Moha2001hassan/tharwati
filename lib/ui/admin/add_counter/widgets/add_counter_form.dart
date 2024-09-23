import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../data/datasources/counter_firebase.dart';
import '../../../../../data/models/counter.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class AddCounterForm extends StatefulWidget {
  final File? selectedImage;

  const AddCounterForm({super.key, this.selectedImage});

  @override
  State<AddCounterForm> createState() => _AddCounterFormState();
}

class _AddCounterFormState extends State<AddCounterForm> {
  final TextEditingController counterTitle = TextEditingController();
  final TextEditingController counterPrice = TextEditingController();
  final TextEditingController dailyIncome = TextEditingController();
  final TextEditingController monthsNumber = TextEditingController();
  final TextEditingController buysNumber = TextEditingController();

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _saveCounter() async {
    if (formState.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        if (widget.selectedImage != null) {
          // Upload image to Firebase Storage and get the URL
          String imageUrl = await uploadImageToStorage(widget.selectedImage!);
          // Calculate expire date using internet time
          DateTime expireDate = await MyHelperFunctions.calculateExpireDate(
              int.parse(monthsNumber.text.trim()));

          // Create a Counter object using form values
          Counter newCounter = Counter(
            title: counterTitle.text.trim(),
            price: double.parse(counterPrice.text.trim()),
            dailyIncome: double.parse(dailyIncome.text.trim()),
            monthsNumber: int.parse(monthsNumber.text.trim()),
            buysNumber: int.parse(buysNumber.text.trim()),
            expireDate: expireDate,
            imageUrl: imageUrl,
            isAvailable: true,
          );
          // Save the Counter to Firestore
          await saveCounter(newCounter);
          // Show a confirmation message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(MyTexts.counterSaved),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          // Clear the form fields
          _clearForm();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select an image.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (error) {
        // Handle errors if any
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(MyTexts.errorSavingCounter),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  void _clearForm() {
    counterTitle.clear();
    counterPrice.clear();
    dailyIncome.clear();
    monthsNumber.clear();
    buysNumber.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: [
          // Counter Title
          TextFormField(
            controller: counterTitle,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.timer_start),
              labelText: MyTexts.counterTitle,
            ),
            validator: (value) => value!.isEmpty ? MyTexts.emptyField : null,
          ),
          const SizedBox(height: 12),

          // Counter Price
          TextFormField(
            controller: counterPrice,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.dollar_circle),
              labelText: MyTexts.counterPrice,
            ),
            validator: (value) => value!.isEmpty ? MyTexts.emptyField : null,
          ),
          const SizedBox(height: 12),

          // daily Income
          TextFormField(
            controller: dailyIncome,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.diamonds),
              labelText: MyTexts.dailyIncome,
            ),
            validator: (value) => value!.isEmpty ? MyTexts.emptyField : null,
          ),
          const SizedBox(height: 12),

          // months Number
          TextFormField(
            controller: monthsNumber,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.access_time_outlined),
              labelText: MyTexts.monthsNumber,
            ),
            validator: (value) => value!.isEmpty ? MyTexts.emptyField : null,
          ),
          const SizedBox(height: 12),

          // buys Number
          TextFormField(
            controller: buysNumber,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.troubleshoot),
              labelText: MyTexts.counterBuyTimes,
            ),
            validator: (value) => value!.isEmpty ? MyTexts.emptyField : null,
          ),
          const SizedBox(height: 40),

          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? () {} : _saveCounter,
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text(
                      MyTexts.saveCounter,
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
