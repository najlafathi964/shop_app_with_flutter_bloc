import 'package:deep_shop/screens/home_screen.dart';
import 'package:deep_shop/screens/login_screen.dart';
import 'package:deep_shop/shared/companats.dart';
import 'package:deep_shop/shared/network/local/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:deep_shop/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/app/app_cubit.dart';
import 'cubit/app/app_states.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  dioHelper.init();
  await cachHelper.init();
  Widget widget;

  token = cachHelper.getData(key: 'token');
  if (token != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {

  Widget widget ;
  MyApp(this.widget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        .. getHomeData()
        .. getCategoriesData()
        ..getFavoriteData()
      ..getProfileData()
      ..getCartData()
,
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context,state){},
          builder: (context , state ){
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lets go and Shopping',
          theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Color(0xFF535353)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: widget,
          );
          }
      ),
    );
  }
}