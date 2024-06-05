import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakil_app/Provider/home_provider.dart';
import 'package:vakil_app/constants/colors.dart';
import 'package:vakil_app/utils/loadingWrapper.dart';

class EmailEditScreen extends StatefulWidget {
  const EmailEditScreen({super.key});

  @override
  State<EmailEditScreen> createState() => _EmailEditScreenState();
}

class _EmailEditScreenState extends State<EmailEditScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  bool _isCodeSent = false;

  sendEmailCode(HomeProvider provider) async {
    try {
      setState(() {
        _isCodeSent = true;
      });
      provider.showLoader();
      final response =
          await provider.sendEmail(_emailController.text, provider.accessToken);

      provider.hideLoader();
    } catch (e) {
      print(e);
    }
  }

  verifyEmailCode(HomeProvider provider) async {
    try {
      provider.showLoader();

      await provider.verifyEmail(
          '', _emailController.text, provider.accessToken);
      provider.hideLoader();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWrapper(
      child: Scaffold(
        backgroundColor: baseColor,
        appBar: AppBar(
          backgroundColor: baseColor,
          elevation: 2,
          title: const Text(
            'add email',
            style: TextStyle(color: whiteColor),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: whiteColor,
              )),
        ),
        body: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Text(
                        'What is your email id?',
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: whiteColor),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isCodeSent
                        ? () => verifyEmailCode(value)
                        : () => sendEmailCode(value),
                    child: Text(_isCodeSent ? 'Code Sent' : 'Send Code'),
                  ),
                  const SizedBox(height: 20),
                  _isCodeSent
                      ? TextField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: whiteColor),
                          decoration: const InputDecoration(
                            labelText: 'Enter Code',
                            labelStyle: TextStyle(color: whiteColor),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
