
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/network/endPoints.dart';
import 'package:shop_app/Shared/network/remotly/diohelper.dart';
import 'package:shop_app/layout/shop_cubit/ShopStates.dart';
import 'package:shop_app/models/Favourite_model/Favourite_Model.dart';
import 'package:shop_app/models/Favourite_model/new_fav_Data.dart';
import 'package:shop_app/models/Home_model/Home_model.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/setting_model/setting_model.dart';
import 'package:shop_app/modules/Favourite_screen/Favourite_screen.dart';
import 'package:shop_app/modules/Home_screen/Home_screen.dart';
import 'package:shop_app/modules/categrie_screen/categories_screen.dart';
import 'package:shop_app/modules/setting_screen/Setting_Screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(Shopitialstate());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> Screen = [
    const Homescreen(),
    const CategorieScreen(),
     FavouriteScreen(),
    SettingScreen()
  ];

  void ChangeNavBarIndex(int index) {
    current_Index1 = index;
    emit(ChangebottomNavBarState());
  }

  HomeModel? homemodel;
  Map<int?, bool> favourite = {};

  void getDataHome() {
    emit(ShopLoadingState());
    // var data;
    diohelper.get(path: Home, token: token).then((value) {
      // Map<String,dynamic>decode=jsonDecode(value.data);
      //  data=new Map<String,dynamic>.from(value.data);
      // printfullText(value.data);
      homemodel = HomeModel.fromJson(value.data);
      // print(homemodel?.data!.banners[1].image);
      // print(homemodel?.status);
      for (var element in homemodel!.data!.products) {
        favourite.addAll({element.id: element.in_favorites});
      }
      // print(favourite);
      emit(ShopGettingdataSuccessState());
    }).catchError((error) {
      // printfullText(data);
      print(error.toString());
      emit(ShopGettingdataErrorState(error.toString()));
    });
  }

  categoriesModel? categorie;

  void getcategoriesHome() {
    // var data;
    diohelper.get(path: categories, token: token).then((value) {
      categorie = categoriesModel.fromJson(value.data);
      emit(ShopGettingcategoriesSuccessState());
    }).catchError((error) {
      // printfullText(data);
      print(error.toString());
      emit(ShopGettingcategoriesErrorState(error.toString()));
    });
  }

  late ChangeFavourite_Model CFavouriteModel;

   ChangeFavourite(int? id) async {
    emit(ShopChangeFavouriteloadingState());
    favourite[id] =
        !(favourite[id] != null && favourite[id] == true ? true : false);
    emit(ShopChangeFavSuccessState());

    diohelper.postData(
        path: Favorites, token: token, data: {'product_id': id}).then((value) {
      CFavouriteModel = ChangeFavourite_Model.fromJson(value.data);
      // print(value.data);
      if (!CFavouriteModel.status) {
        favourite[id] =
            !(favourite[id] != null && favourite[id] == true ? true : false);
      } else {
        // getfavouritEHome();
        getFavouriteData();
      }
      emit(ShopChangeFavouriteSuccessState(CFavouriteModel));
    }).catchError((error) {
      favourite[id] =
          !(favourite[id] != null && favourite[id] == true ? true : false);

      print(error.toString());
      emit(ShopChangeFavouriteErrorState(error.toString()));
    });
  }


  // FavouritesModel? favouritE;
  // void getfavouritEHome() {
  //   emit(ShopGettingfavouriteLoadingState());
  //   diohelper.get(
  //       path: Favorites,
  //       token: token
  //   ).then((value) {
  //
  //     favouritE = FavouritesModel.fromJson(value.data);
  //     // print(value.data);
  //     emit(ShopGettingfavouriteSuccessState());
  //
  //   }).catchError((error) {
  //     print(favouritE);
  //
  //     print(error.toString());
  //     emit(ShopGettingfavouriteErrorState(error.toString()));
  //   });
  // }


  FavouritesModel? favouritesModel;

   getFavouriteData()  {
      emit(ShopGettingfavouriteLoadingState());
    diohelper.get(
        path: Favorites, token: token).then((value) {
      // print(value.data.toString());
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopGettingfavouriteSuccessState());
    }).catchError((error) {
      // print(favouritesModel!.data!.data.toString());
        print(error.toString());
      emit(ShopGettingfavouriteErrorState(error.toString()));
    });
  }


  UserDataSetting? userData;

   getUserData() async {
      emit(ShopGettingUserLoadingState());
    diohelper.get(
        path: Profile,
        token: token
    ).then((value) {
      userData = UserDataSetting.fromJson((value.data));
      emit(ShopGettingUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopGettingUserErrorState(error.toString()));
    });
  }

  UpadateUserData(
      {
        required String name,
        required String phone,
        required String email,
    }
      ) async {
      emit(ShopUpadateUserLoadingState());
    diohelper.PutData(
        path: update_profile,
        token: token,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        }
    ).then((value) {
      userData = UserDataSetting.fromJson(value.data);
      emit(ShopUpadateUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopUpadateUserErrorState(error.toString()));
    });
  }
}
