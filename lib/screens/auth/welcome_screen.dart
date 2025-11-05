import 'package:ecoquest/widgets/background_painter.dart';
import 'package:flutter/material.dart';
import 'package:ecoquest/screens/auth/login_screen.dart';
import 'package:ecoquest/screens/auth/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: BackgroundPainter(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(flex: 2),
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: 190,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'EcoQuest',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle:
                          Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF78C800), // duolingo green
                                fontSize: 48,
                              ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '“Learn, recycle, and level up for the planet.”',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey.shade600, height: 1.5),
                  ),
                  const Spacer(flex: 3),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF58CC02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF58CC02),
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'I ALREADY HAVE AN ACCOUNT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
