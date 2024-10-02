import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tharwati/data/shared_pref/local_storage.dart';
import 'package:tharwati/utils/helpers/navigation.dart';
import '../../../data/datasources/auth_firebase.dart';
import '../../../data/datasources/payment_logic.dart';
import '../../../data/hive/hive_user_service.dart';
import '../../../data/models/user.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/show_snack_bar.dart';
import '../../../utils/routing/routes.dart';
import '../../shared_widgets/basic_appbar.dart';
import '../../shared_widgets/custom_button.dart';
import 'widgets/link_button.dart';
import 'widgets/profile_dialog.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu.dart';
import 'widgets/showDeleteAccountDialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isGuest = false;

  @override
  void initState() {
    getIsUserGuest();
    super.initState();
  }

  getIsUserGuest() async {
    _isGuest = await getIsGuest();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyUser?>(
      future: getUserFromLocal(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text("No user data found.");
        } else {
          final user = snapshot.data;
          return Scaffold(
            appBar: const BasicAppBar(title: "Profile"),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ProfileHeader(),

                    // Details
                    const Divider(),

                    // Name
                    ProfileMenu(
                        isGuest: _isGuest,
                        title: MyTexts.name,
                        icon: Iconsax.edit,
                        value: user!.fullName,
                        onPressed: () {
                          _showUpdateNameDialog(context, user.fullName);
                        }),
                    // Phone Number
                    ProfileMenu(
                        isGuest: _isGuest,
                        title: MyTexts.phoneNumber,
                        icon: Iconsax.edit,
                        value: user.phoneNumber,
                        onPressed: () {
                          _showUpdatePhoneDialog(context, user.phoneNumber);
                        }),
                    // Id
                    ProfileMenu(
                        title: MyTexts.invitationId,
                        value: user.userId,
                        icon: Iconsax.copy,
                        onPressed: () {
                          copyToClipboard(context, user.userId);
                        }),
                    // Email
                    ProfileMenu(
                        title: MyTexts.email,
                        value: user.email,
                        onPressed: () {}),

                    const SizedBox(height: 5),
                    const Divider(),

                    // Counters
                    CustomButton(
                      text: MyTexts.yourCounters,
                      onTap: () => context.pushNamed(Routes.myCountersScreen),
                    ),
                    const SizedBox(height: 8),
                    const LinkButton(
                      title: MyTexts.callCenterWhatsapp,
                      color: Colors.green,
                      img: MyImages.whatsappIcon,
                      link: whatsappLink,
                      fontColor: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    // Facebook Button
                    const LinkButton(
                      title: MyTexts.followUsOnFacebook,
                      color: MyColors.softGrey,
                      img: MyImages.facebookImg,
                      link: followUsFacebookLink,
                    ),
                    const SizedBox(height: 12),

                    // Logout button
                    MaterialButton(
                      onPressed: () {
                        if (context.mounted) {
                          showCustomDialog(
                            context: context,
                            title: MyTexts.logout,
                            body: MyTexts.areYouSureLogout,
                            confirmText: MyTexts.closeAcc,
                            cancelText: MyTexts.cancel,
                            onConfirm: () async {
                              await FirebaseAuthService().logout();
                              context.pushNamedAndRemoveUntil(
                                Routes.loginScreen,
                                predicate: (route) => false,
                              );
                            },
                          );
                        }
                      },
                      color: Colors.orange,
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: const Text(
                        MyTexts.closeAcc,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    if (!_isGuest) MaterialButton(
                      onPressed: () async {
                        if (context.mounted) {
                          showDeleteAccountDialog(
                            context: context,
                            title: MyTexts.deleteAcc,
                            body: MyTexts.areYouSureDeleteAcc,
                            confirmText: MyTexts.deleteAcc,
                            cancelText: MyTexts.cancel,
                            onConfirm: (String password) async {
                              try {
                                var isPasswordValid = await FirebaseAuthService().reAuthenticateAndDelete(password);
                                if (isPasswordValid){
                                  context.pushNamedAndRemoveUntil(
                                    Routes.loginScreen,
                                    predicate: (route) => false,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('كلمة المرور خاطئة'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to delete account: ${e.toString()}'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                          );
                        }
                      },
                      color: Colors.red,
                      elevation: 10,
                      child: const Text(
                        MyTexts.deleteAcc,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _showUpdateNameDialog(BuildContext context, String currentName) async {
    final TextEditingController nameController = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'تحديث الاسم',
          textAlign: TextAlign.end,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        content: TextField(
          controller: nameController,
          textAlign: TextAlign.end,
          decoration: const InputDecoration(labelText: 'الاسم الجديد'),
        ),
        actions: [
          MaterialButton(
            color: MyColors.grey,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'الغاء',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            ),
          ),
          MaterialButton(
            color: MyColors.primary,
            onPressed: () async {
              String? userId = await getUserId();
              if (userId != null && nameController.text.trim().isNotEmpty) {
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .update({'fullName': nameController.text.trim()});
                  Navigator.of(context).pop(); // Close dialog
                  showSnackBar('تم تحديث الاسم بنجاح', Colors.green, context);
                } catch (e) {
                  showSnackBar('فشل تحديث الاسم', Colors.red, context);
                }
              }
            },
            child: const Text(
              'تحديث',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  void _showUpdatePhoneDialog(BuildContext context, String currentPhone) async {
    final TextEditingController phoneController = TextEditingController(text: currentPhone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'تحديث رقم الهاتف',
          textAlign: TextAlign.end,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        content: TextField(
          controller: phoneController,
          decoration: const InputDecoration(labelText: 'رقم الهاتف الجديد'),
          keyboardType: TextInputType.phone,
        ),
        actions: [
          MaterialButton(
            color: MyColors.grey,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'الغاء',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            ),
          ),
          MaterialButton(
            color: MyColors.primary,
            onPressed: () async {
              String? userId = await getUserId();
              if (userId != null && phoneController.text.trim().isNotEmpty) {
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .update({'phoneNumber': phoneController.text.trim()});
                  Navigator.of(context).pop(); // Close dialog
                  showSnackBar(
                      'تم تحديث رقم الهاتف بنجاح', Colors.green, context);
                } catch (e) {
                  showSnackBar('فشل تحديث رقم الهاتف', Colors.red, context);
                }
              }
            },
            child: const Text(
              'تحديث',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
