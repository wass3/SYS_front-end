// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:sys_project/providers/user_data.dart';
import 'package:sys_project/screens/home_page.dart';
import 'package:sys_project/screens/register.dart';
import 'package:sys_project/service/user_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

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
                      'Login',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xffddeee5),
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField('Username', false, _usernameController),
                    const SizedBox(height: 8),
                    _buildTextField('Password', true, _passwordController),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final username = _usernameController.text;
                        final password = _passwordController.text;
                        if (await _isValidCredentials(username, password)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid credentials')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff97e2ba),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xff050d09),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: const Text(
                        'Don\'t have an account? Sign in',
                        style: TextStyle(color: Color(0xffffffff)),
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

  Widget _buildTextField(String labelText, bool isPasswordField, TextEditingController controller) {
    return TextField(
      obscureText: isPasswordField ? !_isPasswordVisible : false,
      controller: controller,
      style: TextStyle(color: Color(0xffffffff)), // Establecer el color del texto a blanco
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xffddeee5)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff35e789), width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff333534), width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        suffixIcon: isPasswordField
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xffddeee5),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }

  Future<bool> _isValidCredentials(String username, String password) async {
    try {
      final user = await UserService.login(username, password);
      print('Login successful: $user');
      if (user != null) {
        print('llega ${user['userData']['token']}');
        await UserPreferences.saveUser(
          token: user['userData']['token'],
          userId: user['userData']['user_id'],
          userHandler: user['userData']['user_handler'],
          name: user['userData']['name'],
          surname: user['userData']['surname'],
          biography: user['userData']['biography'],
          emailAddress: user['userData']['email_address'],
          userImg: user['userData']['user_img'],
        );
        print('guarda y devuelve true');
        return true; // Devuelve true si el usuario es válido
      } else {
        return false; // Devuelve false si el usuario no es válido
      }
    } catch (e) {
      print('Login failed: $e');
      return false;
    }
  }
}
