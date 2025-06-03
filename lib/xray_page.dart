// xray_page.dart
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'api.dart';
import 'results_page.dart';

class XRayPage extends StatefulWidget {
  final String title;
  const XRayPage({Key? key, required this.title}) : super(key: key);

  @override
  State<XRayPage> createState() => _XRayPageState();
}

class _XRayPageState extends State<XRayPage> {
  final Api api = Api(dio: Dio(), apiKey: ""); // حط مفتاحك هنا
  XFile? _selectedImage;
  String _diagnosis = "";

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
        _diagnosis = "";
      });
    }
  }

  Future<void> _sendXray() async {
    if (_selectedImage == null) return;
    String diagnosis = await api.predictXray(_selectedImage!.path);
    setState(() {
      _diagnosis = diagnosis;
    });
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            data: {
              "testType": widget.title,
              "diagnosis": diagnosis,
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("اختيار صورة أشعة"),
            ),
            const SizedBox(height: 20),
            if (_selectedImage != null)
              Image.file(
                File(_selectedImage!.path),
                height: 250,
                fit: BoxFit.contain,
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _sendXray,
              icon: const Icon(Icons.send),
              label: const Text("إرسال صورة الأشعة"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}