import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'CategoryScreen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _signup() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String phone = _phoneController.text.trim();

    // Email validation (must be Gmail)
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(email)) {
      _showErrorDialog('Please enter a valid Gmail address.');
      return;
    }

    // Password match validation
    if (password != confirmPassword) {
      _showErrorDialog('Passwords do not match.');
      return;
    }

    // Phone validation (10-digit number)
    if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
      _showErrorDialog('Please enter a valid 10-digit phone number.');
      return;
    }

    // If everything is correct, navigate to CategoryScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreen()),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          FocusScope.of(context).unfocus(), // Close keyboard on tap outside
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 106, 255, 255) ,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: child,
                        );
                      },
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'MoneyMate',
                            textStyle: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            colors: [
                              Color.fromARGB(255, 153, 148, 255),
                              Color.fromARGB(255, 153, 148, 255),
                              Color.fromARGB(255, 249, 94, 34),
                              const Color.fromARGB(255, 255, 150, 3)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      _buildTextField(_emailController, 'Email', Icons.email),
                      SizedBox(height: 16),
                      _buildTextField(_passwordController, 'Password', Icons.lock,
                          obscureText: true),
                      SizedBox(height: 16),
                      _buildTextField(_confirmPasswordController,
                          'Confirm Password', Icons.lock,
                          obscureText: true),
                      SizedBox(height: 16),
                      _buildTextField(_phoneController, 'Phone', Icons.phone),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _signup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 176, 247, 247),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                        ),
                        child: Text('Done',
                            style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 1, 0, 0))),
                      ),      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black54),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: obscureText,
      keyboardType: label == 'Phone' ? TextInputType.phone : TextInputType.text,
    );
  }
}
