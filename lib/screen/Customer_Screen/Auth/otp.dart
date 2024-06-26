import 'dart:async';
import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakil_app/model/user_model.dart';
import 'package:vakil_app/services/api_constant.dart';
import 'package:vakil_app/services/database_provider.dart';
import 'package:vakil_app/utils/loadingWrapper.dart';

import '../../../Provider/home_provider.dart';
import '../../../constants/colors.dart';
import '../home/home_screen.dart';

import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phoneNumder, required this.oTP});

  final String phoneNumder;

  final String oTP;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var code = '';
  final _formKey = GlobalKey<FormState>();

  final otpController = TextEditingController();

  final bool isActive = false;
  late Timer countdownTimer;
  int resendTime = 60;

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  confirmOTP(context, String otp, String phoneNumber) async {
    final prrovider = Provider.of<HomeProvider>(context, listen: false);

    // Check if otp or phoneNumber is null
    if (otp == null || phoneNumber == null) {
      debugPrint('Error: OTP or phone number is null');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: OTP or phone number is null'),
        ),
      );
      return;
    }

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
        Uri.parse(baseURL + confirmationEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      final String token = data['token'];
      final String id = data['id'];
      final String roleType = data['type'];
      final String firstDigit = id.substring(0, 1);
      final int firstDigitAsInt = int.parse(firstDigit, radix: 16);
      // final String userId = data['_id'];

      print(response.body);

      String confirmToken = token;
      // print("  -----response-----token-----------${confirmToken}");
      prrovider.setAccessToken(confirmToken);
      prrovider.setTempNumber(phoneNumber);
      if (response.statusCode == 200) {
        await saveLoginStatus(true);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));

        final UserModel user = UserModel(
            id: firstDigitAsInt, accessToken: confirmToken, role: roleType);

        final databaseProvider = DatabaseProvider();
        await databaseProvider.insertUser(user);
        print('-----user-id------${user.id}');
        print('-----user-token------${user.accessToken}');
        AnimatedSnackBar.material(
          'Welcome! User $phoneNumber',
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

      debugPrint('Error: during OTP confirmation----------- $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occurred while confirming OTP.'),
        ),
      );
    }
  }

  Future<void> resendOTP(
      context, String phoneNumber, HomeProvider provider) async {
    final Map<String, String> payload = {
      "country_code": '91',
      "mobile_number": phoneNumber
    };

    try {
      provider.showLoader();
      final http.Response response = await http.post(
        Uri.parse(baseURL + resendOTPEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      // print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String msg = responseData['msg'];

        AnimatedSnackBar.material(
          msg,
          type: AnimatedSnackBarType.success,
          duration: const Duration(seconds: 5),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
        provider.hideLoader();
      } else {
        throw Exception('Failed to resend OTP');
      }

      provider.hideLoader();
    } catch (e) {
      provider.hideLoader();

      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occurred while resending OTP.'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      String receiveOTP = widget.oTP;
      otpController.text = receiveOTP;

      continueButtonTap();
    });
  }

  void continueButtonTap() async {
    await confirmOTP(context, otpController.text, widget.phoneNumder);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return LoadingWrapper(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_rounded)),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.help,
                    size: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Help',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        body: Consumer<HomeProvider>(
          builder: (__, homeProvider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Enter the 4-digit OTP sent to\n${widget.phoneNumder}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Pinput(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter OTP';
                              } else if (value.length < 4) {
                                return 'Please enter valid OTP';
                              } else {
                                return null;
                              }
                            },
                            controller: otpController,
                            showCursor: false,
                            focusedPinTheme: PinTheme(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    border: Border.all(
                                        width: 2,
                                        style: BorderStyle.solid,
                                        color: baseColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)))),
                            defaultPinTheme: PinTheme(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                height: (width - 16) / 7,
                                width: (width - 16) / 8,
                                decoration: BoxDecoration(
                                    color: grey2Color,
                                    border: Border.all(
                                        width: 2,
                                        style: BorderStyle.solid,
                                        color: grey2Color),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)))),
                            length: 4,
                            onChanged: (value) {
                              code = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Didn't receive the code?",
                        style: TextStyle(
                          color: Color.fromARGB(133, 92, 90, 90),
                          fontSize: 13,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          otpController.clear();
                          await resendOTP(
                              context, widget.phoneNumder, homeProvider);
                        },
                        child: const Text(
                          ' Resend',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  // resendTime != 0
                  //     ? Padding(
                  //         padding: const EdgeInsets.only(top: 10),
                  //         child: Text(
                  //           'You can resend OTP after $resendTime second(s)',
                  //           style: const TextStyle(
                  //               fontSize: 12,
                  //               fontFamily: 'Nuntio',
                  //               fontWeight: FontWeight.bold,
                  //               color: baseColor),
                  //         ),
                  //       )
                  //     : const SizedBox(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () async {
                            await confirmOTP(context, otpController.text,
                                widget.phoneNumder);
                          },
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                color: baseColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: const Center(
                              child: Text(
                                'Continue',
                                style:
                                    TextStyle(color: whiteColor, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
