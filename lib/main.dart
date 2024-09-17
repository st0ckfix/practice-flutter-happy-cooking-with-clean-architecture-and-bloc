import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/config/routes/authentication_routes.dart';
import 'package:happy_cooking/config/routes/full_routes.dart';
import 'package:happy_cooking/config/theme/app_theme.dart';
import 'package:happy_cooking/features/authentication/presentation/bloc/authentication/login_method/login_method_bloc.dart';
import 'package:happy_cooking/features/authentication/presentation/bloc/authentication/signup_user/signup_user_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:happy_cooking/features/authentication/presentation/pages/welcome_screen.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/bloc/phone_vertify/phone_vertify_bloc.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/bloc/sms_vertify/sms_vertify_bloc.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/cubit/count_cubit.dart';
import 'firebase_options.dart';
import 'injection_dependency.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginMethodBloc>(create: (context) => sl()),
        BlocProvider<PhoneVertifySMSCodeBloc>(create: (context) => sl()),
        BlocProvider<SignupUserBloc>(create: (context) => sl()),
        BlocProvider<PhoneVertifyBloc>(create: (context) => sl()),
        BlocProvider<CountCubit>(create: (context) => CountCubit()),
      ],
      child: const MyApp(),
    ),
  );

  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomAppTheme().lightTheme,
      darkTheme: CustomAppTheme().darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AuthRoutes.auth,
      getPages: FullRoutes.routes,
      home: const WelcomeScreen(),
    );
  }
}
