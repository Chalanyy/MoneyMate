import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'SignupScreen.dart'; // Import the SignupScreen

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromARGB(255, 153, 148, 255), Color.fromARGB(255, 106, 255, 255)],
              ),
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animated Logo
                // App Name with animation
                FadeInDown(
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 1.0), // Adjust position of MoneyMate
                    child: Text(
                      'MoneyMate',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Illustration with animation
                FadeInDown(
                  duration: Duration(seconds: 1),
                  child: Image.asset(
                    'assets/mylogo.png', // Replace with your image
                    height: 250,
                  ),
                ),
                SizedBox(height: 30),

                // Welcome text with animation
                FadeInUp(
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1.0), // Adjust position of Welcome text
                    child: Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                FadeInUp(
                  duration: Duration(seconds: 1),
                  child: Text(
                    'MoneyMate helps you manage your expenses',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ),
                SizedBox(height: 40),

                // Loading animation (progress indicator)
                FadeInUp(
                  duration: Duration(seconds: 1),
                  child: CircularProgressIndicator(
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 40),

                // Sign Up Button with animation
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 245, 245, 246),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),

                SizedBox(height: 15), // Space between buttons

                // "Already have an account? Then login" text
                FadeInUp(
                  duration: Duration(seconds: 1),
                  child: Text(
                    "Already have an account? login",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
