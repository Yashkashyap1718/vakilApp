// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vakil_app/screen/Admin_Screen/login.dart';
import 'package:vakil_app/screen/Customer_Screen/Auth/otp.dart';
import 'package:vakil_app/services/api_constant.dart';
import 'package:vakil_app/utils/loadingWrapper.dart';

import '../../../Provider/home_provider.dart';
import '../../../constants/colors.dart';
import '../../../constants/image.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController countryCode = TextEditingController();
  late TabController _tabController;

  int _currentPageIndex = 0;
  final int _numPages = 4; // Number of pages in your PageView

  List pages = [
    log1Img,
    log2Img,
    log1Img,
    log2Img
  ]; // Replace with your image paths

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _tabController = TabController(length: _numPages, vsync: this);
    countryCode.text = "+91";

    _pageController.addListener(() {
      int currentIndex = _pageController.page!.round();
      if (currentIndex != _tabController.index) {
        _tabController.animateTo(currentIndex);
      }
    });

    // Start automatic scrolling after 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPageIndex = (_currentPageIndex + 1) % _numPages;
      _pageController.animateToPage(
        nextPageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  void _updateCurrentPageIndex(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Future<void> sendSignInRequest(context, HomeProvider provider) async {

    final Map<String, String> payload = {
      "country_code": "91",
      "mobile_number": _phoneController.text
    };

    try {
      provider.showLoader();
      final http.Response response = await http.post(
        Uri.parse(baseURL + signInEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                      phoneNumder: _phoneController.text,
                    )));
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoadingWrapper(
      child: Scaffold(
        body: Consumer<HomeProvider>(
          builder: (_, provider, __) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: size.height * .68,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: pages.length,
                          onPageChanged: (value) {
                            setState(() {
                              _currentPageIndex = value;
                            });
                            _tabController
                                .animateTo(value); // Update the tab controller
                          },
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              color: baseColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    pages[index],
                                    fit: BoxFit.fill,
                                    height: size.height / 2.3,
                                  ),
                                  const Text(
                                    '1 Crore Indians connect with Us',
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 20),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      PageIndicator(
                        tabController: _tabController,
                        currentPageIndex: _currentPageIndex,
                        onUpdateCurrentPageIndex: _updateCurrentPageIndex,
                      )
                    ],
                  ),
                  Container(
                    height: size.height / 3,
                    color: whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Let's get started! Enter your mobile Number",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Container(
                              height: 50,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          135, 179, 177, 177)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: TextField(
                                      controller: countryCode,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  const Text(
                                    '|',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(135, 179, 177, 177)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.length != 10) {
                                          return "Invalid phone number";
                                        }
                                        return null;
                                      },
                                      controller: _phoneController,
                                      onChanged: (value) {},
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                          hintText: 'Mobile Number',
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Color.fromARGB(
                                                  133, 109, 106, 106))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminLoginPage()));
                                  },
                                  child: const Text(
                                    'Registeer with Advocate',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontStyle: FontStyle.italic),
                                  ))
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: () async {
                                    await sendSignInRequest(context, provider);
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: baseColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: const Center(
                                      child: Text(
                                        'Continue',
                                        style: TextStyle(
                                            color: whiteColor, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
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

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TabPageSelector(
            controller: tabController,
            color: colorScheme.surface,
            selectedColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
