import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_textfields.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final TextEditingController name = TextEditingController(
    text: 'Adesewa Adetoro',
  );
  final TextEditingController phone = TextEditingController(
    text: '+2348123456789',
  );
  final TextEditingController email =
      TextEditingController(text: 'adesewa111@gmail.com');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.push('/profile/get-help'),
                    child: const Text(
                      'Get Help',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        color: blackText,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push('/profile/edit-profile'),
                    icon: const Icon(
                      Iconsax.setting_2,
                      size: 35,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Image.asset('assets/images/pp.png', height: 200),
              const SizedBox(height: 40.0),
              AppTextField(
                  labelText: 'Name', isPassword: false, controller: name),
              const SizedBox(height: 20.0),
              AppTextField(
                  labelText: 'Phone Number',
                  isPassword: false,
                  controller: phone),
              const SizedBox(height: 20.0),
              AppTextField(
                  labelText: 'Email', isPassword: false, controller: email),
              const SizedBox(height: 40.0),
              const AppButton(
                text: 'Sign out',
                hasIcon: false,
                textColor: Colors.white,
                backgroundColor: primaryColor1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
