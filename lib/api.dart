//api_page.dart
import 'package:dio/dio.dart';

class Api {
  final Dio dio;
  final String apiKey;

  Api({required this.dio, required this.apiKey});

  Future<String> sendMedicalReport(Map<String, String> data, String testType) async {
    try {
      final response = await dio.post(
        'https://your-api-url.com/predict', // غيّر هذا بالرابط الصحيح
        data: {
          'testType': testType,
          'data': data,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.data['diagnosis'] ?? "No diagnosis received";
    } catch (e) {
      print("Error sending medical report: $e");
      return "Error occurred";
    }
  }

  Future<String> predictXray(String imagePath) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath, filename: 'xray.jpg'),
      });

      final response = await dio.post(
        'https://your-api-url.com/xray', // غيّر هذا بالرابط الصحيح الخاص بالأشعة
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );

      return response.data['diagnosis'] ?? "No diagnosis received";
    } catch (e) {
      print("Error predicting X-ray: $e");
      return "Error occurred ";
    }
  }
}
