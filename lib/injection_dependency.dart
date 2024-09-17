import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_cooking/features/authentication/data/datasources/firebase_authentication.dart';
import 'package:happy_cooking/features/authentication/data/repositories/user_authentication_repository_impl.dart';
import 'package:happy_cooking/features/authentication/domain/repositories/user_authentication_repository.dart';
import 'package:happy_cooking/features/authentication/domain/usecases/user_authentication.dart';
import 'package:happy_cooking/features/authentication/presentation/bloc/authentication/signup_user/signup_user_bloc.dart';
import 'package:happy_cooking/features/phone_vertify/data/datasources/email_vertify_firebase.dart';
import 'package:happy_cooking/features/phone_vertify/data/datasources/phone_vertify_firebase.dart';
import 'package:happy_cooking/features/phone_vertify/data/datasources/sms_vertify_firebase.dart';
import 'package:happy_cooking/features/phone_vertify/data/repositories/email_vertify_repository_impl.dart';
import 'package:happy_cooking/features/phone_vertify/data/repositories/phone_vertify_repository_impl.dart';
import 'package:happy_cooking/features/phone_vertify/data/repositories/sms_vertify_repository_impl.dart';
import 'package:happy_cooking/features/phone_vertify/domain/repositories/email_vertify_repository.dart';
import 'package:happy_cooking/features/phone_vertify/domain/repositories/phone_vertify_repository.dart';
import 'package:happy_cooking/features/phone_vertify/domain/repositories/sms_vertify_repository.dart';
import 'package:happy_cooking/features/phone_vertify/domain/usecases/email_vertify_usecase.dart';
import 'package:happy_cooking/features/phone_vertify/domain/usecases/phone_vertify_usecase.dart';
import 'package:happy_cooking/features/phone_vertify/domain/usecases/sms_vertify_usecase.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/bloc/email_vertify/email_vertify_bloc.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/bloc/phone_vertify/phone_vertify_bloc.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/bloc/sms_vertify/sms_vertify_bloc.dart';
import 'features/authentication/presentation/bloc/authentication/login_method/login_method_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  ///* Authentication
  ///
  sl.registerSingleton<LoginWithEmailFirebase>(const LoginWithEmailFirebase());

  sl.registerSingleton<LoginWithGoogleFirebase>(const LoginWithGoogleFirebase());

  sl.registerSingleton<LoginAsGuestFirebase>(const LoginAsGuestFirebase());

  sl.registerSingleton<SignupUserFirebase>(SignupUserFirebase());

  sl.registerSingleton<LogoutFirebase>(const LogoutFirebase());

  sl.registerSingleton<ResetpasswordFirebase>(const ResetpasswordFirebase());

  sl.registerSingleton<LoginWithEmailRepository>(LoginWithEmailRepositoryImpl(sl()));

  sl.registerSingleton<LoginWithGoogleRepository>(LoginWithGoogleRepositoryImpl(sl()));

  sl.registerSingleton<LoginAsGuestRepository>(LoginAsGuestRepositoryImpl(sl()));

  sl.registerSingleton<SignupUserRepository>(SignupUserRepositoryImpl(sl()));

  sl.registerSingleton<LogoutUserRepository>(LogoutUserRepositoryImpl(sl()));

  sl.registerSingleton<ResetPasswordRepository>(ResetPasswordRepositoryImpl(sl()));

  sl.registerSingleton<LoginWithEmailUseCase>(LoginWithEmailUseCase(sl()));

  sl.registerSingleton<LoginWithGoogleUseCase>(LoginWithGoogleUseCase(sl()));

  sl.registerSingleton<LoginAsGuestUseCase>(LoginAsGuestUseCase(sl()));

  sl.registerSingleton<SignupEmailUseCase>(SignupEmailUseCase(sl()));

  sl.registerSingleton<LogoutUseCase>(LogoutUseCase(sl()));

  sl.registerSingleton<ResetPasswordUseCase>(ResetPasswordUseCase(sl()));

  sl.registerSingleton<VertifyWithEmailUseCase>(VertifyWithEmailUseCase(sl()));

  sl.registerFactory<LoginMethodBloc>(() => LoginMethodBloc(sl(), sl(), sl()));

  sl.registerFactory<SignupUserBloc>(() => SignupUserBloc(sl()));

  ///* Phone Verification
  ///
  sl.registerSingleton<PhoneVertifyFirebase>(PhoneVertifyFirebase());

  sl.registerSingleton<EmailVertifyFirebase>(EmailVertifyFirebase());

  sl.registerSingleton<PhoneVertifySMSCodeFirebase>(PhoneVertifySMSCodeFirebase());

  sl.registerSingleton<PhoneVertifyRepository>(PhoneVertifyRepositoryImpl(sl()));

  sl.registerSingleton<PhoneVertifySMSCodeRepository>(PhoneVertifySMSCodeRepositoryImpl(sl()));

  sl.registerSingleton<EmailVertifyRepository>(EmailVertifyRepositoryImpl(sl()));

  sl.registerSingleton<PhoneVertifyUseCase>(PhoneVertifyUseCase(sl()));

  sl.registerSingleton<EmailVertifyUseCase>(EmailVertifyUseCase(sl()));

  sl.registerSingleton<PhoneVertifySMSCodeUseCase>(PhoneVertifySMSCodeUseCase(sl()));

  sl.registerFactory<PhoneVertifyBloc>(() => PhoneVertifyBloc(sl()));

  sl.registerFactory<EmailVertifyBloc>(() => EmailVertifyBloc(sl()));

  sl.registerFactory<PhoneVertifySMSCodeBloc>(() => PhoneVertifySMSCodeBloc(sl()));
}
