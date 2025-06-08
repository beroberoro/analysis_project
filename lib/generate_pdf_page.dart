import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

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

class Question {
  final String question;
  final List<String> options;
  final bool multiSelect;
  List<String> selectedAnswers = [];

  Question({
    required this.question,
    required this.options,
    this.multiSelect = false,
  });
}

class _GeneratePdfPageState extends State<GeneratePdfPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  // Controllers for follow-up fields
  final TextEditingController glucoseController = TextEditingController();
  final TextEditingController medicationController = TextEditingController();

  String gender = 'ذكر';

  final Map<String, List<Question>> questionsMap = {
    'Diabetes': [
      // فقرة 3: أعراض حالية (اختيار متعدد)
      Question(
        question: 'اختر من الأعراض (يمكن اختيار أكثر من عرض):',
        options: [
          'عطش زائد (Polydipsia)',
          'جوع زائد (Polyphagia)',
          'تبول متكرر (Polyuria)',
          'تعب/إرهاق غير مبرر',
          'فقدان الوزن غير مفسَّر',
          'خدر أو تنميل في الأطراف (قدمين/يدين)',
        ],
        multiSelect: true,
      ),
      // فقرة 4: استبيان بنعم/لا خاص بالسكري
      Question(
        question: 'هل قمت بقياس السكر بالمنزل (Glucometer) اليوم؟',
        options: ['نعم', 'لا'],
      ),
      Question(
        question: 'هل تتناول الأنسولين أو أدوية فموية (مثل: ميتفورمين، جليمبريد)؟',
        options: ['نعم', 'لا'],
      ),
      Question(
        question: 'هل تعاني من تشققات أو تقرحات في القدمين؟',
        options: ['نعم', 'لا'],
      ),
      Question(
        question: 'هل تشعر بضعف في النظر أو رؤية ضبابية؟',
        options: ['نعم', 'لا'],
      ),
    ],
    // بقية الفحوصات دون تغيير
    'Viral infection': [
      Question(question: 'هل تعاني من سعال مستمر؟', options: ['نعم', 'لا']),
      Question(question: 'هل تعاني من ضيق في التنفس؟', options: ['نعم', 'لا']),
      Question(question: 'ما الأعراض المصاحبة؟', options: ['حمى', 'ألم في الصدر', 'إرهاق'], multiSelect: true),
      Question(question: 'هل تعرضت لأي عدوى سابقة في الجهاز التنفسي؟', options: ['نعم', 'لا']),
    ],
    'Parkinsons': [
      Question(question: 'هل تعاني من رعشة في اليد أو القدم؟', options: ['نعم', 'لا']),
      Question(question: 'هل تواجه صعوبة في المشي أو التوازن؟', options: ['نعم', 'لا']),
      Question(question: 'هل تعاني من تصلب العضلات؟', options: ['نعم', 'لا']),
      Question(question: 'هل تشعر بتباطؤ في الحركات؟', options: ['نعم', 'لا']),
    ],
    'Liver Disease': [
      Question(question: 'هل تعاني من ألم في الجانب الأيمن من البطن؟', options: ['نعم', 'لا']),
      Question(question: 'هل لديك اصفرار في الجلد أو العين؟', options: ['نعم', 'لا']),
      Question(question: 'هل تشعر بتعب مزمن أو فقدان الشهية؟', options: ['نعم', 'لا']),
      Question(question: 'هل تعاني من تورم في البطن أو الأرجل؟', options: ['نعم', 'لا']),
    ],
    'Tuberculosis': [
      Question(question: 'هل تعاني من سعال مستمر لأكثر من 3 أسابيع؟', options: ['نعم', 'لا']),
      Question(question: 'هل تعاني من فقدان وزن غير مبرر؟', options: ['نعم', 'لا']),
      Question(question: 'هل تعاني من تعرق ليلي؟', options: ['نعم', 'لا']),
      Question(question: 'هل لديك تاريخ تعرض مباشر لشخص مصاب بالسل؟', options: ['نعم', 'لا']),
    ],
  };

  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    questions = questionsMap[widget.testType] ?? [];
  }

  void generatePdf() async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/Fonts/Cairo-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    final arabicStyle = pw.TextStyle(font: ttf, fontSize: 14);
    final boldStyle = pw.TextStyle(font: ttf, fontSize: 14, fontWeight: pw.FontWeight.bold);

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text('تقرير الفحص الطبي', style: pw.TextStyle(font: ttf, fontSize: 22, fontWeight: pw.FontWeight.bold)),
                ),
                pw.SizedBox(height: 24),
                pw.Text('بيانات المريض:', style: boldStyle),
                pw.SizedBox(height: 8),
                pw.Text('الاسم: ${nameController.text}', style: arabicStyle),
                pw.Text('العمر: ${ageController.text}', style: arabicStyle),
                pw.Text('الجنس: $gender', style: arabicStyle),
                pw.Text('نوع الفحص: ${_translate(widget.testType)}', style: arabicStyle),
                pw.SizedBox(height: 20),
                pw.Text('النتائج الطبية:', style: boldStyle),
                pw.SizedBox(height: 8),
                ...widget.values.entries.map((entry) => pw.Text('${_translate(entry.key)}: ${entry.value}', style: arabicStyle)),
                pw.SizedBox(height: 20),
                pw.Text('التشخيص النهائي:', style: boldStyle),
                pw.Text(widget.diagnosis.isNotEmpty ? widget.diagnosis : 'لا يوجد تشخيص مسجّل.', style: arabicStyle),
                pw.SizedBox(height: 20),
                pw.Text('الإجابات على الأسئلة التشخيصية:', style: boldStyle),
                pw.SizedBox(height: 8),
                ...questions.map((q) {
                  String ans = q.selectedAnswers.isEmpty ? 'لم يتم الإجابة' : q.selectedAnswers.join(', ');
                  // إضافة قيمة المتابعة إلى النص
                  if (q.question.contains('Glucometer') && glucoseController.text.isNotEmpty) {
                    ans += ' (قيمة الصائم: ${glucoseController.text})';
                  }
                  if (q.question.contains('أدوية فموية') && medicationController.text.isNotEmpty) {
                    ans += ' (${medicationController.text})';
                  }
                  return pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 8),
                    child: pw.Text('${q.question}: $ans', style: arabicStyle),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  String _translate(String key) {
    const translations = {
      'Diabetes': 'السكري',
      'Viral infection': 'عدوى فيروسية',
      'Parkinsons': 'باركنسون',
      'Liver Disease': 'مرض الكبد',
      'Tuberculosis': 'السل',
      'Glucose': 'الجلوكوز',
      'Blood Pressure': 'ضغط الدم',
      'Heart Rate': 'معدل ضربات القلب',
      'Temperature': 'درجة الحرارة',
    };
    return translations[key] ?? key;
  }

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
                      onTap: () => setState(() => gender = 'ذكر'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: gender == 'ذكر' ? Colors.blue[100] : Colors.white,
                          border: Border.all(color: gender == 'ذكر' ? Colors.blue : Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("ذكر")),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => gender = 'أنثى'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: gender == 'أنثى' ? Colors.pink[100] : Colors.white,
                          border: Border.all(color: gender == 'أنثى' ? Colors.pink : Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("أنثى")),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              if (questions.isEmpty)
                const Text('لا توجد أسئلة لهذا التحليل.', style: TextStyle(fontSize: 16, color: Colors.red))
              else ...[
                const Text("الأسئلة:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...questions.map((q) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(q.question, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      ...q.options.map((option) {
                        final isSelected = q.selectedAnswers.contains(option);
                        return CheckboxListTile(
                          title: Text(option),
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (q.multiSelect) {
                                if (value == true) {
                                  q.selectedAnswers.add(option);
                                } else {
                                  q.selectedAnswers.remove(option);
                                }
                              } else {
                                q.selectedAnswers = [option];
                              }
                            });
                          },
                        );
                      }).toList(),
                      // حقل متابعة لقيمة السكر
                      if (q.question == 'هل قمت بقياس السكر بالمنزل (Glucometer) اليوم؟' && q.selectedAnswers.contains('نعم'))
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: TextField(
                            controller: glucoseController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'ما قيمة سكر الصائم؟',
                            ),
                          ),
                        ),
                      // حقل متابعة لاسم وجرعة الدواء
                      if (q.question == 'هل تتناول الأنسولين أو أدوية فموية (مثل: ميتفورمين، جليمبريد)؟' && q.selectedAnswers.contains('نعم'))
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: TextField(
                            controller: medicationController,
                            decoration: const InputDecoration(
                              labelText: 'اذكر اسم الدواء والجرعة والعدد اليومي',
                            ),
                          ),
                        ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ],
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text("إنشاء PDF"),
                  onPressed: () {
                    if (nameController.text.isEmpty || ageController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("يرجى إدخال الاسم والعمر")),
                      );
                      return;
                    }
                    generatePdf();
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