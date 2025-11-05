import 'package:flutter/material.dart';
import 'package:ecoquest/screens/main_app_shell.dart';
import 'package:ecoquest/screens/auth/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: const Color(0xfff7f9f8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // Shield Icon
              Image.asset(
                'assets/images/app_logo.png',
                width: 160,
                height: 160,
              ),
              const SizedBox(height: 8),
              Text(
                "Create your account",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(labelText: 'Username', hintText: 'username'),
              const SizedBox(height: 16),
              _buildTextField(
                  labelText: 'Email', hintText: 'hero@ecoquest.com'),
              const SizedBox(height: 16),
              _buildTextField(
                  labelText: 'Password',
                  hintText: 'password',
                  obscureText: true),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const MainAppShell()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF58CC02),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF58CC02),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String labelText,
      required String hintText,
      bool obscureText = false}) {
    String capitalizedLabel = labelText.isNotEmpty
        ? labelText[0].toUpperCase() + labelText.substring(1).toLowerCase()
        : labelText;
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: capitalizedLabel,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color(0xFF3A3845),
        ),
        hintText: hintText.toLowerCase(),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}