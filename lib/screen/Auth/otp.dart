import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:vakil_app/utils/loadingWrapper.dart';

import '../../Provider/home_provider.dart';
import '../../constants/colors.dart';
import '../home/home_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

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
  startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime = resendTime - 1;
      });
      if (resendTime < 1) {
        stopTimer();
      }
    });
  }

  stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }
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

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return LoadingWrapper(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_back_rounded)),
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
          builder: (_, homeProvider, __) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Enter the 6-digit OTP sent to\n+918168605829',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
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
                            length: 6,
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
                      InkWell(
                          onTap: () {
                            homeProvider.showLoader();
                            // resendOtp();
                            homeProvider.hideLoader();
                          },
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              '   Resend',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  resendTime != 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'You can resend OTP after $resendTime second(s)',
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Nuntio',
                                fontWeight: FontWeight.bold,
                                color: baseColor),
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
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
