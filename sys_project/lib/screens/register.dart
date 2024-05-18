// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sys_project/screens/screens.dart';

class Register extends StatelessWidget {

  const Register({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050d09),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: const Color(0xff333534),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SizedBox(
              width: 300, // Ancho fijo para la Card
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Alinea al centro verticalmente
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Register',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xffddeee5),
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField('Username', false),
                    const SizedBox(height: 8),
                    _buildTextField('Surname', false),
                    const SizedBox(height: 8),
                    _buildTextField('Email Address', false),
                    const SizedBox(height: 8),
                    _buildTextField('Password', true),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Handle register button pressed
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff97e2ba),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Color(0xff050d09)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        'Already have an account? Log in',
                        style: TextStyle(color: const Color(0xffffffff)),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, bool obscureText) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xffddeee5)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xff35e789), width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xff333534), width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
