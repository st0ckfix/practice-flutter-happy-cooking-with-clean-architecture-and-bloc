part of 'vertify_phone_bloc.dart';

final class VertifyPhoneEvent extends Equatable {
  final String phoneNumber;
  const VertifyPhoneEvent(this.phoneNumber);
  @override
  List<Object> get props => [phoneNumber];
}
