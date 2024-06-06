import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakil_app/Provider/home_provider.dart';
import 'package:vakil_app/constants/colors.dart';
import 'package:vakil_app/routes/routes.dart';
import 'package:vakil_app/screen/Customer_Screen/Edit%20Profile/edit_profile.dart';
import 'package:vakil_app/utils/loadingWrapper.dart';

class EmailEditScreen extends StatefulWidget {
  const EmailEditScreen({super.key});

  @override
  State<EmailEditScreen> createState() => _EmailEditScreenState();
}

class _EmailEditScreenState extends State<EmailEditScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  bool _isCodeSent = false;
  bool _isGmail(String email) {
    return email.endsWith('@gmail.com') ||
        email.endsWith('.com') ||
        email.endsWith('.co') ||
        email.endsWith('.in');
  }

  sendEmailCode(HomeProvider provider, context) async {
    try {
      setState(() {
        _isCodeSent = true;
      });
      provider.showLoader();

      final email = _emailController.text;
      final token = provider.accessToken;

      if (email.isEmpty) {
        throw Exception("Email is required");
      }
      if (token == null || token.isEmpty) {
        throw Exception("Token is required");
      }

      final response = await provider.sendEmail(email, token);

      final Map<String, dynamic> data = jsonDecode(response);

      final String msg = data['msg'];

      if (data['status'] == true) {
        AnimatedSnackBar.material(
          msg,
          type: AnimatedSnackBarType.success,
          duration: const Duration(seconds: 5),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      }

      provider.hideLoader();
    } catch (e) {
      provider.hideLoader();
      print(e);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  verifyEmailCode(
      HomeProvider provider, String token, BuildContext context) async {
    try {
      provider.showLoader();

      final response = await provider.verifyEmail(
          _codeController.text, _emailController.text, token);

      final Map<String, dynamic> data = jsonDecode(response);

      final String msg = data['msg'] ?? 'No message provided';
      final String? fetchUserEmail = data['data']?['email'];

      print(
          'Email: $fetchUserEmail'); // Add this line to check the value of fetchUserEmail

      if (data['status'] == true) {
        if (fetchUserEmail != null) {
          provider.setUserEmail(fetchUserEmail);
        } else {
          print('Email is null');
          // Handle the case where email is null, maybe show an error message to the user
        }

        AnimatedSnackBar.material(
          msg,
          type: AnimatedSnackBarType.success,
          duration: const Duration(seconds: 5),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);

        Navigator.pushNamedAndRemoveUntil(
            context, editProfileRoute, (routes) => false);
      } else {
        AnimatedSnackBar.material(
          'Error during verify email',
          type: AnimatedSnackBarType.error,
          duration: const Duration(seconds: 5),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      }
      provider.hideLoader();
    } catch (e) {
      print(e);
      AnimatedSnackBar.material(
        e.toString(),
        type: AnimatedSnackBarType.error,
        duration: const Duration(seconds: 5),
        mobileSnackBarPosition: MobileSnackBarPosition.top,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWrapper(
      child: Scaffold(
        backgroundColor: baseColor,
        appBar: AppBar(
          backgroundColor: baseColor,
          elevation: 2,
          title: const Text(
            'add email',
            style: TextStyle(color: whiteColor),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: whiteColor,
              )),
        ),
        body: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Text(
                        'What is your email id?',
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (authResult) {
                      if (authResult!.isEmpty ||
                          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(authResult)) {
                        return 'Please enter a valid email';
                      }

                      if (!_isGmail(authResult)) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: whiteColor)),
                      labelText: 'Enter email',
                      labelStyle: TextStyle(color: whiteColor),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => sendEmailCode(value, context),
                    child: const Text('Send Code'),
                  ),
                  const SizedBox(height: 20),
                  _isCodeSent
                      ? TextField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: whiteColor),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: whiteColor)),
                            labelText: 'Enter Code',
                            labelStyle: TextStyle(color: whiteColor),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 20),
                  _isCodeSent
                      ? ElevatedButton(
                          onPressed: () => verifyEmailCode(
                              value, value.accessToken, context),
                          child: const Text('Veify code'),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
