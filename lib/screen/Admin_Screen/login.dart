import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vakil_app/Provider/home_provider.dart';
import 'package:vakil_app/constants/colors.dart';
import 'package:vakil_app/model/user_model.dart';
import 'package:vakil_app/screen/role_choose.dart';
import 'package:vakil_app/services/api_constant.dart';
import 'package:vakil_app/services/database_provider.dart';
import 'package:vakil_app/utils/loadingWrapper.dart';

import '../Customer_Screen/home/home_screen.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _showOtpField = false;

  Future<void> sendSignInRequest(context, HomeProvider provider) async {
    final Map<String, String> payload = {
      "country_code": "91",
      "mobile_number": _phoneNumberController.text
    };

    try {
      provider.showLoader();
      final http.Response response = await http.post(
        Uri.parse(baseURL + adminSignInEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        print(responseData);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const OtpScreen()));
        final String msg = responseData['msg'];
        AnimatedSnackBar.material(
          msg,
          type: AnimatedSnackBarType.success,
          duration: const Duration(seconds: 5),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);

        provider.hideLoader();
      } else {
        throw Exception('Failed to send request');
      }
      provider.hideLoader();
    } catch (e) {
      provider.hideLoader();
      if (kDebugMode) {
        print('Error: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occurred while sending request.'),
        ),
      );
    }
  }

  Future<void> confirmOTP(
      context, String otp, String phoneNumber, HomeProvider prrovider) async {
    final Map<String, String> payload = {
      "otp": otp,
      "mobile_number": phoneNumber
    };

    if (kDebugMode) {
      print(payload);
    }

    try {
      prrovider.showLoader();

      final http.Response response = await http.post(
        Uri.parse(baseURL + adminConfirmationEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      var data = jsonDecode(response.body);

      // print(response.body);

      String confirmToken = data['token'];

      String role = data['role'];
      print(confirmToken);
      if (response.statusCode == 200) {
        final UserModel user = UserModel(role: role);
        final database = DatabaseProvider();
        await database.insertUser(user);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        AnimatedSnackBar.material(
          'Welcome! Advodcate ${_phoneNumberController.text}',
          type: AnimatedSnackBarType.success,
          duration: const Duration(seconds: 5),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);

        prrovider.hideLoader();
      } else {
        throw Exception('Failed to confirm OTP');
      }

      prrovider.hideLoader();
    } catch (e) {
      prrovider.hideLoader();

      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occurred while confirming OTP.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoadingWrapper(
      child: Scaffold(
        backgroundColor: baseColor,
        appBar: AppBar(
          backgroundColor: baseColor,
          title: const Text(
            'Admin Login',
            style: TextStyle(color: whiteColor),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: whiteColor,
              )),
          shadowColor: whiteColor,
          elevation: .5,
        ),
        body: Consumer<HomeProvider>(
          builder: (_, provider, __) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                              color: const Color.fromARGB(135, 179, 177, 177)),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: InputBorder.none,
                          hintText: 'Phone Number',
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (_showOtpField)
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            height: 50,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        135, 179, 177, 177)),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _otpController,
                              decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                labelText: 'OTP',
                              ),
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter OTP';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (!_showOtpField) {
                          if (_formKey.currentState!.validate()) {
                            // Call the function to send sign-in request
                            await sendSignInRequest(context, provider);
                            setState(() {
                              _showOtpField = true;
                            });
                          }
                        } else {
                          if (_formKey.currentState!.validate()) {
                            // Perform login logic here using OTP
                            // For demo purpose, let's just navigate to AdminScreen
                            await confirmOTP(context, _otpController.text,
                                _phoneNumberController.text, provider);
                          }
                        }
                      },
                      child: Text(_showOtpField ? 'Verify OTP' : 'Send OTP'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}
