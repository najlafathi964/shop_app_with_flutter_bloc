import '../../models/user_model.dart';

abstract class RegisterState{}
class RegisterInitialState extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {
  final UserModel userModel ;
  RegisterSuccessState(this.userModel) ;
}
class RegisterErrorState extends RegisterState {
  final String error ;
  RegisterErrorState(this.error);

}
class RegisterPasswordIconChanged extends RegisterState{}