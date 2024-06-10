import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakil_app/constants/colors.dart';
import 'package:vakil_app/constants/image.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFilled = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
            onPressed: () {
              setState(() {
                _isFilled = !_isFilled;
              });
              if (_isFilled) {
                AnimatedSnackBar.material(
                  'Icon is now filled',
                  type: AnimatedSnackBarType.success,
                  duration: const Duration(seconds: 3),
                  mobileSnackBarPosition: MobileSnackBarPosition.top,
                ).show(context);
              }
            },
            icon: Icon(
              _isFilled ? Icons.star : Icons.star_border,
              color: _isFilled ? whiteColor : Colors.grey,
            ),
          ),
          IconButton(
              onPressed: () {
                Share.share(
                  'https://play.google.com/store/apps/details?id=com.dr.ortho.drortho&pcampaignid=web_share',
                );
              },
              icon: const Icon(
                Icons.share_outlined,
                color: whiteColor,
              ))
        ],
      ),
      body: Stack(children: [
        SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                              'Lawer Leelamohan',
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                decoration: BoxDecoration(
                  color: grey2Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                  labelColor: baseColor,
                  unselectedLabelColor:
                      const Color.fromARGB(255, 163, 161, 161),
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: whiteColor, // Color of selected tab indicator
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Clinic',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Video',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // color: Color.fromARGB(255, 128, 126, 126),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 200, // Adjust height as needed
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Container for Clinic Visit content
                  Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        'Clinic Visit Content',
                        style: TextStyle(fontSize: 20, color: whiteColor),
                      ),
                    ),
                  ),
                  // Container for Video Consult content
                  Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Video Consult Content',
                        style: TextStyle(fontSize: 20, color: whiteColor),
                      ),
                    ),
                  ),
                ],
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
                          'Advocate Fiendliness',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '80% clients find the advocate friendly and approachable',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.handshake),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advocate Fiendliness',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '80% clients find the advocate friendly and approachable',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.handshake),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advocate Fiendliness',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '80% clients find the advocate friendly and approachable',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.handshake),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advocate Fiendliness',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '80% clients find the advocate friendly and approachable',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
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
                      onTap: () {},
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue),
                        child: const Center(
                          child: Text(
                            'Book Lawer visit',
                            style: TextStyle(
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
                      onTap: () {
                        launchUrl(Uri.parse('tel:+918168605829'));
                      },
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
    );
  }
}
