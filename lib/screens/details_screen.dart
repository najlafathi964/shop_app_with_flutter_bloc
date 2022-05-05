import 'package:deep_shop/cubit/app/app_cubit.dart';
import 'package:deep_shop/cubit/app/app_states.dart';
import 'package:deep_shop/modules/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';


class DetailsScreen extends StatelessWidget {
  final  product;

  const DetailsScreen({Key? key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates >(
      listener: (context,state){},
      builder:(context,state) {
        AppCubit.get(context).initShow(product);
        return Scaffold(
          // each product have a color
          backgroundColor: HexColor('589ac7'),
          appBar: buildAppBar(context),
          body: body(context),
        );
      }
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CartScreen()));
          },
        ),
        SizedBox(width: 10)
      ],
    );
  }

  Widget body (context){
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.05,
                    left: 20,
                    right: 20,
                  ),
                  height: size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //ColorAndSize(product: product!),
                        // SizedBox(height: kDefaultPaddin / 2),
                        RichText(
                          text: TextSpan(
                            text: "Description",
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),

                        ) ,
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: AppCubit.get(context).secondHalf!.isEmpty
                                ?Text('${AppCubit.get(context).firstHalf}',
                              style: TextStyle(height: 1.5),
                              textDirection: TextDirection.rtl,
                            )
                                :Column(
                              children: [
                                Text(AppCubit.get(context).flag ?('${AppCubit.get(context).firstHalf} ...'):('${AppCubit.get(context).firstHalf} ${AppCubit.get(context).secondHalf}') , textDirection: TextDirection.rtl,) ,
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        AppCubit.get(context).flag ? 'show more' : 'show less',
                                        style: TextStyle(
                                            color: Colors.blueGrey
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: (){
                                    AppCubit.get(context).showMore();
                                  },
                                )

                              ],
                            )
                        ) ,
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 40,
                                  height: 32,
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                    ),

                                    child: OutlinedButton(

                                      onPressed: () {
                                        AppCubit.get(context).minCount();
                                      },
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    // if our item is less  then 10 then  it shows 01 02 like that
                                    AppCubit.get(context).numOfItems.toString().padLeft(2, "0"),
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  height: 32,
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    padding: EdgeInsets.zero,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                    ),

                                    child: OutlinedButton(

                                      onPressed: () {
                                        AppCubit.get(context).plusCount();

                                        },
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                )
                              ],
                            ) ,
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeFavorite(product?.id);
                              },
                              icon: CircleAvatar(

                                  backgroundColor: AppCubit.get(context).favorites[product?.id] as bool ? Colors.deepOrange : Colors.grey,
                                  radius: 35,
                                  child: Icon(
                                    Icons.favorite_border ,
                                    size: 20,
                                    color: Colors.white,
                                  )
                              ),
                            )
                          ],
                        ) ,
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              height: 50,
                              width: 58,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color:AppCubit.get(context).carts[product!.id] as bool  ?  HexColor('589ac7') : Colors.white,
                                border: Border.all(
                                  color: AppCubit.get(context).carts[product!.id] as bool  ? Colors.white : HexColor('589ac7'),
                                ),
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/add_to_cart.svg",
                                  color: AppCubit.get(context).carts[product!.id] as bool  ? Colors.white : HexColor('589ac7'),
                                ),
                                onPressed: () {
                                  AppCubit.get(context).changeCart(product?.id);

                                },
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: MaterialButton(
                                  color: HexColor('589ac7'),
                                  shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  onPressed: () {},
                                  child: Text(
                                    "Buy  Now".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name as String,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white, fontWeight: FontWeight.bold ),
                      ),
                      SizedBox(height: 25),

                      Row(
                        children: <Widget>[

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: "Price\n"),
                                TextSpan(
                                  text: "\$${product.price}",
                                  style: Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5,) ,
                          if(product.discount != 0 && product.discount != null)
                            Text(
                              '${product.old_price?.round() }',
                              style: TextStyle(
                                  fontSize: 15 ,
                                  color: Colors.red ,
                                  decoration: TextDecoration.lineThrough
                              ),

                            ) ,
                          Spacer() ,
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: Hero(

                                    tag: "${product.id}",
                                    child: Image(
                                      image: NetworkImage( product.image as String,

                                      ),
                                      fit: BoxFit.fill,

                                    ),
                                  ),
                                ),
                                if(product.discount != 0 && product.discount != null)
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
                                  ) ,
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
