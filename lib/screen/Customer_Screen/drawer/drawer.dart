import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vakil_app/constants/colors.dart';
import 'package:vakil_app/model/user_model.dart';
import 'package:vakil_app/services/database_provider.dart';
// import 'package:package_info_plus/package_info_plus.dart';

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
  // DatabaseProvider db = DatabaseProvider();

  // getUser() {
  //   db.getUsers().then(
  //     (v) {
  //       setState(() {
  //         user = v;
  //       });
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // getUser();
    // _fetchAppVersion();
  }

  // Future<void> _fetchAppVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   setState(() {
  //     appVersion = "v. ${packageInfo.version}";
  //   });
  // }

  List<void Function()> onTapFunctions = [
    () {
      print('Tapped on item 0');
    },
    () {
      print('Tapped on item 1');
    },
    () {
      print('Tapped on item 2');
    },
    () {
      print('Tapped on item 3');
    },
    () {
      print('Tapped on item 4');
    },
    () {
      print('Tapped on item 5');
    },
    () {
      print('Tapped on item 6');
    },
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: size.height * .047,
                        ),
                      ),
                    ]),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user.phone.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
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
                    onTapFunctions[index]?.call();
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
}
