
import 'package:deep_shop/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deep_shop/cubit/app/app_cubit.dart';
import 'package:deep_shop/cubit/app/app_states.dart';
import 'package:deep_shop/shared/companats.dart';
import 'package:deep_shop/shared/network/local/cach_helper.dart';
import 'package:hexcolor/hexcolor.dart';



class SettingScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var model = AppCubit.get(context).userModel ;

          if(AppCubit.get(context).userModel != null) {
            nameController.text = model?.data?.name as String;
            emailController.text = model?.data?.email as String;
            phoneController.text = model?.data?.phone as String;
            print('gallary image ${AppCubit.get(context).image}') ;
            print('network image ${model?.data?.image}');

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is AppLoadingUpdateProfileState)
                        LinearProgressIndicator() ,
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child:
                        AppCubit.get(context).image == null
                       ?CircleAvatar(
                          backgroundImage:NetworkImage('${model?.data!.image! }')

                            )
                            : Image.file(AppCubit.get(context).image! ,
                        height: 150 ,
                        width: 150,)
              ) ,
                      CircleAvatar(
                          child: IconButton(icon:Icon(Icons.camera_alt_outlined) , onPressed: (){
                            AppCubit.get(context).pickImage() ;
                          //  PickedFile
                          }, )),
                    ],
                  ),
                ) ,

                      SizedBox( height: 20,) ,
                      defultFormFieled(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty ';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person
                      ),
                      SizedBox(height: 20,),
                      defultFormFieled(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty ';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email
                      ),
                      SizedBox(height: 20,),
                      defultFormFieled(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be empty ';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone
                      ),SizedBox(height: 20,) ,
                      defaultBotton(
                          function: (){
                            if(formKey.currentState!.validate()) {
                              AppCubit.get(context).updateProfileData(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: 'update profile' ,
                          isUpperCase: true
                      ,background: HexColor('589ac7')) ,
                      SizedBox(height: 20,) ,
                      defaultBotton(
                          function: (){
                            signOut(context);
                          },
                          text: 'Log Out' ,
                          isUpperCase: true ,
                      background: HexColor('589ac7'))
                    ],
                  ),
                ),
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(),) ;
          }
        }
    );
  }

  void signOut(context){
    cachHelper.removeData(key: 'token').then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen()),
                (Route<dynamic> routes) => false);
      }
    });
  }


}