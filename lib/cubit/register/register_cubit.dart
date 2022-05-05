
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deep_shop/cubit/register/register_state.dart';
import 'package:deep_shop/shared/network/remote/dio_helper.dart';
import '../../models/user_model.dart';
import '../../shared/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());


  static RegisterCubit get(context) => BlocProvider.of(context);

  UserModel? userModel ;
  void userRegister({required String email , required String password , required String name , required String phone}) {
    emit(RegisterLoadingState());
    dioHelper.postData(
        url: REGISTER,
        data: {
          'email': email,
          'password': password ,
          'name' : name ,
          'phone' : phone
        }
    ).then((value){
      userModel =UserModel.fromJson(value.data);
      emit(RegisterSuccessState(userModel!));
    }).catchError((error){
      emit(RegisterErrorState(error));
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
    emit(RegisterPasswordIconChanged());

  }
}