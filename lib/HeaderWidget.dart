import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Circle image
        ClipOval(
          child: Image.asset(
            'assets/mylogo.png', // Ensure the image is in the assets folder
            height: 80,
            width: 70,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10),
        // Text next to the image with slow animation
        Expanded(
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ColorizeAnimatedText(
                'MoneyMate', // Change the text here
                textStyle: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                colors: [
                  Color.fromARGB(255, 18, 77, 77),
Color.fromARGB(255, 0, 0, 0),
Color.fromARGB(255, 2, 1, 0),
Color.fromARGB(255, 19, 64, 64)
                  
                  
                  
                ],
                speed: Duration(seconds: 1), // Adjust the speed here
              ),
            ],
          ),
        ),
      ],
    );
  }
}
