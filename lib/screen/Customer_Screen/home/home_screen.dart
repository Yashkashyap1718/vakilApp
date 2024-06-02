// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:vakil_app/model/user_model.dart';
import 'package:vakil_app/screen/Customer_Screen/Appointment%20details/appointment_details.dart';
import 'package:vakil_app/screen/Customer_Screen/drawer/drawer.dart';
import 'package:vakil_app/screen/Customer_Screen/video_consult/video_consult.dart';
import 'package:vakil_app/services/database_provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLocation = 'Location 1';
  late FocusNode _focusNode;

  final TextEditingController searchController = TextEditingController();

  final List gridImages = [
    doctorImg,
    doctorImg,
  ];
  final List listImages = [lawImg, lawImg, lawImg];
  final List gridText = ["Book\nAppointment", "Instant Video\nConsult"];
  final List gridbelowText = ["Confirm appointment", "Correct within 60 secs"];
  final List ListText = ["Medicine", "Lab Tests", "Surgeries"];

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
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: whiteColor,
        // leading: Padding(
        //   padding: const EdgeInsets.all(10.5),
        //   child: CircleAvatar(
        //     child: IconButton(
        //         onPressed: () => MyDrawer,
        //         icon: const Icon(
        //           Icons.person,
        //           size: 20,
        //         )),
        //   ),
        // ),
        title: DropdownButton<String>(
          value: selectedLocation,
          underline: const Text(''),
          onChanged: (String? newValue) {
            setState(() {
              selectedLocation = newValue!;
            });
          },
          items: <String>[
            'Location 1',
            'Location 2',
            'Location 3',
            'Location 4'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 15,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 8),
              child: Container(
                height: 45,
                // width: size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 240, 240),
                    border: Border.all(
                        color: const Color.fromARGB(134, 218, 215, 215)),
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(_focusNode);
                        },
                        child: TextField(
                          focusNode: _focusNode,
                          controller: searchController,
                          onChanged: (value) {},
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Search here....',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(133, 109, 106, 106))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GridView.builder(
                      itemCount: gridImages.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              childAspectRatio: 12 / 17),
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AppointmentDetailsScreen()),
                                );
                                break;
                              case 1:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VideoConsultScreen()),
                                );
                                break;
                              // Add more cases for other indices as needed
                              default:
                              // Do nothing or show an error message for unsupported indices
                            }
                          },
                          child: Container(
                            // height: size.height,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black54, blurRadius: 1.5)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: grey2Color)),
                            child: Column(
                              children: [
                                Container(
                                  height: size.height * .19,
                                  width: double.infinity,
                                  color: Colors.amber,
                                  child: Image.asset(
                                    gridImages[index],
                                    // scale: 1,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            gridText[index],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            gridbelowText[index],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                      itemCount: listImages.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 12 / 16,
                              crossAxisSpacing: 15),
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          // height: size.height,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: grey2Color)),
                          child: Column(
                            children: [
                              Container(
                                height: size.height * .13,
                                width: double.infinity,
                                color: Colors.amber,
                                child: Image.asset(
                                  listImages[index],
                                  scale: 5,
                                  // fit: BoxFit.fitHeight,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Center(
                                  child: Text(
                                    ListText[index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
            const Divider(
              color: grey2Color,
              thickness: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star_border_outlined, size: 22),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Featured Services',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Image.asset(bannerImg),
                  ),
                  SizedBox(
                    height: size.height * .35,
                    child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, indx) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                      image: AssetImage(banner4Img),
                                      fit: BoxFit.fill)),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(
                color: grey2Color,
                thickness: 7,
              ),
            ),
            Container(
              color: baseColor,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Icon(Icons.card_giftcard,
                              size: 22, color: whiteColor),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Best Offers',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: whiteColor),
                              ),
                              Text(
                                'Explore deals, offers, health updates and more',
                                style:
                                    TextStyle(fontSize: 14, color: whiteColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        height: size.height * .25,
                        child: ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, indx) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: size.width / 1.3,
                                  decoration: const BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      image: DecorationImage(
                                          image: AssetImage(banner5Img),
                                          fit: BoxFit.fill)),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(
                color: grey2Color,
                thickness: 7,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.near_me,
                    size: 22,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Find Doctor's Available Near You",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: size.height * .3,
                child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, indx) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: size.width / 1.3,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 45,
                                    backgroundImage: AssetImage(doctorImg),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dr. Leelamohan PVR',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('General Physician'),
                                        Text('HSR Layout'),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_up_alt,
                                              color: Colors.green,
                                              size: 18,
                                            ),
                                            Text(' 91% • 12 Years Exp')
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 45,
                                    backgroundImage: AssetImage(doctorImg),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dr. Leelamohan PVR',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('General Physician'),
                                        Text('HSR Layout'),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_up_alt,
                                              color: Colors.green,
                                              size: 18,
                                            ),
                                            Text(' 91% • 12 Years Exp')
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Center(
                    child: Text('See All Doctor'),
                  )),
            ),
            Container(
              // height: size.height / 2,
              width: size.width,
              color: baseColor,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Text(
                            'Akash Kashyap',
                            style: TextStyle(color: whiteColor, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Our vision is to help mankind live healthier, longer lives by making quality healthcare accssible, affordable and convenient.',
                      style: TextStyle(color: Colors.white54, fontSize: 15),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Made by Akash Kashyap Rajput © Ambala',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
