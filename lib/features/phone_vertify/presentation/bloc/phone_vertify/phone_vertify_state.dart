part of 'phone_vertify_bloc.dart';

abstract class PhoneVertifyState extends Equatable {
  final String? dateIfNeded;
  final String? failedReason;
  final PhoneAuthCredential? phoneAuthCredential;
  final DioException? dioException;
  const PhoneVertifyState({this.dateIfNeded, this.failedReason, this.dioException, this.phoneAuthCredential});

  @override
  List<Object> get props => [dateIfNeded!, failedReason!, dioException!];
}

final class PhoneVertifyInitial extends PhoneVertifyState {
  const PhoneVertifyInitial();
}

final class PhoneVertifyLoading extends PhoneVertifyState {
  const PhoneVertifyLoading();
}

final class PhoneVertifyRequestDone extends PhoneVertifyState {
  const PhoneVertifyRequestDone();
}

final class PhoneVertifySMSAutoComplete extends PhoneVertifyState {
  const PhoneVertifySMSAutoComplete(PhoneAuthCredential phoneAuthCredential) : super(phoneAuthCredential: phoneAuthCredential);
}

final class PhoneVertifySMSSent extends PhoneVertifyState {
  const PhoneVertifySMSSent(String verificationId) : super(dateIfNeded: verificationId);
}

final class PhoneVertifyTimeout extends PhoneVertifyState {
  const PhoneVertifyTimeout(String verificationId) : super(dateIfNeded: verificationId);
}

final class PhoneVertifyFailed extends PhoneVertifyState {
  const PhoneVertifyFailed(String failedReason) : super(failedReason: failedReason);
}

final class PhoneVertifyException extends PhoneVertifyState {
  const PhoneVertifyException(DioException exception) : super(dioException: exception);
}
