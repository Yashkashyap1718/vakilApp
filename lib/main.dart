// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vakil_app/Provider/home_provider.dart';
import 'package:vakil_app/constants/colors.dart';
import 'package:vakil_app/routes/routes.dart';
import 'package:vakil_app/screen/Customer_Screen/home/home_screen.dart';
import 'package:vakil_app/screen/role_choose.dart';
import 'package:vakil_app/screen/Customer_Screen/Auth/enter_number.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            // appBarTheme: const AppBarTheme(
            //     backgroundColor: baseColor,
            //     iconTheme: IconThemeData(color: whiteColor),
            //     titleTextStyle: TextStyle(color: whiteColor, fontSize: 18)),
            useMaterial3: true,
            fontFamily: GoogleFonts.lato().fontFamily),
        // home: const MobileScreen()

        initialRoute: initialRoute,
        routes: routes,
      ),
    );
  }
}
