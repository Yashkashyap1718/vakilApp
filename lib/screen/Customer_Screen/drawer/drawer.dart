import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:provider/provider.dart';
import 'package:vakil_app/Provider/home_provider.dart';
import 'package:vakil_app/constants/colors.dart';
import 'package:vakil_app/model/user_model.dart';
import 'package:vakil_app/routes/routes.dart';
import 'package:vakil_app/screen/Customer_Screen/Edit%20Profile/edit_profile.dart';
import 'package:vakil_app/services/api_constant.dart';
import 'package:vakil_app/services/database_provider.dart';

import 'package:http/http.dart' as http;

class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final drawerTitle = [
    'Home',
    'Home',
    'Home',
    'Home',
    'Home',
    'Home',
    'Log Out',
  ];

  final drawerIcons = [
    const Icon(
      Icons.home,
      color: Colors.lightBlue,
    ),
    const Icon(
      Icons.home,
      color: Colors.lightBlue,
    ),
    const Icon(
      Icons.home,
      color: Colors.lightBlue,
    ),
    const Icon(
      Icons.home,
      color: Colors.lightBlue,
    ),
    const Icon(
      Icons.home,
      color: Colors.lightBlue,
    ),
    const Icon(
      Icons.home,
      color: Colors.lightBlue,
    ),
    const Icon(
      Icons.logout_outlined,
      color: Colors.lightBlue,
    ),
  ];

  String appVersion = "v. 1.0";

  UserModel user = UserModel();
  DatabaseProvider db = DatabaseProvider();
  bool isTokenFetched = false;

  String phoneNumber = '';
  // fetchUserProfilePreview() async {
  //   final token = Provider.of<HomeProvider>(context, listen: false).accessToken;
  //   final response = await http.get(
  //     Uri.parse(baseURL + getuserProfileEndpoint),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'token': token,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     // Handle success response
  //     final Map<String, dynamic> responseData = jsonDecode(response.body);

  //     phoneNumber = responseData['data']['phone'];
  //     final String id = responseData['data']['_id'];
  //     final String firstDigit = id.substring(0, 1);
  //     final int firstDigitAsInt = int.parse(firstDigit, radix: 16);
  //     // print(phoneNumber);

  //     final UserModel users = UserModel(
  //         id: firstDigitAsInt,
  //         phone: responseData['data']['phone'],
  //         role: responseData['data']['role'],
  //         firstName: responseData['data']['first_name'],
  //         lastName: responseData['data']['last_name'],
  //         email: responseData['data']['email'],
  //         address: responseData['data']['address'],
  //         city: responseData['data']['city'],
  //         state: responseData['data']['state'],
  //         gender: responseData['data']['gender'],
  //         dateOfBirth: responseData['data']['date_of_birth'],
  //         country: responseData['data']['country'],
  //         nationality: responseData['data']['nationality'],
  //         pinCode: responseData['data']['pin_code']);

  //     final database = DatabaseProvider();

  //     await database.insertUser(users);

  //     print(user.phone);
  //     if (kDebugMode) {
  //       print('-----User Profile Preview: $responseData');
  //     }
  //     return users; // Return the fetched user profile data
  //   } else {
  //     // Handle error response
  //     if (kDebugMode) {
  //       print(
  //           '-----Failed to fetch user profile preview. Error: ${response.statusCode}');
  //     }
  //     return null; // Return null in case of error
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // fetchData() async {
  //   await fetchUserProfilePreview(); // Wait for user profile preview to fetch
  //   getUser(); // Get the user after fetching the profile
  // }

  getUser() async {
    await db.retrieveUserFromTable().then((value) {
      setState(() {
        user = value;
      });
    });
  }
//  getUserDetails(HomeProvider provider, String token) async {

//     try {
//      final  responsedata = await provider.fetchUserProfilePreview(token);
//      var  data = jsonDecode(responsedata);
// final phoneNumber = data['data']['phone'];

//        role  = data['data']['role'];

//        print(role);

//      UserModel user = UserModel(
//       phone: phoneNumber
//      );

// final database = DatabaseProvider();
//      database.insertUser(user);

//     } catch (e) {
//       AnimatedSnackBar.material(
//         e.toString(),
//         type: AnimatedSnackBarType.success,
//         duration: const Duration(seconds: 5),
//         mobileSnackBarPosition: MobileSnackBarPosition.top,
//       ).show(context);
//     }

//   }

  List<void Function()> onTapFunctions = [
    () {},
    () {},
    () {},
    () {},
    () {},
    () {},
    () {},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(children: [
                      CircleAvatar(
                        backgroundColor: baseColor,
                        radius: size.height * .047,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: size.height * .03,
                        ),
                      ),
                    ]),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              user.email.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const Text(
                          'View and edit profile',
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        const Text(
                          '9% completed',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 226, 225, 225),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Practo  '),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 1),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 185, 48, 156),
                                borderRadius: BorderRadius.circular(3)),
                            child: const Center(
                              child: Text(
                                'PLUS',
                                style: TextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Text('Health Plan for you famiy')
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 10,
              color: Color.fromARGB(255, 226, 225, 225),
            ),
            ListView.builder(
              itemCount: drawerTitle.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    // onTapFunctions[index].call();

                    switch (index) {
                      case 0:
                        break;
                      case 1:
                        break;
                      case 2:
                        break;
                      case 3:
                        break;
                      case 4:
                        break;
                      case 5:
                        break;

                      case 6:
                        showLogoutDialog(context);

                        break;
                      default:
                        // Handle default case
                        break;
                    }
                  },
                  leading: drawerIcons[index],
                  title: Text(drawerTitle[index]),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                );
              },
            ),
            const Divider(
              thickness: 10,
              color: Color.fromARGB(255, 226, 225, 225),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(appVersion)
          ],
        ),
      ),
    );
  }

  showLogoutDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Continue",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        logoutUser();
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      title: const Text("Confirm Logout"),
      content: Text(
        "${user.email}, Are you sure to logout from this device.",
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  logoutUser() async {
    try {
      await DatabaseProvider().clearUserTable();

      setState(() {
        user = UserModel();
      });

      Navigator.pushNamedAndRemoveUntil(context, mobileRoute, (route) => false);

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            Widget continueButton = TextButton(
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(7)),
                child: const Center(
                  child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            );

            return AlertDialog(
              title: const Text("User logged out successfully!"),
              actions: [continueButton],
              actionsAlignment: MainAxisAlignment.center,
            );
          });
    } catch (e) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            Widget continueButton = TextButton(
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(7)),
                child: const Center(
                  child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            );

            return AlertDialog(
              title: const Text("Something went wrong, Try again later."),
              actions: [continueButton],
              actionsAlignment: MainAxisAlignment.center,
            );
          });

      rethrow;
    }
  }
}
