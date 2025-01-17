import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfields.dart';
import '../../widgets/page_widgets/appbar_widget.dart';

class VehicleVerificationScreen extends StatefulWidget {
  const VehicleVerificationScreen({super.key});

  @override
  State<VehicleVerificationScreen> createState() =>
      _VehicleVerificationScreenState();
}

class _VehicleVerificationScreenState extends State<VehicleVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _vehicleType = TextEditingController();
  final TextEditingController _vehicleBrand = TextEditingController();
  final TextEditingController _plateNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final authProvider = context.read<AuthProvider>();
    return Scaffold(
      appBar: appBarWidget(context, title: 'Verification'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload A Picture Of Your Driver’s Licence",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          color: greyText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Consumer<AuthProvider>(builder: (context, watch, _) {
                        return GestureDetector(
                          onTap: () => watch.pickImg(),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: (watch.riderId != null)
                                ? Image.file(
                                    File(watch.riderId!),
                                    fit: BoxFit.cover,
                                  )
                                : const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.idCard,
                                        size: 45,
                                        color: primaryColor1,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Select Image',
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500,
                                          color: greyText,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      AppTextField(
                        labelText: 'Vehicle Type',
                        isPassword: false,
                        hintText: 'e.g Car',
                        controller: _vehicleType,
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        labelText: 'Vehicle Brand',
                        isPassword: false,
                        hintText: 'e.g Toyota',
                        controller: _vehicleBrand,
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        labelText: 'Plate Number',
                        isPassword: false,
                        controller: _plateNumber,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<AuthProvider>(builder: (context, watch, _) {
              return (watch.authState == AuthState.authenticating)
                  ? const LoadingButton(
                      backgroundColor: primaryColor1,
                      textColor: Colors.white,
                    )
                  : AppButton(
                      text: 'Continue',
                      hasIcon: true,
                      textColor: Colors.white,
                      backgroundColor: primaryColor1,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await watch
                              .verifyVehicle(
                                _vehicleType.text,
                                _vehicleBrand.text,
                                _plateNumber.text,
                              )
                              .then(
                                (value) => {
                                  if (watch.authState ==
                                      AuthState.authenticated)
                                    {
                                      context.push('/guarantor'),
                                    }
                                  else
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(watch.errorMessage),
                                        ),
                                      ),
                                    }
                                },
                              );
                        }
                      },
                    );
            }),
            // AppButton(
            //   text: 'Continue',
            //   hasIcon: true,
            //   textColor: Colors.white,
            //   backgroundColor: primaryColor1,
            //   onPressed: () => context.push('/guarantor'),
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
