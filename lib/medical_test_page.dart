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
  bool requiresGender = false;
  int genderValue = 0;
  final Map<String, TextEditingController> controllers = {};
  final Api api = Api(dio: Dio(), apiKey: "");
  bool _isLoading = false;

  // Shared binary variables
  int smokingValue = 0;
  int diabetesValue = 0;
  int hypertensionValue = 0;
  int geneticRiskValue = 0;

  // Diabetes-specific variables
  int heartDiseaseValue = 0;
  int smokingCurrentValue = 0;
  int smokingNonSmokerValue = 0;
  int smokingPastSmokerValue = 0;
  int genderFemaleValue = 0;
  int genderMaleValue = 0;

  // Parkinsons-specific
  int ethnicityValue = 0;
  int educationLevelValue = 0;
  int familyHistoryParkinsonsValue = 0;
  int traumaticBrainInjuryValue = 0;
  int depressionValue = 0;
  int strokeValue = 0;
  int tremorValue = 0;
  int rigidityValue = 0;
  int bradykinesiaValue = 0;
  int posturalInstabilityValue = 0;
  int speechProblemsValue = 0;
  int sleepDisordersValue = 0;
  int constipationValue = 0;

  @override
  void initState() {
    super.initState();
    switch (widget.title) {
      case "Diabetes":
        requiresGender = true;
        fields = [
          "age", "bmi", "HbA1c_level", "blood_glucose_level"
        ];
        for (var field in fields) {
          controllers[field] = TextEditingController();
        }
        break;
      case "Liver Disease":
        requiresGender = true;
        fields = [
          "Age", "Gender", "BMI", "AlcoholConsumption", "Smoking", "GeneticRisk",
          "PhysicalActivity", "Diabetes", "Hypertension", "LiverFunctionTest"
        ];
        break;
      case "Anemia":
        requiresGender = true;
        fields = ["Gender", "Hemoglobin", "MCH", "MCHC", "MCV"];
        break;
      case "Viral infection":
        requiresGender = false;
        fields = [
          "WBCS", "RBCs", "Haemoglobin", "Hematocrit (PCV)", "M.C.V", "M.C.H",
          "M.C.H.C", "RDW", "Platelets Count", "MPV", "Neutrophils%",
          "Neutrophils#", "Lymphocytes%", "Lymphocytes#", "Monocyte%",
          "Monocyte#", "Eosinophils%", "Eosinophils#", "Basophils%",
          "Basophils#", "Large Unstained Cells%", "Large Unstained Cells#"
        ];
        break;
      case "Parkinsons":
        requiresGender = true;
        fields = [
          "Age", "Gender", "Ethnicity", "EducationLevel", "BMI",
          "Smoking", "AlcoholConsumption", "PhysicalActivity", "DietQuality", "SleepQuality",
          "FamilyHistoryParkinsons", "TraumaticBrainInjury", "Hypertension",
          "Diabetes", "Depression", "Stroke", "SystolicBP", "DiastolicBP",
          "CholesterolTotal", "CholesterolLDL", "CholesterolHDL",
          "CholesterolTriglycerides", "UPDRS", "MoCA", "FunctionalAssessment",
          "Tremor", "Rigidity", "Bradykinesia", "PosturalInstability",
          "SpeechProblems", "SleepDisorders", "Constipation"
        ];
        break;
      default:
        requiresGender = false;
        fields = ["Value 1", "Value 2"];
    }

    if (widget.title != "Diabetes") {
      for (var field in fields) {
        controllers[field] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    controllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  Map<String, dynamic> _formatDataForModule(String testType) {
    final values = <String, dynamic>{};

    if (testType == "Diabetes") {
      values["age"] = double.tryParse(controllers["age"]!.text) ?? 0.0;
      values["hypertension"] = hypertensionValue;
      values["heart_disease"] = heartDiseaseValue;
      values["bmi"] = double.tryParse(controllers["bmi"]!.text) ?? 0.0;
      values["HbA1c_level"] = double.tryParse(controllers["HbA1c_level"]!.text) ?? 0.0;
      values["blood_glucose_level"] = double.tryParse(controllers["blood_glucose_level"]!.text) ?? 0.0;
      values["gender_Female"] = genderFemaleValue;
      values["gender_Male"] = genderMaleValue;
      values["smoking_history_current"] = smokingCurrentValue;
      values["smoking_history_non-smoker"] = smokingNonSmokerValue;
      values["smoking_history_past_smoker"] = smokingPastSmokerValue;
    } else {
      for (var field in fields) {
        switch (field) {
          case 'Age':
          case 'BMI':
          case 'AlcoholConsumption':
          case 'PhysicalActivity':
          case 'DietQuality':
          case 'SleepQuality':
          case 'SystolicBP':
          case 'DiastolicBP':
          case 'CholesterolTotal':
          case 'CholesterolLDL':
          case 'CholesterolHDL':
          case 'CholesterolTriglycerides':
          case 'UPDRS':
          case 'MoCA':
          case 'FunctionalAssessment':
            values[field] = double.tryParse(controllers[field]!.text) ?? 0.0;
            break;

          case 'Gender':
            values[field] = genderValue;
            break;

          case 'Ethnicity':
            values[field] = ethnicityValue;
            break;

          case 'EducationLevel':
            values[field] = educationLevelValue;
            break;

          case 'Smoking':
            values[field] = smokingValue;
            break;

          case 'GeneticRisk':
            values[field] = geneticRiskValue;
            break;

          case 'FamilyHistoryParkinsons':
            values[field] = familyHistoryParkinsonsValue;
            break;

          case 'TraumaticBrainInjury':
            values[field] = traumaticBrainInjuryValue;
            break;

          case 'Hypertension':
            values[field] = hypertensionValue;
            break;

          case 'Diabetes':
            values[field] = diabetesValue;
            break;

          case 'Depression':
            values[field] = depressionValue;
            break;

          case 'Stroke':
            values[field] = strokeValue;
            break;

          case 'Tremor':
            values[field] = tremorValue;
            break;

          case 'Rigidity':
            values[field] = rigidityValue;
            break;

          case 'Bradykinesia':
            values[field] = bradykinesiaValue;
            break;

          case 'PosturalInstability':
            values[field] = posturalInstabilityValue;
            break;

          case 'SpeechProblems':
            values[field] = speechProblemsValue;
            break;

          case 'SleepDisorders':
            values[field] = sleepDisordersValue;
            break;

          case 'Constipation':
            values[field] = constipationValue;
            break;

          default:
          // All other fields (including Viral infection fields) use double parsing
            values[field] = double.tryParse(controllers[field]!.text) ?? 0.0;
            break;
        }
      }

      // Special handling for Anemia gender encoding
      if (requiresGender && testType == "Anemia") {
        values["Gender"] = genderValue == 0 ? 1 : 0;
      }
    }

    return {'data': values};
  }

  Future<void> _sendDataToBackend() async {
    setState(() => _isLoading = true);
    final data = _formatDataForModule(widget.title);

    final diagnosis = await api.sendMedicalReport(
      data.map((k, v) => MapEntry(k, v.toString())),
      widget.title,
    );

    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultsPage(
          data: {
            'testType': widget.title,
            'values': Map<String, String>.from(
              data['data'].map((k, v) => MapEntry(k, v.toString())),
            ),
            'diagnosis': diagnosis,
          },
          title: widget.title,
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
            colors: [Color(0xFFF1F8E9), Color(0xFFE8F5E9)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (widget.title == "Diabetes") ...[
                // حقل العمر
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "age",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: controllers["age"],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter age',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // حقل ارتفاع ضغط الدم
                _buildChoiceRow(
                  "hypertension",
                  ['No', 'Yes'],
                      (val) => setState(() => hypertensionValue = val),
                ),
                // حقل أمراض القلب
                _buildChoiceRow(
                  "heart_disease",
                  ['No', 'Yes'],
                      (val) => setState(() => heartDiseaseValue = val),
                ),
                // حقل BMI
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "bmi",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: controllers["bmi"],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+\.?[0-9]*'))
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter BMI',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // حقل HbA1c_level
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "HbA1c_level",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: controllers["HbA1c_level"],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+\.?[0-9]*'))
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter HbA1c level',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // حقل blood_glucose_level
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "blood_glucose_level",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: controllers["blood_glucose_level"],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+\.?[0-9]*'))
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter blood glucose level',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // حقل النوع
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          ChoiceChip(
                            label: const Text('Male'),
                            selected: genderMaleValue == 1,
                            onSelected: (_) {
                              setState(() {
                                genderMaleValue = 1;
                                genderFemaleValue = 0;
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          ChoiceChip(
                            label: const Text('Female'),
                            selected: genderFemaleValue == 1,
                            onSelected: (_) {
                              setState(() {
                                genderFemaleValue = 1;
                                genderMaleValue = 0;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // حقل تاريخ التدخين
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Smoking History",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('Current Smoker'),
                            selected: smokingCurrentValue == 1,
                            onSelected: (_) {
                              setState(() {
                                smokingCurrentValue = 1;
                                smokingNonSmokerValue = 0;
                                smokingPastSmokerValue = 0;
                              });
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Non-Smoker'),
                            selected: smokingNonSmokerValue == 1,
                            onSelected: (_) {
                              setState(() {
                                smokingNonSmokerValue = 1;
                                smokingCurrentValue = 0;
                                smokingPastSmokerValue = 0;
                              });
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Past Smoker'),
                            selected: smokingPastSmokerValue == 1,
                            onSelected: (_) {
                              setState(() {
                                smokingPastSmokerValue = 1;
                                smokingCurrentValue = 0;
                                smokingNonSmokerValue = 0;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // الكود الحالي للامراض الأخرى
                if (requiresGender)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text('Male'),
                        selected: genderValue == 0,
                        onSelected: (_) => setState(() => genderValue = 0),
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Female'),
                        selected: genderValue == 1,
                        onSelected: (_) => setState(() => genderValue = 1),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: fields.map((field) {
                      // Skip Gender field for Liver Disease & Anemia UI
                      if (field == 'Gender' &&
                          (widget.title == 'Liver Disease' ||
                              widget.title == 'Anemia')) {
                        return const SizedBox.shrink();
                      }

                      // Binary fields list
                      const binaryFields = [
                        'Smoking','FamilyHistoryParkinsons','TraumaticBrainInjury',
                        'Hypertension','Diabetes','Depression','Stroke','Tremor',
                        'Rigidity','Bradykinesia','PosturalInstability','SpeechProblems',
                        'SleepDisorders','Constipation'
                      ];

                      if (binaryFields.contains(field)) {
                        return _buildChoiceRow(
                          field,
                          ['No','Yes'],
                              (val) {
                            setState(() {
                              switch (field) {
                                case 'Smoking': smokingValue = val; break;
                                case 'Hypertension': hypertensionValue = val; break;
                                case 'Diabetes': diabetesValue = val; break;
                                case 'FamilyHistoryParkinsons': familyHistoryParkinsonsValue = val; break;
                                case 'TraumaticBrainInjury': traumaticBrainInjuryValue = val; break;
                                case 'Depression': depressionValue = val; break;
                                case 'Stroke': strokeValue = val; break;
                                case 'Tremor': tremorValue = val; break;
                                case 'Rigidity': rigidityValue = val; break;
                                case 'Bradykinesia': bradykinesiaValue = val; break;
                                case 'PosturalInstability': posturalInstabilityValue = val; break;
                                case 'SpeechProblems': speechProblemsValue = val; break;
                                case 'SleepDisorders': sleepDisordersValue = val; break;
                                case 'Constipation': constipationValue = val; break;
                              }
                            });
                          },
                        );
                      }

                      if (field == 'Ethnicity') {
                        return _buildChoiceRow(
                            field,
                            ['Caucasian','African American','Asian','Other'],
                                (val) => setState(() => ethnicityValue = val)
                        );
                      }

                      if (field == 'EducationLevel') {
                        return _buildChoiceRow(
                            field,
                            ['None','High School',"Bachelor's",'Higher'],
                                (val) => setState(() => educationLevelValue = val)
                        );
                      }

                      // Range fields
                      String hint = 'Enter value';
                      switch (field) {
                        case 'Age': hint = 'Range: 50 to 90 years'; break;
                        case 'BMI': hint = 'Range: 15 to 40'; break;
                        case 'AlcoholConsumption': hint = 'Range: 0 to 20 units/week'; break;
                        case 'PhysicalActivity': hint = 'Range: 0 to 10 hours/week'; break;
                        case 'DietQuality': hint = 'Range: 0 to 10'; break;
                        case 'SleepQuality': hint = 'Range: 4 to 10'; break;
                        case 'SystolicBP': hint = 'Range: 90 to 180 mmHg'; break;
                        case 'DiastolicBP': hint = 'Range: 60 to 120 mmHg'; break;
                        case 'CholesterolTotal': hint = 'Range: 150 to 300 mg/dL'; break;
                        case 'CholesterolLDL': hint = 'Range: 50 to 200 mg/dL'; break;
                        case 'CholesterolHDL': hint = 'Range: 20 to 100 mg/dL'; break;
                        case 'CholesterolTriglycerides': hint = 'Range: 50 to 400 mg/dL'; break;
                        case 'UPDRS': hint = 'Range: 0 to 199'; break;
                        case 'MoCA': hint = 'Range: 0 to 30'; break;
                        case 'FunctionalAssessment': hint = 'Range: 0 to 10'; break;
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                    field,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                                )
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: controllers[field],
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+\.?[0-9]*'))
                                ],
                                decoration: InputDecoration(
                                    hintText: hint,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
              if (widget.title != "Diabetes") const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _sendDataToBackend,
                icon: _isLoading
                    ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                )
                    : const Icon(Icons.send),
                label: Text(_isLoading ? 'Sending...' : 'Send'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceRow(String title, List<String> options, Function(int) onSelect) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Row(
            children: List.generate(options.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(options[i]),
                  selected: () {
                    if (title == 'Smoking') return smokingValue == i;
                    if (title == 'Hypertension') return hypertensionValue == i;
                    if (title == 'Diabetes') return diabetesValue == i;
                    if (title == 'FamilyHistoryParkinsons') return familyHistoryParkinsonsValue == i;
                    if (title == 'TraumaticBrainInjury') return traumaticBrainInjuryValue == i;
                    if (title == 'Depression') return depressionValue == i;
                    if (title == 'Stroke') return strokeValue == i;
                    if (title == 'Tremor') return tremorValue == i;
                    if (title == 'Rigidity') return rigidityValue == i;
                    if (title == 'Bradykinesia') return bradykinesiaValue == i;
                    if (title == 'PosturalInstability') return posturalInstabilityValue == i;
                    if (title == 'SpeechProblems') return speechProblemsValue == i;
                    if (title == 'SleepDisorders') return sleepDisordersValue == i;
                    if (title == 'Constipation') return constipationValue == i;
                    if (title == 'Ethnicity') return ethnicityValue == i;
                    if (title == 'EducationLevel') return educationLevelValue == i;
                    // أضف الحالات الجديدة هنا
                    if (title == 'hypertension') return hypertensionValue == i;
                    if (title == 'heart_disease') return heartDiseaseValue == i;
                    return false;
                  }(),
                  onSelected: (_) => onSelect(i),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}