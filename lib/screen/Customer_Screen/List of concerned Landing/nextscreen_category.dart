import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakil_app/Provider/home_provider.dart';
import 'package:vakil_app/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:vakil_app/screen/Customer_Screen/Appointment%20details/appointment_details.dart';
import 'package:vakil_app/services/api_constant.dart';

class Subcategory extends StatefulWidget {
  const Subcategory({super.key, required this.slug});

  final String slug;

  @override
  State<Subcategory> createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  String selectedLocation = 'Location 1';
  final TextEditingController searchController = TextEditingController();

  late FocusNode _focusNode;

  List<dynamic> getData = [];
  List<dynamic> _filteredData = [];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    super.initState();
    listofConcernedLanding(provider.accessToken);
    _focusNode = FocusNode();
  }

  Future<void> listofConcernedLanding(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseURL + userAdvocateConcernedLandingPageEndpoint),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      //  data = jsonDecode(response.body);

      setState(() {
        // getData = data['data'];
        _filteredData = getData;
      });

      print(response.body);
    } catch (e) {
      print('-------------for fetch landing page -----$e');
    }
  }

  void _filterData(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredData = getData;
      });
    } else {
      setState(() {
        _filteredData = getData
            .where((item) => item['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
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
                        onChanged: (value) {
                          _filterData(value);
                        },
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
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredData.length,
                itemBuilder: (BuildContext context, index) {
                  final item = _filteredData[index];
                  final imageUrl = baseImageURL + item['image'];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AppointmentDetailsScreen()));
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 0.5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.network(
                                imageUrl,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      item['status'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: item['status'] == 'Active'
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
