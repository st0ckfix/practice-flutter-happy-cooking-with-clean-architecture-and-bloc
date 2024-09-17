part of 'phone_vertify_bloc.dart';

final class PhoneVertifyEvent extends Equatable {
  final String phoneNumber;
  const PhoneVertifyEvent(this.phoneNumber);
  @override
  List<Object> get props => [phoneNumber];
}
