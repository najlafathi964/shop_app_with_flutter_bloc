import 'package:deep_shop/models/cart_model.dart';
import 'package:deep_shop/models/change_cart_model.dart';

import '../../models/change_favorite_model.dart';
import '../../models/user_model.dart';

abstract class AppStates{}
class InitialAppState extends AppStates{}
class AppChangeBottomSatate extends AppStates{}

class AppChangeCategorySatate extends AppStates{}

class AppLoadingHomeDataState extends AppStates {}
class AppSuccessHomeDataState extends AppStates {}
class AppErrorHomeDataState extends AppStates {}


class AppSuccessCategoriesDataState extends AppStates {}
class AppErrorCategoriesDataState extends AppStates {}


class AppChangeFavoriteState extends AppStates {}
class AppSuccessChangeFavoriteState extends AppStates {
  final ChangeFavoriteModel model ;

  AppSuccessChangeFavoriteState(this.model);

}
class AppErrorChangeFavoriteState extends AppStates {}


class AppLoadingGetFavoriteState extends AppStates {}
class AppSuccessGetFavoriteState extends AppStates {}
class AppErrorGetFavoriteState extends AppStates {}

class AppLoadingProfileState extends AppStates {}
class AppSuccessGetProfileState extends AppStates {
  final UserModel userModel ;

  AppSuccessGetProfileState(this.userModel);
}
class AppErrorGetProfileState extends AppStates {}

class AppLoadingUpdateProfileState extends AppStates {}
class AppSuccessUpdateProfileState extends AppStates {
  final UserModel userModel ;

  AppSuccessUpdateProfileState(this.userModel);
}
class AppErrorUpdateProfileState extends AppStates {}

class SearchLoadingState extends AppStates {}
class SearchSuccessState extends AppStates {}
class SearchErrorState extends AppStates {}

class LoadingImageFromGallery extends AppStates {}
class SuccessImageFromGallery extends AppStates {}
class ErrorImageFromGallery extends AppStates{}

class SuccessShowMoreState extends AppStates{}

class PlusCounterState extends AppStates{}
class MinCounterState extends AppStates{}

class AppChangeCartState extends AppStates {}
class AppSuccessChangeCartState extends AppStates {
final ChangeCartModel model ;

AppSuccessChangeCartState(this.model);

}
class AppErrorChangeCartState extends AppStates {}


class AppLoadingGetCartState extends AppStates {}
class AppSuccessGetCartState extends AppStates {}
class AppErrorGetCartState extends AppStates {}


class AppLoadingUpdateCartState extends AppStates {}
class AppSuccessUpdateCartState extends AppStates {
  final CartModel cartModel ;

  AppSuccessUpdateCartState(this.cartModel);
}
class AppErrorUpdateCartState extends AppStates {}