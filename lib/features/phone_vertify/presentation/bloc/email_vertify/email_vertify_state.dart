part of 'email_vertify_bloc.dart';

abstract class EmailVertifyState extends Equatable {
  final String? dataIfNeeded;
  final String? failedReason;
  const EmailVertifyState({this.dataIfNeeded, this.failedReason});

  @override
  List<Object> get props => [dataIfNeeded!, failedReason!];
}

final class EmailVertifyInitial extends EmailVertifyState {
  const EmailVertifyInitial();
}

final class EmailVertifyLoading extends EmailVertifyState {
  const EmailVertifyLoading();
}

final class EmailVertifySuccessful extends EmailVertifyState {
  const EmailVertifySuccessful(String dataIfNeeded) : super(dataIfNeeded: dataIfNeeded);
}

final class EmailVertifyFailed extends EmailVertifyState {
  const EmailVertifyFailed(String failedReason) : super(failedReason: failedReason);
}