import 'package:deep_shop/cubit/login/login_cubit.dart';
import 'package:deep_shop/cubit/login/login_states.dart';
import 'package:deep_shop/modules/reset_password.dart';
import 'package:deep_shop/shared/companats.dart';
import 'package:deep_shop/shared/network/local/cach_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class VerifyCode extends StatelessWidget {
  var firstNum = TextEditingController();
  var secNum = TextEditingController();
  var thirdNum = TextEditingController();
  var fourthNum = TextEditingController();

 String? email = cachHelper.getData(key: 'email');
  String? code ;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            print('state $state');

            if(state is SuccessVerifyCodeState){
              if (state.verfiyCode.status!) {
                cachHelper.saveData(key: 'code', value: code)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResetPassword(),
                      ));
                });
              }else {
                showToast(msg: state.verfiyCode.message!);
                LoginCubit.get(context).refresh();
              }
            }
          },
          builder: (context , state) {
            return  Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all( 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Verfiy Code',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black87)),
                      SizedBox(height: 20,) ,
                      Form(
                        key: formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 80,
                              width: 60,
                              child: TextFormField(
                                controller: firstNum,
                                maxLength: 1,
                                onChanged: (value){
                                  if(value.length == 1){
                                    FocusScope.of(context).nextFocus();
                                  }
                                },

                                decoration: InputDecoration(
                                    hintText: '0',
                                    hintMaxLines: 1,
                                    counterText: '',
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,

                              ),
                            ),

                            Container(
                              height: 80,
                              width: 60,
                              child: TextFormField(
                                controller: secNum,
                                maxLength: 1,
                                onChanged: (value){
                                  if(value.length == 1){
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: '0',
                                    counterText: '',
                                    hintMaxLines: 1,
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,

                              ),
                            ),

                            Container(
                              height: 80,
                              width: 60,
                              child: TextFormField(
                                controller: thirdNum,
                                maxLength: 1,
                                onChanged: (value){
                                  if(value.length == 1){
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: '0',
                                    counterText: '',
                                    hintMaxLines: 1,
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,

                              ),
                            ),

                            Container(
                              height: 80,
                              width: 60,
                              child: TextFormField(
                                controller: fourthNum,
                                maxLength: 1,
                                onChanged: (value){
                                  if(value.length == 1){
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (bin){},
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    counterText: '',
                                    hintMaxLines: 1,
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            ],
                        ),
                      ) ,
                      SizedBox( height: 20,) ,
                      (state is SuccessVerifyCodeState || state is LoadingVerifyCodeState)
                          ?Center(child:  CircularProgressIndicator(),)
                :defaultBotton(
                  function: (){
            code= firstNum.text + secNum.text +thirdNum.text + fourthNum.text;

            if (formKey.currentState!.validate()) {
            LoginCubit.get(context).verifyCode(
            email: email!, code: code!);
            } },
                text: 'Verify Code',
                background: HexColor('589ac7'))


                    ],
                  ),
                ),
              ),
            ) ;
          }
      ),
    );
  }

}