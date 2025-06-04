import 'package:flutter/material.dart';

class GeneratePdfPage extends StatefulWidget {
  final String testType;
  final Map<String, String> values;
  final String diagnosis;

  const GeneratePdfPage({
    super.key,
    required this.testType,
    required this.values,
    required this.diagnosis,
  });

  @override
  State<GeneratePdfPage> createState() => _GeneratePdfPageState();
}

class _GeneratePdfPageState extends State<GeneratePdfPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String gender = 'ذكر';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء ملف PDF"),
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "الاسم"),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "العمر"),
              ),
              const SizedBox(height: 24),
              const Text("النوع:", style: TextStyle(fontSize: 16)),

              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = 'ذكر';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: gender == 'ذكر' ? Colors.blue[100] : Colors.white,
                          border: Border.all(
                            color: gender == 'ذكر' ? Colors.blue : Colors.grey,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("ذكر")),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = 'أنثى';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: gender == 'أنثى' ? Colors.pink[100] : Colors.white,
                          border: Border.all(
                            color: gender == 'أنثى' ? Colors.pink : Colors.grey,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("أنثى")),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text("إنشاء PDF"),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("جارٍ إنشاء ملف PDF...")),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
