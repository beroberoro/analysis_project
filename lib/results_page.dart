// results_page.dart
import 'package:analysis_project/tips_page.dart';
import 'package:flutter/material.dart';

import 'generate_pdf_page.dart';
import 'medical_advice_page.dart';

class ResultsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ResultsPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String testType = data["testType"] ?? "Unknown Test";
    final Map<String, String> values = Map<String, String>.from(data["values"] ?? {});
    final String diagnosis = data["diagnosis"] ?? "No diagnosis available";

    return Scaffold(
      appBar: AppBar(
        title: Text(testType),
        backgroundColor: const Color(0xFFE3F2FD),
        foregroundColor: const Color(0xFF0D47A1),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF1F8E9),
              Color(0xFFE8F5E9),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (values.isNotEmpty) ...[
              Text(
                "Analysis results:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: values.length,
                  separatorBuilder: (_, __) => const Divider(color: Colors.grey),
                  itemBuilder: (context, index) {
                    String key = values.keys.elementAt(index);
                    String value = values[key]!;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          key,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          value,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ] else ...[
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "No analysis values available.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              "Diagnosis:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                diagnosis,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (MedicalAdvicePage.getTips(diagnosis).isNotEmpty)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green[200], ),
                    icon: const Icon(Icons.tips_and_updates),
                    label: const Text("Medical advice"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TipsPage(diagnosis: diagnosis),
                        ),
                      );
                    },
                  ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text("Generate PDF"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneratePdfPage(
                          diagnosis: diagnosis,
                          values: values,
                          testType: testType,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
