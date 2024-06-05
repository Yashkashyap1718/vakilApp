import 'package:flutter/material.dart';
import 'package:vakil_app/screen/Customer_Screen/Auth/enter_number.dart';
import 'package:vakil_app/screen/Customer_Screen/Auth/otp.dart';
import 'package:vakil_app/screen/Customer_Screen/Splash/splash_screen.dart';
import 'package:vakil_app/screen/Customer_Screen/home/home_screen.dart';


const initialRoute = "/";
const mobileRoute = "/enter_number";
const otpRoute = "/Auth/otp";
const homeRoute = "/home_screen";

final routes = {

  initialRoute: (context)=>  SplashScreen(),

  mobileRoute: (context)=> MobileScreen(),
  otpRoute: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final verificationId = args['verficationId'];
    final phoneNumber = args['phoneNumber'];
    return OtpScreen(
    phoneNumder: phoneNumber,
    );
  },

  homeRoute: (context)=> HomeScreen()
};
