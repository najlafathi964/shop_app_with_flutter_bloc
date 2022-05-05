
import 'package:deep_shop/cubit/app/app_states.dart';
import 'package:deep_shop/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../cubit/app/app_cubit.dart';
import '../models/favorite_model.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates >(
        listener: (context, state) {},
        builder:(context, state) {
          if (state is! AppLoadingGetFavoriteState && AppCubit
              .get(context)
              .favoriteModel != null) {
            return
              Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text('Favorites',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: HexColor('589ac7')
                          ),),
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                builtFavItem(AppCubit
                                    .get(context)
                                    .favoriteModel
                                    ?.data
                                    ?.data[index], context),
                             itemCount: AppCubit
                                .get(context)
                                .favoriteModel
                                ?.data
                                ?.data
                                .length as int
                        ),
                      )
                    ],
                  )
              );
          }else{
            return Center(child: CircularProgressIndicator(),) ;
          }
        }
    );

  }

  Widget builtFavItem(FavDataModel? model , context) =>  GestureDetector(
    onTap: (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailsScreen(
                      product: model!.product)));
    },
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10 ,right: 10 , left: 10 ),
      child: Card(
        color: Colors.black12,
        shadowColor: HexColor('589ac7'),
        elevation: 3,
        child: Container(
          height: 130,
          color: Colors.white,
          child:   Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model!.product?.image! }') ,
                    height: 120,
                    width: 120,
                  ),
                  if(model.product?.discount! != 0)
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
                    )
                ],
              ) ,
              SizedBox( width: 20,) ,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product?.name!}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14 ,
                          height: 1.3
                      ),

                    ) ,
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product?.price!.round() }',
                          style: TextStyle(
                              fontSize: 12 ,
                              height: 1.3 ,
                              color: HexColor('589ac7')
                          ),

                        ),
                        SizedBox( width: 5,) ,
                        if(model.product?.discount! != 0)
                          Text(
                            '${model.product?.old_price!.round() }',
                            style: TextStyle(
                                fontSize: 10 ,
                                color: Colors.grey ,
                                decoration: TextDecoration.lineThrough
                            ),

                          ),
                        Spacer() ,
                        IconButton(
                          onPressed: (){
                            AppCubit.get(context).changeFavorite(model.product!.id);
                          },
                          icon: CircleAvatar(

                              backgroundColor: AppCubit.get(context).favorites[model.product!.id] ?? true ? Colors.red : Colors.grey,
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
    ),
  ) ;

}