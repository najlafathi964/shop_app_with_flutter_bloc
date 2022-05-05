
import 'package:deep_shop/cubit/app/app_cubit.dart';
import 'package:deep_shop/cubit/app/app_states.dart';
import 'package:deep_shop/modules/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates >(
      listener: (context, state) {} ,
      builder: (context,state){
        var cubit = AppCubit.get(context) ;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Home'),
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [

              IconButton(
                icon: SvgPicture.asset('assets/icons/cart.svg', color: HexColor('589ac7'),),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CartScreen()));
                },
              ) ,
              SizedBox(width: 10,)
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){cubit.changeBottom(index: index) ; },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home) ,
                  backgroundColor : HexColor('589ac7') ,
                  label: 'Home'
              ) ,
              BottomNavigationBarItem(
                  icon: Icon(Icons.search) ,
                  backgroundColor : HexColor('589ac7') ,
                  label: 'Search'
              ) ,
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite) ,
                  backgroundColor: HexColor('589ac7'),
                  label: 'Favorite'
              ) ,
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings) ,
                  backgroundColor : HexColor('589ac7') ,
                  label: 'Stettings'
              ) ,
            ],
          ),
        );
      },


    );
  }
  


}