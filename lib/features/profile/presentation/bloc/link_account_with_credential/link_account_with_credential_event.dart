part of 'link_account_with_credential_bloc.dart';

abstract class LinkAccountWithCredentialEvent extends Equatable {
  const LinkAccountWithCredentialEvent();

  @override
  List<Object> get props => [];
}

final class LinkEmailEvent extends LinkAccountWithCredentialEvent {
  final String email;
  final String password;
  const LinkEmailEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

final class LinkGoogleEvent extends LinkAccountWithCredentialEvent {
  const LinkGoogleEvent();
}

final class LinkPhoneEvent extends LinkAccountWithCredentialEvent {
  final PhoneAuthCredential phoneAuthCredential;
  const LinkPhoneEvent(this.phoneAuthCredential);

  @override
  List<Object> get props => [phoneAuthCredential];
}
