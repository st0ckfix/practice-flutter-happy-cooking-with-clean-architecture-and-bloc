part of 'sms_vertify_bloc.dart';

final class PhoneVertifySMSCodeEvent extends Equatable {
  final PhoneAuthCredential? phoneAuthCredential;
  final String? verificationId;
  final String? smsCode;
  const PhoneVertifySMSCodeEvent({this.phoneAuthCredential, this.verificationId, this.smsCode});

  @override
  List<Object> get props => [phoneAuthCredential! , verificationId! , smsCode!];
}
