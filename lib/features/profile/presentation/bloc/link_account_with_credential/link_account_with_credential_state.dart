part of 'link_account_with_credential_bloc.dart';

abstract class LinkAccountWithCredentialState extends Equatable {
  final String? failedReason;
  const LinkAccountWithCredentialState({this.failedReason});

  @override
  List<Object?> get props => [failedReason];
}

final class LinkAccountWithCredentialInitial extends LinkAccountWithCredentialState {
  const LinkAccountWithCredentialInitial();
}

final class LinkAccountWithCredentialLoading extends LinkAccountWithCredentialState {
  const LinkAccountWithCredentialLoading();
}

final class LinkAccountWithCredentialSuccessful extends LinkAccountWithCredentialState {
  const LinkAccountWithCredentialSuccessful() : super();
}

final class LinkAccountWithCredentialFailed extends LinkAccountWithCredentialState {
  const LinkAccountWithCredentialFailed(String? failedReason) : super(failedReason: failedReason);
}