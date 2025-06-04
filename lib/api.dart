import 'package:dio/dio.dart';

class Api {
  final Dio dio;
  final String apiKey;

  Api({required this.dio, required this.apiKey});

  final Map<String, String> medicalEndpoints = {
    "Diabetes": "https://your-api.com/diabetes",
    "Liver Disease": "https://your-api.com/liver",
    "Anemia": "https://your-api.com/anemia",
    "Viral infection": "https://your-api.com/viral",
    "Parkinsons": "https://your-api.com/parkinsons",
  };

  final Map<String, String> xrayEndpoints = {
    "Pneumonia": "https://your-api.com/xray/pneumonia",
    "Covid-19": "https://covid-19-tc9m.onrender.com/predict",
    "Tuberculosis": "https://your-api.com/xray/tb",
  };

  Future<String> sendMedicalReport(Map<String, String> data, String testType) async {
    final url = medicalEndpoints[testType];
    if (url == null) return "Unsupported test type";

    try {
      final response = await dio.post(
        url,
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

  Future<String> predictXray(String imagePath, String type) async {
    final url = xrayEndpoints[type];
    if (url == null) return "Unsupported X-ray type";

    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath, filename: 'xray.jpg'),
      });

      final response = await dio.post(
        url,
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
      return "Error occurred";
    }
  }
}
