import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakil_app/constants/colors.dart';
import 'package:vakil_app/constants/image.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({super.key});

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
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.star_border_outlined,
                color: whiteColor,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share_outlined,
                color: whiteColor,
              ))
        ],
      ),
      body: Expanded(
        child: Stack(children: [
          SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: size.height * .075,
                          backgroundImage: const AssetImage(doctorImg),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. Leelamohan PVR',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color.fromARGB(255, 215, 213, 213))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text('App Logo'), Text('Clinics')],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              height: size.height * .05,
                              width: 1.5,
                              color: const Color.fromARGB(255, 218, 213, 213),
                            ),
                          ),
                          const Text('Comprehensive approach to\nhealthcare'),
                          const Icon(
                            Icons.info_outline,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    const ListTile(
                      dense: true,
                      leading: Icon(
                        Icons.check_circle_outline,
                        color: Colors.purple,
                        size: 20,
                      ),
                      title: Text(
                        'Lifestyle treament over medicone prescription',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const ListTile(
                      dense: true,
                      leading: Icon(
                        Icons.check_circle_outline,
                        color: Colors.purple,
                        size: 20,
                      ),
                      title: Text(
                        'Lifestyle treament over medicone prescription',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const ListTile(
                      dense: true,
                      leading: Icon(
                        Icons.check_circle_outline,
                        color: Colors.purple,
                        size: 20,
                      ),
                      title: Text(
                        'Lifestyle treament over medicone prescription',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 5),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  width: size.width,
                  // height: 100,
                  decoration: BoxDecoration(
                      color: grey2Color,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Clinic Visit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        child: const Center(
                          child: Text(
                            'Video Consult',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 128, 126, 126)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Highly Recommended for',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: Icon(Icons.handshake),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Doctor Fiendliness',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '80% patients find the doctor friendly and approachable',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width,
              color: whiteColor,
              height: size.height * .11,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse('tel:+918168605829'));
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue),
                          child: const Center(
                            child: Text(
                              'Book Lawer visit',
                              style: const TextStyle(
                                  color: whiteColor,
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
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blue, width: 2)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,
                                color: Colors.blue,
                                size: 20,
                              ),
                              Text(
                                ' Call Lawer',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
