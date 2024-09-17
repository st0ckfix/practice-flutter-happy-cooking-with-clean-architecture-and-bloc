import 'package:get/get.dart';
import 'package:happy_cooking/features/authentication/presentation/pages/authentication_page.dart';
import 'package:happy_cooking/features/authentication/presentation/pages/login_screen.dart';
import 'package:happy_cooking/features/authentication/presentation/pages/signup_screen.dart';
import 'package:happy_cooking/features/authentication/presentation/pages/welcome_screen.dart';

import 'full_routes.dart';


class AuthRoutes {
  static const String auth = '/auth-route';
  static const String welcome = '/welcome-route';
  static const String login = '/login-route';
  static const String signup = '/signup-route';

  final routes = [
    createPage('/auth-route', () => const AuthenticationPage()),
    createPage(
      '/welcome-route',
      () => const WelcomeScreen(),
      transition: Transition.rightToLeft,
    ),
    createPage(
      '/login-route',
      () => const LoginScreen(),
      transition: Transition.fadeIn,
    ),
    createPage(
      '/signup-route',
      () => const SignupScreen(),
      transition: Transition.downToUp,
    ),
  ];
}
