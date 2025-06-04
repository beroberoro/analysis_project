// profile_page.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFE3F2FD),
    automaticallyImplyLeading: false,
    title: Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      // زر الإعدادات على اليسار
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),


        // العنوان في النص
      const Text(
      "Profile",
      style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Color(0xFF0D47A1),
      ),
      ),

      // صورة البروفايل على اليمين
      GestureDetector(
      child: const CircleAvatar(
      radius: 25,
      backgroundImage: AssetImage('assets/download.png'),
      backgroundColor: Colors.transparent,
      ),
      ),
      ],
      ),
    ),
        ),

    body: const Center(
        child: Text(
          "Patient information here",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
