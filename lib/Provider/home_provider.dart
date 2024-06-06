import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vakil_app/screen/Customer_Screen/Auth/otp.dart';
import 'package:vakil_app/screen/Customer_Screen/home/home_screen.dart';
import 'package:vakil_app/services/api_constant.dart';

class HomeProvider extends ChangeNotifier {
  int pageIndex = 0;
  bool isLoading = false;
  late String _accessToken = '';
  late String temUserPhoneNumber = '';
  late String userEmail = '';

  String get _temUserPhoneNumber => temUserPhoneNumber;
  String get _userEmail => userEmail;

  void setUserEmail(String email) {
    userEmail = email;
  }

  void setTempNumber(String number) {
    temUserPhoneNumber = number;
  }

  String get accessToken => _accessToken;

  void setAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  updatePageIndex(v) {
    pageIndex = v;
  }

  showLoader() {
    isLoading = true;
    notifyListeners();
  }

  hideLoader() {
    isLoading = false;
    notifyListeners();
  }

  //////////   get user  //////////////
  fetchUserProfilePreview(String token) async {
    final response = await http.get(
      Uri.parse(baseURL + getuserProfileEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      // Handle success response
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print('-----User Profile Preview: $responseData');
      }
      return responseData; // Return the fetched user profile data
    } else {
      // Handle error response
      if (kDebugMode) {
        print(
            '-----Failed to fetch user profile preview. Error: ${response.statusCode}');
      }
      return null; // Return null in case of error
    }
  }

  //////////  update user //////////

  updateUserProfile(
      String token,
      context,
      String firstName,
      String lastName,
      String email,
      String gender,
      String DoB,
      String address,
      String city,
      String haryana,
      String pincode,
      String language) async {
    // Create the payload
    final Map<String, dynamic> payload = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "gender": gender,
      "date_of_birth": DoB,
      "nationality": "Indian",
      "address": address,
      "city": city,
      "state": haryana,
      "country": "india",
      "pin_code": pincode,
      "languages": language
    };

    // Convert the payload to JSON
    final String jsonPayload = jsonEncode(payload);

    // Set the headers
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'token': token
    };

    try {
      // Send the PUT request
      final http.Response response = await http.put(
        Uri.parse(baseURL + updateProfileEndpoint),
        headers: headers,
        body: jsonPayload,
      );

      print('----------updated-user-------------${response.body}');
      // Check the response status code
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Profile updated successfully');
        }

        AnimatedSnackBar.material(
          'Profile updated successfully',
          type: AnimatedSnackBarType.success,
          duration: const Duration(seconds: 5),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      } else {
        if (kDebugMode) {
          print(
              'Failed to update profile. Status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
    }
  }

  /////////   Send Email Verification Code /////////////

  sendEmail(String email, String token) async {
    // Create the payload
    final Map<String, dynamic> payload = {"email_address": email};

    // Convert the payload to JSON
    final String jsonPayload = jsonEncode(payload);

    // Set the headers
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'token': token
    };

    try {
      // Send the POST request
      final http.Response response = await http.post(
        Uri.parse(baseURL + sendEmailVerificationCode),
        headers: headers,
        body: jsonPayload,
      );

      print('-----------send----email---code-----${response.body}');
      // Check the response status code
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Email sent successfully');
        }
      } else {
        if (kDebugMode) {
          print('Failed to send email. Status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
    }
  }

  ///////////  Verify Email with Code   ///////////

  verifyEmail(String code, String email, String token) async {
    // Create the payload
    final Map<String, dynamic> payload = {"otp": code, "email_address": email};

    // Convert the payload to JSON
    final String jsonPayload = jsonEncode(payload);

    // Set the headers
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'token': token
    };

    try {
      // Send the PUT request
      final http.Response response = await http.put(
        Uri.parse(baseURL + verifyEmailCodeEndpoint),
        headers: headers,
        body: jsonPayload,
      );
      print('----------------verify-email-------${response.body}');
      // Check the response status code
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Email verified successfully');
        }
      } else {
        if (kDebugMode) {
          print('Failed to verify email. Status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
    }
  }

  //-----------------------------Advocate----------------------------------------

  ////   advocate login
  Future<void> advocatesendSignInRequest(
      context, String phone, HomeProvider provider) async {
    final Map<String, String> payload = {
      "country_code": "91",
      "mobile_number": phone
    };

    try {
      provider.showLoader();
      final http.Response response = await http.post(
        Uri.parse(baseURL + adminSignInEndpoint),
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
                      phoneNumder: phone,
                    )));
        final String msg = responseData['msg'];

        AssetsAudioPlayer.newPlayer()
            .open(Audio('vakilApp/assets/beap.mp3'), autoStart: true);
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

  ////  advocate confirmation
  Future<void> advocateConfirmOTP(
      context, String otp, String phoneNumber, HomeProvider prrovider) async {
    final Map<String, String> payload = {
      "otp": otp,
      "mobile_number": phoneNumber
    };

    if (kDebugMode) {
      print(payload);
    }

    try {
      prrovider.showLoader();

      final http.Response response = await http.post(
        Uri.parse(baseURL + adminConfirmationEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      var data = jsonDecode(response.body);

      // print(response.body);

      String confirmToken = data['token'];
      print(confirmToken);
      if (response.statusCode == 200) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        AnimatedSnackBar.material(
          'Welcome! User $phoneNumber',
          type: AnimatedSnackBarType.success,
          duration: const Duration(seconds: 5),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);

        prrovider.hideLoader();
      } else {
        throw Exception('Failed to confirm OTP');
      }

      prrovider.hideLoader();
    } catch (e) {
      prrovider.hideLoader();

      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occurred while confirming OTP.'),
        ),
      );
    }
  }

  ////  get adovate profile
  Future<void> getAdvocateProfilePreview(String token) async {
    final response = await http.get(
      Uri.parse(baseURL + getuserProfileEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Handle success response
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print('-----User Profile Preview: $responseData');
      }
    } else {
      // Handle error response
      if (kDebugMode) {
        print(
            '-----Failed to fetch user profile preview. Error: ${response.statusCode}');
      }
    }
  }

  //////////  update advocate //////////

  Future<void> updateAdvocateProfile() async {
    // Create the payload
    final Map<String, dynamic> payload = {
      "first_name": "Neeraj",
      "last_name": "Kumar",
      "email": "neeraj05rajput@gmail.com",
      "gender": "male",
      "date_of_birth": "1992-09-05",
      "nationality": "Indian",
      "address": "#234",
      "city": "gurgaon",
      "state": "haryana",
      "country": "india",
      "pin_code": "122001",
      "languages": ["english", "hindi", "punjabi"]
    };

    // Convert the payload to JSON
    final String jsonPayload = jsonEncode(payload);

    // Set the headers
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      // Send the PUT request
      final http.Response response = await http.put(
        Uri.parse(baseURL + updateProfileEndpoint),
        headers: headers,
        body: jsonPayload,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Profile updated successfully');
        }
      } else {
        if (kDebugMode) {
          print(
              'Failed to update profile. Status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
    }
  }

  /////  add category for Advocate
  Future<void> createCategory(String name, String base64Image) async {
    // Create the payload
    final Map<String, dynamic> payload = {"name": name, "image": base64Image};

    // Convert the payload to JSON
    final String jsonPayload = jsonEncode(payload);

    // Set the headers
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      // Send the POST request
      final http.Response response = await http.post(
        Uri.parse(baseURL + adminCategoryListEndpoint),
        headers: headers,
        body: jsonPayload,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        print('Category created successfully');
      } else {
        print('Failed to create category. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  ////  get category List
  Future<void> fetchCategories(String token) async {
    // Set the headers with the token
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      // Send the GET request
      final http.Response response = await http.get(
        Uri.parse(baseURL + adminCategoryListEndpoint),
        headers: headers,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the response body
        final List<dynamic> categories = jsonDecode(response.body);
        print('Categories fetched successfully: $categories');
      } else {
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  ////    Add Sub Category
  Future<void> createSubcategory(
      String categoryId, String name, String base64Image) async {
    // Create the payload
    final Map<String, dynamic> payload = {
      "category_id": categoryId,
      "name": name,
      "image": base64Image
    };

    // Convert the payload to JSON
    final String jsonPayload = jsonEncode(payload);

    // Set the headers
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      // Send the POST request
      final http.Response response = await http.post(
        Uri.parse(baseURL + adminAddSubCategoryEndpoint),
        headers: headers,
        body: jsonPayload,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        print('Subcategory created successfully');
      } else {
        print(
            'Failed to create subcategory. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  ////   Subcategory List
  Future<void> fetchSubcategories(String categoryId) async {
    // Add the query parameter
    final Uri uri = Uri.parse(baseURL + adminSubCategoryListEndpoint)
        .replace(queryParameters: {"category_id": categoryId});

    // Set the headers
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      // Send the GET request
      final http.Response response = await http.get(
        uri,
        headers: headers,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the response body
        final List<dynamic> subcategories = jsonDecode(response.body);
        print('Subcategories fetched successfully: $subcategories');
      } else {
        print(
            'Failed to fetch subcategories. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  ////_______________________without Token______________________

  Future<void> fetchListOfAllConcerned() async {
    // Define the URL
    final String url = 'http://172.93.54.177:3001/list_of_all_cencerned';

    // Set the headers
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      // Send the GET request
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> listOfConcerned = jsonDecode(response.body);
        print('List of all concerned fetched successfully: $listOfConcerned');
      } else {
        print(
            'Failed to fetch list of all concerned. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
    }
  }
}
