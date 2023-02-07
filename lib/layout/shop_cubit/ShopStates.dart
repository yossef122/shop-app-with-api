
import 'package:shop_app/models/Favourite_model/Favourite_Model.dart';

abstract class ShopStates {}

class Shopitialstate extends ShopStates{}

class ChangebottomNavBarState extends ShopStates{}

class ShopLoadingState extends ShopStates{}

class ShopGettingdataSuccessState extends ShopStates{}

class ShopGettingdataErrorState extends ShopStates{
  final error;

  ShopGettingdataErrorState(this.error);

}

class ShopGettingcategoriesSuccessState extends ShopStates{}

class ShopGettingcategoriesErrorState extends ShopStates{
  final error;

  ShopGettingcategoriesErrorState(this.error);
}

class ShopChangeFavSuccessState extends ShopStates{}

class ShopChangeFavouriteloadingState extends ShopStates{}

class ShopChangeFavouriteSuccessState extends ShopStates{

  ChangeFavourite_Model model;
  ShopChangeFavouriteSuccessState(this.model);
}

class ShopChangeFavouriteErrorState extends ShopStates{
  final error;

  ShopChangeFavouriteErrorState(this.error);
}

class ShopGettingfavouriteSuccessState extends ShopStates{}

class ShopGettingfavouriteLoadingState extends ShopStates{}

class ShopGettingfavouriteErrorState extends ShopStates{
  final error;

  ShopGettingfavouriteErrorState(this.error);
}

class ShopGettingUserSuccessState extends ShopStates{}

class ShopGettingUserLoadingState extends ShopStates{}

class ShopGettingUserErrorState extends ShopStates{
  final error;

  ShopGettingUserErrorState(this.error);
}

class ShopUpadateUserSuccessState extends ShopStates{}

class ShopUpadateUserLoadingState extends ShopStates{}

class ShopUpadateUserErrorState extends ShopStates{
  final error;

  ShopUpadateUserErrorState(this.error);
}