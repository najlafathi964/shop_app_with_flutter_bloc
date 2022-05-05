import 'package:deep_shop/models/user_model.dart';

import '../../models/password_model.dart';

abstract class LoginStates {}
class LoginInitialState extends LoginStates {}
class RefreshScreenState extends LoginStates{}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  final UserModel userModel ;
  LoginSuccessState(this.userModel) ;
}
class LoginErrorState extends LoginStates {}

class PasswordIconChanged extends LoginStates{}

class LoadingForgetPasswordState extends LoginStates {}
class SuccessForgetPasswordState extends LoginStates {
  PasswordModel passwordModel ;
  SuccessForgetPasswordState(this.passwordModel) ;
}
class ErrorForgetPasswordState extends LoginStates {}

class LoadingVerifyCodeState extends LoginStates {}
class SuccessVerifyCodeState extends LoginStates {
  VerfiyCode verfiyCode ;
  SuccessVerifyCodeState(this.verfiyCode);
}
class ErrorVerifyCodeState extends LoginStates {}

class LoadingResetPasswordState extends LoginStates {}
class SuccessResetPasswordState extends LoginStates {
  PasswordModel passwordModel ;
  SuccessResetPasswordState(this.passwordModel) ;
}
class ErrorResetPasswordState extends LoginStates {}