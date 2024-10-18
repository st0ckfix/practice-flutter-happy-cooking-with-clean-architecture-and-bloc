import 'package:get/get.dart';

import '../../features/vertify/presentation/pages/code_verify_screen.dart';
import '../../features/vertify/presentation/pages/vertify_page.dart';
import '../../features/vertify/presentation/pages/vertify_screen.dart';
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
        form: Get.arguments['form'],
        email: Get.arguments['email'],
        callbackEmail: Get.arguments['callbackEmail'],
        callbackPhone: Get.arguments['callbackPhone'],
        fieldValidator: Get.arguments['fieldValidator'],   
      ),
      duration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    createPage(
      '/sms-vertify-route',
      () => PhoneVertifySMSCodeScreen(
        callbackEmail: Get.arguments['callbackEmail'],
        callbackPhone: Get.arguments['callbackPhone'],
        agrument: Get.arguments['agrument'],
        emailCode: Get.arguments['emailCode'],
      ),
      transition: Transition.fadeIn,
    ),
  ];
}
