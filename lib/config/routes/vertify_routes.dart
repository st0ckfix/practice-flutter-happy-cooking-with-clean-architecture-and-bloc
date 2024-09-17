import 'package:get/get.dart';

import '../../features/phone_vertify/presentation/pages/code_verify_screen.dart';
import '../../features/phone_vertify/presentation/pages/vertify_page.dart';
import '../../features/phone_vertify/presentation/pages/vertify_screen.dart';
import 'full_routes.dart';

class VertifyRoutes {
  static const String page = 'vertify-page';
  static const String vertify = '/vertify-route';
  static const String smsVertify = '/sms-vertify-route';

  final routes = [
    createPage('/phone-route', () => const VertifyPage()),
    createPage(
      '/vertify-route',
      () => VertifyScreen(
        email: Get.arguments['email'],
        fieldValidator: Get.arguments['fieldValidator'],
      ),
      transition: Transition.rightToLeft,
    ),
    createPage(
      '/sms-vertify-route',
      () => PhoneVertifySMSCodeScreen(
        agrument: Get.arguments['agrument'],
        resendSMS: Get.arguments['resendSMS'],
      ),
      transition: Transition.fadeIn,
    ),
  ];
}
