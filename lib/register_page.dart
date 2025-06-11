import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {

    try {
      var dio = Dio();
      var response = await dio.post(
        'https://kemetgamesg.com/medical_test/register.php',
        data: {
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print(response.data['message']);
      if(response.data['message']=="User registered successfully"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top image with rotation
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

          // Bottom image
          Positioned(
            bottom: -100,
            right: -100,
            child: Image.asset(
              'assets/image/login_image.jpeg',
              width: 250,
              height: 250,
            ),
          ),

          // Main content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D3FD3),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create a new account",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),

                  // Username
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Register Button
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D3FD3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        registerUser(context);
                      },
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Go back to Login
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      "Already have an account? Login Now",
                      style: TextStyle(
                        color: Color(0xFF5D3FD3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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