import 'package:deep_shop/cubit/app/app_cubit.dart';
import 'package:deep_shop/cubit/app/app_states.dart';
import 'package:deep_shop/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class CategoryScreen extends StatelessWidget{
  final  model;

  const CategoryScreen({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state) {
        print(state);
      },
      builder: (context , state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor('589ac7'),
            elevation: 0,
            leading: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/back.svg',
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: <Widget>[
              IconButton(
                icon: SvgPicture.asset("assets/icons/cart.svg"),
                onPressed: () {},
              ),
              SizedBox(width: 10)
            ],
          ),
          body:(state is SearchSuccessState ||state is AppLoadingGetFavoriteState ||state is AppChangeFavoriteState ||state is AppSuccessChangeFavoriteState|| state is AppSuccessGetFavoriteState)
        ?SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10 ,bottom: 10 , right: 20 , left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(image: NetworkImage('${model.image}') ,height: 80 , width: 80,) ,
                          Spacer(),
                          Text('${model.name}',
                            style: TextStyle(
                                fontSize: 24 ,
                                fontWeight: FontWeight.w800 ,
                                color: HexColor('589ac7')
                            ),),
                        ],
                      ),
                    ),
                  ) ,
                  Container(
                    color: Colors.grey[300],
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1 / 1.6,
                      children: List.generate( AppCubit
                          .get(context)
                          .model
                          ?.data
                          ?.data
                          .length as int,
                              (index) => CategoryGridItem(AppCubit
                              .get(context)
                              .model
                              ?.data
                              ?.data[index],
                              context) ),
                    ),
                  )
                ],
              ),
            ),
          )
          : Center(child: CircularProgressIndicator(),)
        ) ;
      },
    );
  }

  Widget CategoryGridItem (model , context){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailsScreen(
                          product: model)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),

          child:   Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Hero(
                    tag: '${model?.id}',
                    child: Image(
                      image: NetworkImage('${model?.image! }') ,
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                /*  if(model?.discount! != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT' ,
                        style: TextStyle(
                            fontSize: 8 ,
                            color: Colors.white
                        ),
                      ),
                    )*/
                ],
              ) ,
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model?.name!}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14 ,
                          height: 1.3
                      ),

                    ) ,
                    Row(
                      children: [
                        Text(
                          '${model?.price!.round() }',
                          style: TextStyle(
                              fontSize: 12 ,
                              height: 1.3 ,
                              color: HexColor('589ac7')
                          ),

                        ),
                        SizedBox( width: 5,) ,
                       /* if(model?.discount! != 0)
                          Text(
                            '${model?.old_price!.round() }',
                            style: TextStyle(
                                fontSize: 10 ,
                                color: Colors.grey ,
                                decoration: TextDecoration.lineThrough
                            ),

                          ),*/
                        Spacer() ,
                        IconButton(
                          onPressed: (){
                            AppCubit.get(context).changeFavorite(model?.id);
                          },
                          icon: CircleAvatar(

                              backgroundColor: AppCubit.get(context).favorites[model?.id] as bool ? Colors.red : Colors.grey,
                              radius: 15,
                              child: Icon(
                                Icons.favorite_border ,
                                size: 14,
                                color: Colors.white,
                              )
                          ),
                        )

                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    )  ;
  }


}