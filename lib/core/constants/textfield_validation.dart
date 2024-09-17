import 'package:form_validator/form_validator.dart';

final fieldRequiredBuilder = ValidationBuilder()..required();

final fieldRequiredValidator = fieldRequiredBuilder.build();

final emailValidatorBuilder = ValidationBuilder()..email();

final emailValidator = emailValidatorBuilder.build();

final passwordValidatorBuilder = ValidationBuilder()
  ..minLength(6)
  ..regExp(RegExp(r'^(?=.*?[A-Z]).+$'), "At least one UPPER CASE")
  ..regExp(RegExp(r'^(?=.*?[a-z]).+$'), "At least one lower case")
  ..regExp(RegExp(r'^(?=.*?[0-9]).+$'), "At least one number");

final passwordValidator = passwordValidatorBuilder.build();

final usernameBuilder = ValidationBuilder()..required();

final usernameValidator = usernameBuilder.build();

final phoneBuilder = ValidationBuilder()..phone();

final phoneValidator = phoneBuilder.build();
