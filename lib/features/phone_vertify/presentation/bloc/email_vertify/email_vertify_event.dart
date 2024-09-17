part of 'email_vertify_bloc.dart';

final class EmailVertifyEvent extends Equatable {
  final String email;
  const EmailVertifyEvent(this.email);

  @override
  List<Object> get props => [email];
}
