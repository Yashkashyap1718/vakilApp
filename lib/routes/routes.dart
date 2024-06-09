import 'package:flutter/material.dart';
import 'package:vakil_app/screen/Customer_Screen/Auth/enter_number.dart';
import 'package:vakil_app/screen/Customer_Screen/Auth/otp.dart';
import 'package:vakil_app/screen/Customer_Screen/Edit%20Profile/edit_profile.dart';
import 'package:vakil_app/screen/Customer_Screen/List%20of%20concerned%20Landing/list_of_concerned_landing_page.dart';
import 'package:vakil_app/screen/Customer_Screen/Splash/splash_screen.dart';
import 'package:vakil_app/screen/Customer_Screen/home/home_screen.dart';
import 'package:vakil_app/services/api_constant.dart';

const initialRoute = "/";
const mobileRoute = "/enter_number";
const otpRoute = "/Auth/otp";
const homeRoute = "/home_screen";
const editProfileRoute = "/edit_profile";
const listofConcernedUserLandingPageRoute = "/list_of_concerned_landing_page";

final routes = {
  initialRoute: (context) => SplashScreen(),
  mobileRoute: (context) => MobileScreen(),
  otpRoute: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final verificationId = args['verficationId'];
    final phoneNumber = args['phoneNumber'];
    final otp = args['otp'];
    return OtpScreen(
      phoneNumder: phoneNumber,
      oTP: otp,
    );
  },
  homeRoute: (context) => HomeScreen(),
  editProfileRoute: (context) => EditProfileScreen(),
  listofConcernedUserLandingPageRoute: (context) =>
      ListOfConcernedUserLandingPage(),
};
