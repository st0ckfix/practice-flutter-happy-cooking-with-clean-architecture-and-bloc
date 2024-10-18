part of 'vertify_phone_bloc.dart';

abstract class VertifyPhoneState extends Equatable {
  final String? dateIfNeded;
  final String? failedReason;
  final PhoneAuthCredential? phoneAuthCredential;
  final DioException? dioException;
  const VertifyPhoneState({this.dateIfNeded, this.failedReason, this.dioException, this.phoneAuthCredential});

  @override
  List<Object> get props => [dateIfNeded!, failedReason!, dioException!];
}

final class VertifyPhoneInitial extends VertifyPhoneState {
  const VertifyPhoneInitial();
}

final class VertifyPhoneLoading extends VertifyPhoneState {
  const VertifyPhoneLoading();
}

final class VertifyPhoneRequestAccepted extends VertifyPhoneState {
  const VertifyPhoneRequestAccepted();
}

final class VertifyPhoneAutoVerification extends VertifyPhoneState {
  const VertifyPhoneAutoVerification(PhoneAuthCredential phoneAuthCredential) : super(phoneAuthCredential: phoneAuthCredential);
}

final class VertifyPhoneCodeSent extends VertifyPhoneState {
  const VertifyPhoneCodeSent(String verificationId) : super(dateIfNeded: verificationId);
}

final class VertifyPhoneTimeout extends VertifyPhoneState {
  const VertifyPhoneTimeout();
}

final class VertifyPhoneFailed extends VertifyPhoneState {
  const VertifyPhoneFailed(String failedReason) : super(failedReason: failedReason);
}

final class VertifyPhoneException extends VertifyPhoneState {
  const VertifyPhoneException(DioException exception) : super(dioException: exception);
}
