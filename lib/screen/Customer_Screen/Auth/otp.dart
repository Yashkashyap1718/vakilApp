import 'dart:async';
import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:vakil_app/model/user_model.dart';
import 'package:vakil_app/services/api_constant.dart';
import 'package:vakil_app/services/database_provider.dart';
import 'package:vakil_app/utils/loadingWrapper.dart';

import '../../../Provider/home_provider.dart';
import '../../../constants/colors.dart';
import '../home/home_screen.dart';

import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phoneNumder});

  final String phoneNumder;

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

  // startTimer() {
  //   countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       resendTime = resendTime - 1;
  //     });
  //     if (resendTime < 1) {
  //       stopTimer();
  //     }
  //   });
  // }

  // stopTimer() {
  //   if (countdownTimer.isActive) {
  //     countdownTimer.cancel();
  //   }
  // }

  // @override
  // void initState() {
  //   startTimer();

  //   super.initState();
  // }
  // void resendOtp() async {
  //   try {
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) {
  //         Navigator.pushReplacementNamed(context, tabsRoute);
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         SnackBar snackBar = const SnackBar(
  //             content: Text("Something went wrong, pleaes try again later"));
  //         if (e.code == 'too-many-requests') {
  //           snackBar = const SnackBar(
  //             content: Text('Too Many Attempts'),
  //           );
  //         } else {
  //           snackBar = const SnackBar(
  //             content: Text('Something Went Wrong, Try Again later.'),
  //           );
  //         }
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       },
  //       codeSent: (String verificationId, int? resendToken) {},
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //   } catch (e) {
  //     SnackBar snackBar = const SnackBar(
  //         content: Text("Something went wrong, pleaes try again later"));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  Future<void> confirmOTP(
    context,
    String otp,
    String phoneNumber,
  ) async {
    final prrovider = Provider.of<HomeProvider>(context, listen: false);
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

      String token = data['token'];

      print(response.body);

      String confirmToken = token;
      print("  -----response-----token-----------${confirmToken}");
      prrovider.setAccessToken(confirmToken);
      prrovider.setTempNumber(phoneNumber);
      if (response.statusCode == 200) {
        print(prrovider.accessToken);

        final UserModel user = UserModel(accessToken: confirmToken);

        final databaseProvider = DatabaseProvider();
        await databaseProvider.insertUser(user);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        AnimatedSnackBar.material(
          'Welcome! User ${widget.phoneNumder}',
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
