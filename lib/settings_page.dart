import 'package:flutter/material.dart';
import 'login_page.dart'; // تأكد إن الملف موجود

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade200,
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.only(bottom: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.blue),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                "Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.info, color: Colors.blue),
            title: Text("About App"),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  "The application is designed to assist doctors in making faster, more accurate diagnoses by generating concise, data-driven reports that support medical staff and reduce overall diagnostic time.",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                Text(
                  "Additionally, it empowers patients with advanced early disease‑detection tools, helping them identify potential conditions before symptoms worsen and ultimately improving healthcare outcomes.",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          const ListTile(
            leading: Icon(Icons.email, color: Colors.blue),
            title: Text("Contact Emails"),
          ),
          // قائمة البريد الإلكتروني
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.email_outlined, size: 20, color: Colors.blue),
                  title: Text("aaliabdelhameed1@gmail.com"),
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined, size: 20, color: Colors.blue),
                  title: Text("support@medapp.com"),
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined, size: 20, color: Colors.blue),
                  title: Text("developer@medapp.com"),
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined, size: 20, color: Colors.blue),
                  title: Text("feedback@medapp.com"),
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined, size: 20, color: Colors.blue),
                  title: Text("contact@medapp.com"),
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined, size: 20, color: Colors.blue),
                  title: Text("admin@medapp.com"),
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined, size: 20, color: Colors.blue),
                  title: Text("info@medapp.com"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(), // إضافة فاصل بين المحتوى وقسم الإصدار
          const ListTile(
            leading: Icon(Icons.add_box, color: Colors.blue), // أيقونة للإصدار
            title: Text("Edition" , style: TextStyle(fontSize: 20,),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("V 1.0", style: TextStyle(fontSize: 20,),),
                Text("First Release"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text("تسجيل الخروج"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade200,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}