import 'package:accident_detection_app/screens/dashboard/home/navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/welcome.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(flex: 3),
              const Text(
                'Welcome to Safety',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow( // Adds a shadow to the text
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  )],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              const Text(
                'Get help when you need it most.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  shadows: [Shadow( // Adds a shadow to the text
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  )],
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'We\'ll keep your personal data private and secure. '
                    'Our staff will only access it in case of an emergency.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [Shadow( // Adds a shadow to the text
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  )],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyHomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Get started',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),

              const Text(
                'already have account?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [Shadow( // Adds a shadow to the text
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  )],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
            ],
          ),
        ],
      ),
    );
  }
}
