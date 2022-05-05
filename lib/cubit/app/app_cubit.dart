import 'dart:io';

import 'package:deep_shop/models/cart_model.dart';
import 'package:deep_shop/models/change_cart_model.dart';
import 'package:deep_shop/models/change_favorite_model.dart';
import 'package:deep_shop/modules/product_screen.dart';
import 'package:deep_shop/modules/search_screen.dart';
import 'package:deep_shop/modules/settings_screen.dart';
import 'package:deep_shop/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deep_shop/cubit/app/app_states.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/categories_model.dart';
import '../../models/favorite_model.dart';
import '../../models/home_model.dart';
import '../../models/search_model.dart';
import '../../models/user_model.dart';
import '../../modules/favourit_screen.dart';
import '../../shared/companats.dart';
import '../../shared/network/end_points.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialAppState());


  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomScreens = [
    ProductScreen()  ,
    SearchScreen() ,
    FavouriteScreen() ,
    SettingScreen ()
  ];

  int currentIndex = 0;
  void changeBottom({required int index}) {
    currentIndex = index ;
    emit(AppChangeBottomSatate());
  }


  Map<int,bool> favorites = {} ;
  Map<int,bool> carts = {} ;//id
  HomeModel? homeModel ;
  void getHomeData(){
    emit(AppLoadingHomeDataState());
    dioHelper.getData(
        url: 'home' ,
        token: token
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //   print('home model =  ${homeModel?.data?.products?[0].name}') ;
      //   print('status ${homeModel?.status}');

      homeModel?.data?.products?.forEach((element) {
        favorites.addAll({
          element.id as int: element.in_favorites as bool
        });
      }) ;

      homeModel?.data?.products?.forEach((element) {
        carts.addAll({
          element.id as int : element.in_cart as bool
        }) ;
      }) ;
      emit(AppSuccessHomeDataState());
    }).catchError((error){
      print('error $error') ;
      emit(AppErrorHomeDataState());
    });


  }

  CategoriesModel? categoriesModel ;
  void getCategoriesData(){
    dioHelper.getData(
        url: 'categories' ,
        token: token).then((value) {
      categoriesModel = CategoriesModel.formJson(value.data);
      // print("catat ${categoriesModel?.data?.data[0].name}") ;
      emit(AppSuccessCategoriesDataState());
    }).catchError((error){
      emit(AppErrorCategoriesDataState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel ;
  void changeFavorite (int? productId){
    favorites[productId!] = !favorites[productId]!;
    emit(AppChangeFavoriteState());

    dioHelper.postData(
        url: 'favorites',
        data: {'product_id': productId} , //حسب ال api
        token: token).then((value){
      changeFavoriteModel= ChangeFavoriteModel.fromJson(value.data) ;
      if(!changeFavoriteModel!.status){
        favorites[productId] = !favorites[productId]!;

      }else {
        getFavoriteData();
      }
      emit(AppSuccessChangeFavoriteState(changeFavoriteModel!));
    }).catchError((error){
      favorites[productId] = !favorites[productId]!;
      emit(AppErrorChangeFavoriteState()) ;

    });
  }

  FavoriteModel? favoriteModel ;
  void getFavoriteData(){
    emit(AppLoadingGetFavoriteState());
    dioHelper.getData(
        url: 'favorites' ,
        token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(AppSuccessGetFavoriteState());
    }).catchError((error){
      emit(AppErrorGetFavoriteState());
    });
  }
  ChangeCartModel? changeCartModel ;
  void changeCart (int? productId){
    carts[productId!] = !carts[productId]!;
    emit(AppChangeCartState());

    dioHelper.postData(
        url: 'carts',
        data: {'product_id': productId} , //حسب ال api
        token: token).then((value){
      changeCartModel= ChangeCartModel.fromJson(value.data) ;
      if(!changeCartModel!.status){
        carts[productId] = !carts[productId]!;

      }else {
        getCartData();
      }
      emit(AppSuccessChangeCartState(changeCartModel!));
    }).catchError((error){
      carts[productId] = !carts[productId]!;
      emit(AppErrorChangeCartState()) ;

    });
  }

  CartModel? cartModel ;
  void getCartData(){
    emit(AppLoadingGetCartState());
    dioHelper.getData(
        url: 'carts' ,
        token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);

      emit(AppSuccessGetCartState());
    }).catchError((error){
      emit(AppErrorGetCartState());
    });
  }
  UserModel? userModel ;
  void getProfileData(){
    emit(AppLoadingProfileState());
    dioHelper.getData(
        url: 'profile' ,
        token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel?.data?.name) ;
      emit(AppSuccessGetProfileState(userModel!));
    }).catchError((error){
      print('error');
      emit(AppErrorGetProfileState());
    });
  }

  void updateProfileData({
    required String email ,
    required String name ,
    required String phone ,

  }){
    emit(AppLoadingUpdateProfileState());

    dioHelper.putData(
        url: UPDATE_PROFILE ,
        data: {
          'name' :name ,
          'email' : email ,
          'phone' : phone
        },
        token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(AppSuccessUpdateProfileState(userModel!));
    }).catchError((error){
      emit(AppErrorUpdateProfileState());
    });
  }
  void updateCartData({
    required int id ,
    required int quantity ,

  }){
    emit(AppLoadingUpdateCartState());

    dioHelper.putData(
        url: 'carts/$id' ,
        data: {
          'quantity' :quantity ,
        },
        token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      print(value.data);
      emit(AppSuccessUpdateCartState(cartModel!));
    }).catchError((error){
      print('error $error');
      emit(AppErrorUpdateCartState());
    });
  }
  SearchModel? model ;
  void getSearch (String text){
    emit(SearchLoadingState());
    dioHelper.postData(
        url: SEARCH ,
        data: {
          'text' : text
        },
        token: token ) .then((value){
      model = SearchModel.fromJson(value.data) ;
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
  }
 File? image ;
  Future pickImage() async{
    try {
      emit(LoadingImageFromGallery());
      print('pick image');
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
      emit(SuccessImageFromGallery());
    } on PlatformException catch (e){
      print(e);
      emit(ErrorImageFromGallery());
    }

  }
   String? firstHalf ;
   String? secondHalf ;
   bool flag = true ;
   void initShow(product) {
    if (product.description!.length > 300) {
      firstHalf = product.description!.substring(0, 300);
      secondHalf =
          product.description!.substring(300, product.description!.length);
    } else {
      firstHalf = product.description;
      secondHalf = "";
    }
  }

  void showMore (){

    flag = !flag ;
    emit(SuccessShowMoreState());


  }

  int numOfItems =1 ;
 void plusCount(){
   numOfItems++;
 emit (PlusCounterState());
 }

 void minCount(){
   if (numOfItems > 1) {
       numOfItems--;

       emit(MinCounterState()) ;
   }
 }

}
