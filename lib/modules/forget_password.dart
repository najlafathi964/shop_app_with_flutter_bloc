import 'package:deep_shop/cubit/login/login_cubit.dart';
import 'package:deep_shop/cubit/login/login_states.dart';
import 'package:deep_shop/modules/verfiy_code.dart';
import 'package:deep_shop/shared/companats.dart';
import 'package:deep_shop/shared/network/local/cach_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgetPassword extends StatelessWidget {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
        if (state is SuccessForgetPasswordState) {
          if (state.passwordModel.status!) {
            cachHelper
                .saveData(key: 'email', value: emailController.text)
                .then((value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerifyCode(),
                  ));
            });
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
                    Text('Verfiy Your Email',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.black87)),
                    SizedBox(
                      height: 20,
                    ),
                    defultFormFieled(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context)
                                .forgetPassword(email: emailController.text);
                          }
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Your Email Address';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined),
                    SizedBox(
                      height: 20,
                    ),
                    (state is! LoadingForgetPasswordState)
                   ? defaultBotton(
                        function: () {
                          //if (formKey.currentState!.validate()) {
                            LoginCubit.get(context)
                                .forgetPassword(email: emailController.text);
                         // }
                        },
                        text: 'Verify Email',
                        background: HexColor('589ac7'))
                        :Center(child:  CircularProgressIndicator(),)
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
