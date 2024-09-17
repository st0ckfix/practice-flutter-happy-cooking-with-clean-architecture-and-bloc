import 'package:flutter/material.dart';
import 'package:happy_cooking/features/authentication/presentation/pages/welcome_screen.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeScreen(),
    );
  }
}
