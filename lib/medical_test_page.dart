// medical_test_page.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'api.dart';
import 'results_page.dart';

class MedicalTestPage extends StatefulWidget {
  final String title;
  const MedicalTestPage({Key? key, required this.title}) : super(key: key);

  @override
  _MedicalTestPageState createState() => _MedicalTestPageState();
}

class _MedicalTestPageState extends State<MedicalTestPage> {
  late List<String> fields;
  final Map<String, TextEditingController> controllers = {};
  final Api api = Api(dio: Dio(), apiKey: ""); // ضع مفتاحك هنا

  @override
  void initState() {
    super.initState();

    switch (widget.title) {
      case "Diabetes":
        fields = [
          "gender", "age", "hypertension", "heart disease", "smoking history",
          "bmi", "HbA1c level", "blood glucose level"
        ];
        break;
      case "Liver Disease":
        fields = [
          "Age", "Gender", "BMI", "Alcohol Consumption", "Smoking",
          "Genetic Risk", "Physical Activity", "Diabetes", "Hypertension",
          "Liver Function Test"
        ];
        break;
      case "Anemia":
        fields = ["Gender", "Hemoglobin", "MCH", "MCHC", "MCV"];
        break;
      case "Viral infection":
        fields = [
          "WBCS", "RBCs", "Haemoglobin", "Hematocrit (PCV)", "M.C.V", "M.C.H",
          "M.C.H.C", "RDW", "Platelets Count", "MPV", "Neutrophils%", "Neutrophils#",
          "Lymphocytes%", "Lymphocytes#", "Monocyte%", "Monocyte#", "Eosinophils%",
          "Eosinophils#", "Basophils%", "Basophils#", "Large Unstained Cells%",
          "Large Unstained Cells#"
        ];
        break;
      case "Parkinsons":
        fields = [
          "Age", "Gender", "Ethnicity", "Education Level", "BMI", "Smoking",
          "Alcohol Consumption", "Physical Activity", "Diet Quality", "Sleep Quality",
          "Family History Parkinsons", "Traumatic Brain Injury", "Hypertension",
          "Diabetes", "Depression", "Stroke", "SystolicBP", "DiastolicBP",
          "Cholesterol Total", "Cholesterol LDL", "Cholesterol HDL",
          "Cholesterol Triglycerides", "UPDRS", "MoCA", "Functional Assessment",
          "Tremor", "Rigidity", "Bradykinesia", "Postural Instability",
          "Speech Problems", "Sleep Disorders", "Constipation"
        ];
        break;
      default:
        fields = ["Value 1", "Value 2"];
    }

    for (var field in fields) {
      controllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _sendDataToBackend() async {
    Map<String, String> data = {
      "testType": widget.title,
      for (var field in fields) field: controllers[field]!.text,
    };

    String diagnosis = await api.sendMedicalReport(data, widget.title);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          data: {
            "testType": widget.title,
            "values": data,
            "diagnosis": diagnosis,

          }, title: widget.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: fields.length,
                  itemBuilder: (context, index) {
                    final field = fields[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              field,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: controllers[field],
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                              ],
                              decoration: InputDecoration(
                                hintText: "Enter value",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: _sendDataToBackend,
                icon: const Icon(Icons.send),
                label: const Text("Send"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
