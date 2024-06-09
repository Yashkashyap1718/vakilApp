import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakil_app/Provider/home_provider.dart';
import 'package:vakil_app/constants/colors.dart';

import 'package:http/http.dart' as http;
import 'package:vakil_app/services/api_constant.dart';

class ListOfConcernedUserLandingPage extends StatefulWidget {
  const ListOfConcernedUserLandingPage({super.key});

  @override
  State<ListOfConcernedUserLandingPage> createState() =>
      _ListOfConcernedUserLandingPageState();
}

class _ListOfConcernedUserLandingPageState
    extends State<ListOfConcernedUserLandingPage> {
  String selectedLocation = 'Location 1';
  final TextEditingController searchController = TextEditingController();

  late FocusNode _focusNode;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listofConcernedLanding();
    _focusNode = FocusNode();

    // print('------token------${provider.accessToken}');
    // getUserDetails(provider);
  }

  String landName = '';
  String landImage = '';
  String landStatus = '';
  listofConcernedLanding() async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    try {
      final response = await http.get(
        Uri.parse(baseURL + listOfAllConcernedLandingPageEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': provider.accessToken,
        },
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      final getData = data['data'];

      landName = getData[0]['name'];
      landImage = getData[0]['image'];
      landStatus = getData[0]['status'];

      print(response.body);
    } catch (e) {
      print('-------------for fetch landing page -----$e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 8),
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
          ListView.builder(
              shrinkWrap: true,
              itemCount: landName.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5)),
                  child: Column(
                    children: [Text(landName[index])],
                  ),
                );
              })
        ],
      ),
    );
  }
}
