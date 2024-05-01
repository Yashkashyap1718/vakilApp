import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vakil_app/constants/colors.dart';
import 'package:vakil_app/constants/image.dart';
import 'package:vakil_app/utils/utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoConsultScreen extends StatefulWidget {
  const VideoConsultScreen({super.key});

  @override
  State<VideoConsultScreen> createState() => _VideoConsultScreenState();
}

class _VideoConsultScreenState extends State<VideoConsultScreen> {
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
        title: const Text('Summary',
            style: TextStyle(color: whiteColor, fontSize: 17)),
      ),
      body: Stack(children: [
        SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Consulting for Psychologicaal\nCounselling',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                          radius: 33,
                          backgroundImage: AssetImage(doctorImg),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  const Row(
                    children: [
                      Text(
                        'WE WILL ASSIGN YOU A TOP DOCTOR FROM BELOW',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        'View our doctor currently online',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      height: size.height * .1,
                      child: ListView.builder(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, indx) {
                            return Container(
                              width: size.width / 1.5,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 28,
                                        backgroundImage: AssetImage(doctorImg),
                                      ),
                                      const Padding(
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
                                            Row(
                                              children: [
                                                Text(
                                                  '12 ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('Years Exp'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '6544',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(' consultations')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Container(
                                          height: size.height / 11,
                                          width: 1.5,
                                          color: const Color.fromARGB(
                                              255, 218, 213, 213),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 15,
              color: Color.fromARGB(255, 230, 227, 227),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.blue),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Single online consultation',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Chat, audio,video consultaion and\nfree 7 day follow up',
                    style: TextStyle(
                        fontSize: 12,
                        color: hintTextColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(14),
                width: size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 199, 227, 200),
                    borderRadius: BorderRadius.circular(8)),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "You will also get a ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: 'Free follow-up for 7 days ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "with\nevery consultation",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 7,
              color: Color.fromARGB(255, 230, 227, 227),
            ),
            const ListTile(
              leading: Icon(
                Icons.percent_rounded,
                color: Color.fromARGB(255, 149, 146, 146),
                size: 20,
              ),
              title: Text(
                'APPLY COUPON CODE',
                style: TextStyle(
                  color: Color.fromARGB(255, 149, 146, 146),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Color.fromARGB(255, 149, 146, 146),
              ),
            ),
            const Divider(
              thickness: 7,
              color: Color.fromARGB(255, 230, 227, 227),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Data and Privacy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'The Contents of your consultations are private and confidential.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 149, 146, 146),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "By proceeding to avail a consultation, you agree to ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 149, 146, 146),
                              fontSize: 10,
                              fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: 'Prarcto Terrms of use',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color.fromARGB(255, 230, 227, 227),
              width: size.width,
              child: const Column(children: [
                Text(
                  'Practo Guarantee: 100% Money back if no response',
                  style: TextStyle(
                      color: Color.fromARGB(255, 116, 113, 113),
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  'Not forr emergency user',
                  style: TextStyle(
                      color: Color.fromARGB(255, 116, 113, 113),
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
              color: Color.fromARGB(255, 230, 227, 227),
            ),
            SizedBox(
              height: size.height / 6,
            ),
          ],
        )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: size.height * .13,
            width: size.width,
            color: whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Pay Using   ',
                            style: TextStyle(
                                color: Color.fromARGB(255, 116, 113, 113),
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          Image.asset(
                            'assets/paytm.png',
                            scale: size.width * .05,
                          ),
                        ],
                      ),
                      const Text(
                        'More Payment Options >',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LiveCall()));
                    },
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          '₹1049 | Pay & Consult',
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

final String localUserId = math.Random().nextInt(10000).toString();

class LiveCall extends StatefulWidget {
  const LiveCall({super.key});

  @override
  State<LiveCall> createState() => _LiveCallState();
}

class _LiveCallState extends State<LiveCall> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ZegoUIKitPrebuiltCall(
      appID: Utils.appId,
      appSign: Utils.appSignId,
      callID: '1',
      userID: localUserId,
      userName: 'user_$localUserId',
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..hangUpConfirmDialog,
    ));
  }
}
