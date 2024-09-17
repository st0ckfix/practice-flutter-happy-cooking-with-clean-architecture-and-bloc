part of 'sms_vertify_bloc.dart';

abstract class PhoneVertifySMSCodeState extends Equatable {
  final String? failedReason;
  final DioException? dioException;
  const PhoneVertifySMSCodeState({this.failedReason, this.dioException});

  @override
  List<Object> get props => [failedReason!, dioException!];
}

final class PhoneVertifySMSCodeInitial extends PhoneVertifySMSCodeState {
  const PhoneVertifySMSCodeInitial();
}

final class PhoneVertifySMSCodeLoading extends PhoneVertifySMSCodeState {
  const PhoneVertifySMSCodeLoading();
}

final class PhoneVertifySMSCodeSuccessful extends PhoneVertifySMSCodeState {
  const PhoneVertifySMSCodeSuccessful() : super();
}

final class PhoneVertifySMSCodeFailed extends PhoneVertifySMSCodeState {
  const PhoneVertifySMSCodeFailed(String failedReason) : super(failedReason: failedReason);
}