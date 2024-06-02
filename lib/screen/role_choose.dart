import 'package:flutter/material.dart';
import 'package:vakil_app/screen/Admin_Screen/login.dart';

import 'Customer_Screen/Auth/enter_number.dart';

class RoleChooseScreen extends StatelessWidget {
  const RoleChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MobileScreen()),
                );
              },
              child: const Text('Customer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminLoginPage()),
                );
              },
              child: const Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Screen'),
      ),
      body: Center(
        child: const Text('Welcome, Admin!'),
      ),
    );
  }
}
