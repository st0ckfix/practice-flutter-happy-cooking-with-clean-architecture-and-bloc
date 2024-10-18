import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_cooking/features/authentication/data/datasources/login_with_credential_firebase.dart';
import 'package:happy_cooking/features/authentication/data/datasources/login_with_email_firebase.dart';
import 'package:happy_cooking/features/authentication/data/repositories/login_with_credentail_repository_impl.dart';
import 'package:happy_cooking/features/authentication/data/repositories/login_with_email_repository_impl.dart';
import 'package:happy_cooking/features/authentication/data/repositories/request_google_credential_repository_impl.dart';
import 'package:happy_cooking/features/authentication/data/repositories/sign_up_with_email_repository_impl.dart';
import 'package:happy_cooking/features/authentication/domain/repositories/login_with_credential_repository.dart';
import 'package:happy_cooking/features/authentication/domain/repositories/login_with_email_repository.dart';
import 'package:happy_cooking/features/authentication/presentation/bloc/authentication/signup_user/signup_user_bloc.dart';
import 'package:happy_cooking/features/profile/data/datasources/update_image_firebase.dart';
import 'package:happy_cooking/features/profile/data/datasources/update_password_firebase.dart';
import 'package:happy_cooking/features/profile/data/datasources/update_username_firebase.dart';
import 'package:happy_cooking/features/profile/data/repositories/update_image_repository_impl.dart';
import 'package:happy_cooking/features/profile/data/repositories/update_password_repository_impl.dart';
import 'package:happy_cooking/features/profile/data/repositories/update_username_repository_impl.dart';
import 'package:happy_cooking/features/profile/domain/repositories/update_image_repository.dart';
import 'package:happy_cooking/features/profile/domain/repositories/update_password_repository.dart';
import 'package:happy_cooking/features/profile/domain/repositories/update_username_repository.dart';
import 'package:happy_cooking/features/profile/domain/usecases/update_password_use_case.dart';
import 'package:happy_cooking/features/profile/presentation/bloc/logout/logout_bloc.dart';
import 'package:happy_cooking/features/profile/presentation/bloc/update_image/update_image_bloc.dart';
import 'package:happy_cooking/features/profile/presentation/bloc/update_username/update_username_bloc.dart';
import 'core/domain/repository/authentication_repository.dart';
import 'features/authentication/data/datasources/request_google_credential_firebase.dart';
import 'features/authentication/data/datasources/signup_user_with_email_firebase.dart';
import 'features/authentication/domain/repositories/signup_with_email_repository.dart';
import 'features/authentication/domain/usecases/login_with_email_use_case.dart';
import 'features/authentication/domain/usecases/login_with_phone_use_case.dart';
import 'features/authentication/domain/usecases/request_google_credential_use_case.dart';
import 'features/authentication/domain/usecases/signup_with_email_use_case.dart';
import 'features/authentication/presentation/bloc/authentication/login_method/login_method_bloc.dart';
import 'features/profile/data/datasources/link_account_with_credential_firebase.dart';
import 'features/profile/data/datasources/logout_firebase.dart';
import 'features/profile/data/repositories/link_account_with_credential_repository_impl.dart';
import 'features/profile/data/repositories/logout_repository_impl.dart';
import 'features/profile/domain/repositories/link_account_with_credential_repository.dart';
import 'features/profile/domain/repositories/logout_repository.dart';
import 'features/profile/domain/usecases/link_account_with_email_use_case.dart';
import 'features/profile/domain/usecases/link_account_with_google_use_case.dart';
import 'features/profile/domain/usecases/link_account_with_phone_use_case.dart';
import 'features/profile/domain/usecases/logout_use_case.dart';
import 'features/profile/domain/usecases/update_image_use_case.dart';
import 'features/profile/domain/usecases/update_username_use_case.dart';
import 'features/profile/presentation/bloc/link_account_with_credential/link_account_with_credential_bloc.dart';
import 'features/vertify/data/datasources/vertify_email_firebase.dart';
import 'features/vertify/data/datasources/vertify_phone_firebase.dart';
import 'features/vertify/data/repositories/vertify_email_repository_impl.dart';
import 'features/vertify/data/repositories/vertify_phone_repository_impl.dart';
import 'features/vertify/domain/repositories/vertify_email_repository.dart';
import 'features/vertify/domain/repositories/vertify_phone_repository.dart';
import 'features/vertify/domain/usecases/vertify_email_usecase.dart';
import 'features/vertify/domain/usecases/vertify_phone_usecase.dart';
import 'features/vertify/presentation/bloc/vertify_email/vertify_email_bloc.dart';
import 'features/vertify/presentation/bloc/vertify_phone/vertify_phone_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  ///* Authentication
  ///
  sl.registerSingleton<LoginWithCredentialFirebase>(LoginWithCredentialFirebase());

  sl.registerSingleton<LoginWithEmailFirebase>(LoginWithEmailFirebase());

  sl.registerSingleton<RequestGoogleCredentialFirebase>(RequestGoogleCredentialFirebase());

  sl.registerSingleton<SignUpWithEmailFirebase>(SignUpWithEmailFirebase());

  sl.registerSingleton<LoginWithCredentialRepository>(LoginWithCredentailRepositoryImpl(sl()));

  sl.registerSingleton<LoginWithEmailRepository>(LoginWithEmailRepositoryImpl(sl()));

  sl.registerSingleton<RequestGoogleCredentialRepository>(RequestGoogleCredentialRepositoryImpl(sl()));

  sl.registerSingleton<SignupWithEmailRepository>(SignUpWithEmailRepositoryImpl(sl()));

  sl.registerSingleton<LoginWithEmailUseCase>(LoginWithEmailUseCase(sl()));

  sl.registerSingleton<RequestGoogleCredentialUseCase>(RequestGoogleCredentialUseCase(sl(), sl()));

  sl.registerSingleton<SignupWithEmailUseCase>(SignupWithEmailUseCase(sl()));

  sl.registerSingleton<LoginWithPhoneUseCase>(LoginWithPhoneUseCase(sl()));

  sl.registerFactory<LoginMethodBloc>(() => LoginMethodBloc(sl(), sl(), sl()));

  sl.registerFactory<SignupUserBloc>(() => SignupUserBloc(sl()));

  ///* Verification
  ///
  sl.registerSingleton<VertifyPhoneFirebase>(VertifyPhoneFirebase());

  sl.registerSingleton<VertifyEmailFirebase>(VertifyEmailFirebase());

  sl.registerSingleton<VertifyPhoneRepository>(VertifyPhoneRepositoryImpl(sl()));

  sl.registerSingleton<VertifyEmailRepository>(VertifyEmailRepositoryImpl(sl()));

  sl.registerSingleton<VertifyPhoneUseCase>(VertifyPhoneUseCase(sl()));

  sl.registerSingleton<VertifyEmailUseCase>(VertifyEmailUseCase(sl()));

  sl.registerFactory<VertifyPhoneBloc>(() => VertifyPhoneBloc(sl()));

  sl.registerFactory<VertifyEmailBloc>(() => VertifyEmailBloc(sl()));

  ///* Profile
  ///
  sl.registerSingleton<LogoutFirebase>(LogoutFirebase());

  sl.registerSingleton<LogoutRepository>(LogoutRepositoryImpl(sl()));

  sl.registerSingleton<LogoutUseCase>(LogoutUseCase(sl()));

  sl.registerSingleton<LinkAccountWithCredentialFirebase>(LinkAccountWithCredentialFirebase());

  sl.registerSingleton<LinkAccountWithCredentialRepository>(LinkAccountWithCredentialRepositoryImpl(sl()));

  sl.registerSingleton<LinkAccountWithPhoneUseCase>(LinkAccountWithPhoneUseCase(sl()));

  sl.registerSingleton<LinkAccountWithEmailUseCase>(LinkAccountWithEmailUseCase(sl()));

  sl.registerSingleton<LinkAccountWithGoogleUseCase>(LinkAccountWithGoogleUseCase(sl(), sl()));

  sl.registerFactory<LinkAccountWithCredentialBloc>(() => LinkAccountWithCredentialBloc(sl(), sl(), sl()));

  sl.registerSingleton<UpdateImageFirebase>(UpdateImageFirebase());

  sl.registerSingleton<UpdatePasswordFirebase>(UpdatePasswordFirebase());

  sl.registerSingleton<UpdateUsernameFirebase>(UpdateUsernameFirebase());

  sl.registerSingleton<UpdateImageRepository>(UpdateImageRepositoryImpl(sl()));

  sl.registerSingleton<UpdatePasswordRepository>(UpdatePasswordRepositoryImpl(sl()));

  sl.registerSingleton<UpdateUsernameRepository>(UpdateUsernameRepositoryImpl(sl()));

  sl.registerSingleton<UpdateUsernameUseCase>(UpdateUsernameUseCase(sl()));

  sl.registerSingleton<UpdatePasswordUseCase>(UpdatePasswordUseCase(sl()));

  sl.registerSingleton<UpdateImageUseCase>(UpdateImageUseCase(sl()));

  sl.registerFactory<UpdateImageBloc>(() => UpdateImageBloc(sl()));

  sl.registerFactory<UpdateUsernameBloc>(() => UpdateUsernameBloc(sl()));

  sl.registerFactory<LogoutBloc>(() => LogoutBloc(sl()));
}
