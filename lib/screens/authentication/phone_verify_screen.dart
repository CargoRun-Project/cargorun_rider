import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_button.dart';
import '../../widgets/page_widgets/appbar_widget.dart';

class PhoneVerifyScreen extends StatefulWidget {
  const PhoneVerifyScreen({super.key});

  @override
  State<PhoneVerifyScreen> createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: appBarWidget(context, title: 'Verification'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Please enter the verification code sent to\nyour email address',
                style: TextStyle(
                  fontSize: 17.0,
                  color: greyText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 100.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        OTPTextField(
                          length: 5,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: 60,
                          // obscureText: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                          style: const TextStyle(fontSize: 30),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.box,
                          onCompleted: (pin) {
                            setState(() {
                              _otp.text = pin;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Consumer<AuthProvider>(
                builder: (context, watch, _) {
                  return (watch.authState == AuthState.authenticating)
                      ? const LoadingButton(
                          textColor: Colors.white,
                          backgroundColor: primaryColor1,
                        )
                      : AppButton(
                          text: 'Continue',
                          hasIcon: true,
                          backgroundColor: primaryColor1,
                          textColor: Colors.white,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {}
                          },
                        );
                },
              ),
              // AppButton(
              //   text: 'Continue',
              //   hasIcon: true,
              //   backgroundColor: primaryColor1,
              //   textColor: Colors.white,
              //   onPressed: () => context.push('/home'),
              // ),
              const SizedBox(height: 25.0),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: const TextSpan(
                    text: 'Didn\'t receive the code? ',
                    style: TextStyle(
                      color: greyText,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'Resend',
                        style: TextStyle(
                          color: primaryColor2,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
