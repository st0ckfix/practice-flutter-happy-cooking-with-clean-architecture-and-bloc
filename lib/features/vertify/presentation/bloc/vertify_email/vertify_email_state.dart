part of 'vertify_email_bloc.dart';

abstract class VertifyEmailState extends Equatable {
  final String? dataIfNeeded;
  final String? failedReason;
  const VertifyEmailState({this.dataIfNeeded, this.failedReason});

  @override
  List<Object> get props => [dataIfNeeded!, failedReason!];
}

final class VertifyEmailInitial extends VertifyEmailState {
  const VertifyEmailInitial();
}

final class VertifyEmailLoading extends VertifyEmailState {
  const VertifyEmailLoading();
}

final class VertifyEmailSuccessful extends VertifyEmailState {
  const VertifyEmailSuccessful(String dataIfNeeded) : super(dataIfNeeded: dataIfNeeded);
}

final class VertifyEmailFailed extends VertifyEmailState {
  const VertifyEmailFailed(String failedReason) : super(failedReason: failedReason);
}