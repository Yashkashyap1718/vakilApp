// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures, file_names



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakil_app/Provider/home_provider.dart';
import 'package:vakil_app/model/user_model.dart';
import 'package:vakil_app/routes/routes.dart';
import 'package:vakil_app/services/database_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    Provider.of<HomeProvider>(context, listen: false);

    getSharedPref() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool("isGuest");
    }

  navigateNext() async {
  final UserModel user = await DatabaseProvider().retrieveUserFromTable();
  final bool isGuest = await getSharedPref() ?? false;
  if (user.id != null || isGuest == true) {
    Navigator.pushNamedAndRemoveUntil(
        context, homeRoute, (Route<dynamic> route) => false);
  } else {
    Navigator.pushNamedAndRemoveUntil(
        context, mobileRoute, (Route<dynamic> route) => false);
  }
}

navigateNext();


    navigateNext();
    return Container(
      width: width,
      height: height,
      // padding: EdgeInsets.symmetric(horizontal: width * 0.25),
      decoration: const BoxDecoration(color: Colors.black),
      child: Center(
          child: Image.asset(
        'assets/logo.png',
        scale: 2,
        fit: BoxFit.contain,
      )),
    );
  }
}
