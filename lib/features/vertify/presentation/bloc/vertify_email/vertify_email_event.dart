part of 'vertify_email_bloc.dart';

final class VertifyEmailEvent extends Equatable {
  final String email;
  const VertifyEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}
