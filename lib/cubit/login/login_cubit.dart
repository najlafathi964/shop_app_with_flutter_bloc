import 'package:deep_shop/cubit/login/login_states.dart';
import 'package:deep_shop/models/password_model.dart';
import 'package:deep_shop/models/user_model.dart';
import 'package:deep_shop/shared/network/end_points.dart';
import 'package:deep_shop/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());


  static LoginCubit get(context) => BlocProvider.of(context);


  UserModel? userModel ;
  void userLogin({required String email , required String password}) {
    emit(LoginLoadingState());

    dioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': password
        }
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(LoginSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString()) ;
      emit(LoginErrorState());
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true ;

  void passwordIconChange () {
    isPassword = !isPassword ;
    if(isPassword){
      suffix = Icons.visibility_outlined ;
    }else{
      suffix = Icons.visibility_off_outlined ;

    }
    emit(PasswordIconChanged());

  }
  PasswordModel? passwordModel ;

  void forgetPassword({required String email}){
    emit(LoadingForgetPasswordState()) ;
    dioHelper.postData(
        url: 'verify-email',
        data: {
          'email':email
        }).then((value) {
      passwordModel = PasswordModel.fromJson(value.data) ;
      emit(SuccessForgetPasswordState(passwordModel!)) ;
    }).catchError((error){
      emit(ErrorForgetPasswordState());
    }) ;
  }

  VerfiyCode? verfiyCodeModel ;

  void verifyCode({required String email , required String code}){
    emit(LoadingVerifyCodeState()) ;
    dioHelper.postData(
        url: 'verify-code',
        data: {
          'email':email ,
          'code':code
        }).then((value) {
      verfiyCodeModel = VerfiyCode.fromJson(value.data) ;
      emit(SuccessVerifyCodeState(verfiyCodeModel!) );
    }).catchError((error){
      emit(ErrorVerifyCodeState());
    }) ;
  }

  void refresh(){
    emit(RefreshScreenState());
  }


  void resetPassword({required String email , required String code , required String password}){
    emit(LoadingResetPasswordState()) ;
    dioHelper.postData(
        url: 'reset-password',
        data: {
          'email':email,
          'code':code,
          'password':password
        }).then((value) {
      passwordModel = PasswordModel.fromJson(value.data) ;
      emit(SuccessResetPasswordState(passwordModel!)) ;
    }).catchError((error){
      emit(ErrorResetPasswordState());
    }) ;
  }
}