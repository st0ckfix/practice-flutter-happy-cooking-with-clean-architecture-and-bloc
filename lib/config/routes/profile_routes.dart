import 'package:happy_cooking/features/profile/presentation/pages/profile_page.dart';
import 'full_routes.dart';

class ProfileRoutes {
  static const String profile = '/profile-route';

  final routes = [
    createPage('/phone-route', () => const ProfilePage()),
  ];
}