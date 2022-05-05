import 'package:deep_shop/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_states.dart';
import '../shared/companats.dart';
import 'package:deep_shop/shared/network/local/cach_helper.dart';

class ResetPassword extends StatelessWidget {
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String? email = cachHelper.getData(key: 'email');
  String? code = cachHelper.getData(key: 'code');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
        if (state is SuccessResetPasswordState) {
          if (state.passwordModel.status!) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> routes) => false);
          } else {
            showToast(msg: state.passwordModel.message!);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reset Your Password',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.black87)),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      maxLines: 1,
                      obscureText: LoginCubit.get(context).isPassword,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(LoginCubit.get(context).suffix),
                            onPressed: () {
                              LoginCubit.get(context).passwordIconChange();
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Password';
                        }
                      },
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          LoginCubit.get(context).resetPassword(
                              email: email!,
                              code: code!,
                              password: passwordController.text);
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultBotton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).resetPassword(
                                email: email!,
                                code: code!,
                                password: passwordController.text);
                          }
                        },
                        text: 'Reset Password ',
                        background: HexColor('589ac7'))
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
