import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/link_account_with_email_use_case.dart';
import '../../../domain/usecases/link_account_with_google_use_case.dart';
import '../../../domain/usecases/link_account_with_phone_use_case.dart';

part 'link_account_with_credential_event.dart';
part 'link_account_with_credential_state.dart';

class LinkAccountWithCredentialBloc extends Bloc<LinkAccountWithCredentialEvent, LinkAccountWithCredentialState> {
  LinkAccountWithEmailUseCase linkAccountWithEmailUseCase;
  LinkAccountWithGoogleUseCase linkAccountWithGoogleUseCase;
  LinkAccountWithPhoneUseCase linkAccountWithPhoneUseCase;
  LinkAccountWithCredentialBloc(this.linkAccountWithEmailUseCase, this.linkAccountWithGoogleUseCase, this.linkAccountWithPhoneUseCase) : super(const LinkAccountWithCredentialInitial()) {
    on<LinkEmailEvent>((event, emit) async {
      emit(const LinkAccountWithCredentialLoading());
      final state = await linkAccountWithEmailUseCase(params: (email: event.email, password: event.password));
      state.fold(
        (error) {
          emit(LinkAccountWithCredentialFailed(error));
        },
        (_) {
          emit(const LinkAccountWithCredentialSuccessful());
        },
      );
    });
    on<LinkGoogleEvent>((event, emit) async {
      emit(const LinkAccountWithCredentialLoading());
      final state = await linkAccountWithGoogleUseCase();
      state.fold(
        (error) {
          emit(LinkAccountWithCredentialFailed(error));
        },
        (_) {
          emit(const LinkAccountWithCredentialSuccessful());
        },
      );
    });
    on<LinkPhoneEvent>((event, emit) async {
      emit(const LinkAccountWithCredentialLoading());
      final state = await linkAccountWithPhoneUseCase(params: event.phoneAuthCredential);
      state.fold(
        (error) {
          emit(LinkAccountWithCredentialFailed(error));
        },
        (_) {
          emit(const LinkAccountWithCredentialSuccessful());
        },
      );
    });
  }
}
