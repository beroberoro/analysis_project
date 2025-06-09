// settings_page.dart
import 'package:flutter/material.dart';

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
        backgroundColor: const Color(0xFFE3F2FD),
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.only(bottom: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                "Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            secondary: const Icon(Icons.color_lens),
            value: isDarkMode,
            onChanged: (val) {
              setState(() {
                isDarkMode = val;
              });
            },
          ),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text("About App"),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "This medical analysis app helps patients and doctors easily share and visualize lab reports and x-rays, offering AI-based predictions and tracking progress over time.",
              style: TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 20),
          const ListTile(
            leading: Icon(Icons.email),
            title: Text("Contact Emails"),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("support@medapp.com"),
                SizedBox(height: 5),
                Text("developer@medapp.com"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

