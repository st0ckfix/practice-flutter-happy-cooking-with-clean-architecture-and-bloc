import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../../../core/constants/api_key.dart';
import '../../../../core/error/firebase_auth_error.dart';

class VertifyEmailFirebase {
  Future<Either<String, String>> emailVertify(String email) async {
    final code = Random().nextInt(899999) + 100000;
    final smtpServer = gmail(noreplyEmail, emailAppPassword);
    final message = Message()
      ..from = const Address(noreplyEmail, 'Noreply-Email Happy Cooking')
      ..recipients.add(email)
      ..subject = 'Your verification code'
      ..html = '''
      <html>
        <body>
          <p>Hello,</p>
          <p>This is a no-reply email from Happy Cooking.</p>
          <p>Your 6-digit verification code is: <strong>$code</strong></p>
          <p>Thank you!</p>
        </body>
      </html>
    ''';

    try {
      await send(message, smtpServer);
      return Right(code.toString());
    } catch (e) {
      return Left(getErrorMessage(e.toString()));
    }
  }
}
