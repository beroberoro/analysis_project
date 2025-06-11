import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'app_const.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';
import 'home_page.dart'; // فيها MyApp

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // متحكمات لحقول الإدخال
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> loginUser() async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'https://kemetgamesg.com/medical_test/login.php',
        data: {
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      final data = response.data;
      print(data);
      setState(() {
        if (data['message'] != null) {
          kUserId = "${data['user_id']}";
          kUserEmail = data['user_email'];
          kUserName = data['user_name'];
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp(),));
        } else {

        }
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الصورة اللي فوق
          Positioned(
            top: -100,
            left: -100,
            child: Transform.rotate(
              angle: -3,
              child: Image.asset(
                'assets/image/login_image.jpeg',
                width: 250,
                height: 250,
              ),
            ),
          ),

          // الصورة اللي تحت
          Positioned(
            bottom: -100,
            right: -100,
            child: Image.asset(
              'assets/image/login_image.jpeg',
              width: 250,
              height: 250,
            ),
          ),

          // المحتوى الأساسي
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D3FD3),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign in to Continue",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Email
                  Container(
                    width: 300,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Please enter Email",
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password
                  Container(
                    width: 300,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Please enter Password",
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Login Button
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        loginUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D3FD3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 16),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xFF5D3FD3),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Links
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RegisterPage()));
                    },
                    child: const Text("Don't have an account? Register Now"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}