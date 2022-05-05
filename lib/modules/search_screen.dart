
import 'package:deep_shop/cubit/app/app_states.dart';
import 'package:deep_shop/screens/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deep_shop/shared/companats.dart';

import '../cubit/app/app_cubit.dart';
import '../models/search_model.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>() ;
  TextEditingController searchController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit , AppStates >(
        listener: (context, state) {
        },
        builder: (context , state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defultFormFieled(
                      controller: searchController,
                      type: TextInputType.text,
                      onSubmit: (text) {
                        AppCubit.get(context).getSearch(text);
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Text To Search';
                        }
                      },
                      label: 'search',
                      prefix: Icons.search
                  ),
                  SizedBox(height: 10,),
                  if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                  if(state is SearchSuccessState ||state is AppLoadingGetFavoriteState ||state is AppChangeFavoriteState ||state is AppSuccessChangeFavoriteState|| state is AppSuccessGetFavoriteState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) =>
                              builtSearchItem(AppCubit
                                  .get(context)
                                  .model
                                  ?.data
                                  ?.data[index],
                                  context),
                          separatorBuilder: (context, index) =>
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  color: Colors.grey,
                                  child: SizedBox(height: 1,)),
                          itemCount: AppCubit
                              .get(context)
                              .model
                              ?.data
                              ?.data
                              .length as int
                      ),
                    )
                ],
              ),
            ),
          );
        }
          );


  }

  Widget builtSearchItem(Product? model , context) =>  Padding(
    padding: const EdgeInsets.all(20),
    child: GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsScreen(
                        product: model!)));
      },
      child: Container(
        height: 120,
        color: Colors.white,
        child:   Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model?.image! }') ,
                  height: 120,
                  width: 120,
                ),

              ],
            ) ,
            SizedBox( width: 20,) ,
            Expanded(
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
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model?.price!.round() }',
                        style: TextStyle(
                            fontSize: 12 ,
                            height: 1.3 ,
                            color: Colors.deepOrange
                        ),

                      ),
                      SizedBox( width: 5,) ,

                      Spacer() ,
                      IconButton(
                        onPressed: (){
                          AppCubit.get(context).changeFavorite(model?.id);

                        },
                        icon: CircleAvatar(

                            backgroundColor: AppCubit.get(context).favorites[model?.id] as bool ? Colors.deepOrange : Colors.grey,
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
  ) ;


}