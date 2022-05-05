
import 'package:deep_shop/cubit/app/app_states.dart';
import 'package:deep_shop/models/cart_model.dart';
import 'package:deep_shop/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../cubit/app/app_cubit.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates >(
        listener: (context, state) {},
        builder:(context, state) {

            return
              Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
                body:(state is! AppLoadingGetCartState && AppCubit
                  .get(context)
                  .cartModel != null)
    ? Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text('Cart',
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
                                  builtCartItem(AppCubit
                                      .get(context)
                                      .cartModel
                                      ?.data
                                      ?.cart_items![index] as CartItemModel, context),
                              itemCount: AppCubit
                                  .get(context)
                                  .cartModel
                                  ?.data
                                  ?.cart_items
                                  !.length ?? 0
                          ),
                        ) ,
                        Container(height: 1,
                        color: Colors.grey,) ,
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Card(
                            shadowColor:HexColor('589ac7') ,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Total Price is ${AppCubit.get(context).cartModel?.data!.total.round()}'),
                                  SizedBox(
                                    width: 20,
                                  ) ,
                                  SizedBox(
                                    height: 50,
                                    child: MaterialButton(
                                      color: HexColor('589ac7'),
                                      shape:RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18)),
                                      onPressed: () {},
                                      child: Text(
                                        "CheckOut".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                )


            : Center(child: CircularProgressIndicator(),)
          );
        }
    );

  }

  Widget builtCartItem(CartItemModel? model , context) =>  GestureDetector(
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
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Image(
                        image: NetworkImage('${model!.product?.image! }') ,
                        height: 120,
                        width: 120,
                      ),
                      CircleAvatar(

                          backgroundColor: Colors.grey[100],
                          radius: 10,
                          child: Text('${model.quantity}' , style: TextStyle(fontWeight: FontWeight.bold , color:   HexColor('589ac7')),)
                      )
                    ],
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20 , right: 20 , left: 20 , bottom: 10),
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
                            '${model.product?.price!.round() } ',
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
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            height: 50,
                            width: 58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color:AppCubit.get(context).carts[model.product!.id] as bool  ?  HexColor('589ac7') : Colors.white,
                              border: Border.all(
                                color: AppCubit.get(context).carts[model.product!.id] as bool  ? Colors.white : HexColor('589ac7'),
                              ),
                            ),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                "assets/icons/add_to_cart.svg",
                                color: AppCubit.get(context).carts[model.product!.id] as bool  ? Colors.white : HexColor('589ac7'),
                              ),
                              onPressed: () {
                                AppCubit.get(context).changeCart(model.product?.id);

                              },
                            ),
                          )


                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  ) ;

}