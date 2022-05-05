import 'package:deep_shop/cubit/app/app_states.dart';
import 'package:deep_shop/modules/category_screen.dart';
import 'package:deep_shop/shared/companats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../cubit/app/app_cubit.dart';
import '../models/categories_model.dart';
import '../models/home_model.dart';
import '../screens/details_screen.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is AppSuccessChangeFavoriteState) {
        if (!state.model.status) {
          showToast(msg: state.model.message!);
        }
      }
    }, builder: (context, state) {
      return AppCubit.get(context).homeModel != null &&
              AppCubit.get(context).categoriesModel != null
          ? productsBuilder(AppCubit.get(context).homeModel,
              AppCubit.get(context).categoriesModel, context)
          : Center(child: CircularProgressIndicator());
    });
  }

  Widget productsBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: HexColor('589ac7')),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                buildCategoriesItem(
                                    categoriesModel?.data?.data[index],
                                    index,
                                    context),

                            itemCount:
                                categoriesModel?.data?.data.length as int),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'New Products',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: HexColor('589ac7')),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1 / 1.62,
                  children: List.generate(
                      model?.data?.products?.length as int,
                      (index) => buildGridProduct(
                          model?.data?.products?[index], context)),
                ),
              )
            ],
          ),
        ),
      );

  Widget buildCategoriesItem(DataModel? model, int index, context) =>
      GestureDetector(
        onTap: () {
          AppCubit.get(context).getSearch('${model!.name}');

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryScreen(model: model)));
        },
        child:  Card(
          elevation: 3,
          shadowColor: HexColor('589ac7') ,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage('${model?.image}'),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Container(
                child: Text(
                  '${model?.name}',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                color: HexColor('589ac7'),
                width: 100,
              )
            ],
          ),
        ),
      );

  Widget buildGridProduct(ProductModel? model, context) => GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsScreen(product: model)));
    },
    child: Card(
      elevation: 3,
      shadowColor: HexColor('589ac7'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Hero(
                tag: '${model?.id}',
                child: Image(
                  image: NetworkImage('${model?.image!}'),
                  height: 200,
                  width: double.infinity,
                ),
              ),
              if (model?.discount! != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model?.name!}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model?.price!.round()}',
                      style: TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          color:HexColor('589ac7')),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model?.discount! != 0)
                      Text(
                        '${model?.old_price!.round()}',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeFavorite(model?.id);
                      },
                      icon: CircleAvatar(
                          backgroundColor: AppCubit.get(context)
                                  .favorites[model?.id] as bool
                              ? Colors.red
                              : Colors.grey,
                          radius: 15,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
