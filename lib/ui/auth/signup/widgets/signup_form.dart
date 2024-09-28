import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../data/datasources/auth_firebase.dart';
import '../../../../data/datasources/user_firebase.dart';
import '../../../../data/models/user.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/generate_unique_id.dart';
import '../../../../utils/helpers/handle_auth_error.dart';
import '../../../../utils/helpers/show_snack_bar.dart';
import 'build_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _inviteCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuthService _authService = FirebaseAuthService();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Full Name
          buildTextField(
            controller: _nameController,
            labelText: MyTexts.fullName,
            prefixIcon: Iconsax.user,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 12),
          // Phone Number
          buildTextField(
            controller: _phoneNumberController,
            labelText: MyTexts.phoneNumber,
            prefixIcon: Iconsax.call,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          // Invite Code
          /*buildTextField(
            controller: _inviteCodeController,
            labelText: MyTexts.inviteCode,
            prefixIcon: Icons.mark_email_read_outlined,
            keyboardType: TextInputType.phone,
          )
          const SizedBox(height: 12),,*/
          // Email
          buildTextField(
            controller: _emailController,
            labelText: MyTexts.email,
            prefixIcon: Iconsax.direct,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          // Password
          buildPasswordField(),
          const SizedBox(height: 25),
          // Sign Up Button
          _isLoading ? const CircularProgressIndicator() : _buildSignUpButton(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
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

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() => _isLoading = true);
            _signUp();
          }
        },
        child: const Text(MyTexts.createAccount),
      ),
    );
  }

  Future<void> _signUp() async {
    try {
      // Validate the invite code and get the inviter's document reference
      //final DocumentSnapshot? inviterDoc = await _validateInviteCode();

      //if (inviterDoc != null) {
      if (true) {
        UserCredential userCredential =
        await _authService.signUpWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        String newUserUid = userCredential.user!.uid;
        String userId = await generateUniqueUserId();

        MyUser newUser = MyUser(
          userId: userId,
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phoneNumber: _phoneNumberController.text.trim(),
          diamondsNumber: 0,
          dailyIncome: 0.0001,
          dollarsNumber: 0,
          invitedIDs: [],
          userCounters: [],
          imageUrl: null,
        );

        await saveUserData(userCredential.user, newUser.toMap());
        await _authService.sendEmailVerification(userCredential.user);
        //await _updateInviterData(inviterDoc, newUserUid);
        showSnackBar(MyTexts.emailCreatedVerifyIt, Colors.green, context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("كود الدعوة غير صحيح"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      handleAuthError(e, context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<DocumentSnapshot?> _validateInviteCode() async {
    final inviteCode = _inviteCodeController.text.trim();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: inviteCode)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null;
    }
  }

  Future<void> _updateInviterData(DocumentSnapshot inviterDoc, String newUserUid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(inviterDoc.id)
        .update({
      'invitedIDs': FieldValue.arrayUnion([newUserUid]),
      'diamondsNumber': FieldValue.increment(200),
    });
  }
}
