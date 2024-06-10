import 'package:flutter/material.dart';
import 'package:vakil_app/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakil_app/screen/Customer_Screen/Appointment%20details/doctor_details.dart';

import '../../../constants/image.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  String selectedLocation = 'Location 1';
  final TextEditingController searchController = TextEditingController();
  final List gridImages = [
    doctorImg,
    doctorImg,
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: baseColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: whiteColor,
            )),
        title: const Text(
          'Find Your Law Concern',
          style: TextStyle(color: whiteColor, fontSize: 16),
        ),
        actions: [
          DropdownButton<String>(
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
                    const Icon(Icons.location_on, size: 15, color: whiteColor),
                    const SizedBox(width: 3),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
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
                      child: TextField(
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
                  ],
                ),
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 229, 228, 228),
              height: 30,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Result offering",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: ' Prime ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.purple,
                              ),
                            ),
                            TextSpan(
                              text: "benifits",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, indx) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorDetails()));
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        Row(
                                          children: [
                                            Text(
                                              'Lawer Leelamohan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              child: Icon(
                                                Icons.check_circle_outline,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text('Corporate Lawyer'),
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
                              const SizedBox(
                                height: 15,
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Hrs Layout •",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        TextSpan(
                                          text: ' deal with legal concerns',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "~ ₹ 850",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        TextSpan(
                                          text: ' Consultantion Frees',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'NEXT AVAILABLE AT',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.video_call_outlined,
                                        color: Colors.purple,
                                        size: 20,
                                      ),
                                      Text(
                                        ' available for video consult',
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          launchUrl(
                                              Uri.parse('tel:+918168605829'));
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border:
                                                Border.all(color: Colors.blue),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Contact Lawer',
                                              style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.blue),
                                          child: const Center(
                                            child: Text(
                                              'Book Clinic Visit',
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 6,
                        )
                      ],
                    ),
                  );
                }),
            Divider()
          ],
        ),
      ),
    );
  }
}
