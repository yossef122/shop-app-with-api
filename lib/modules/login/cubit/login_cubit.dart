import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/network/remotly/diohelper.dart';
import 'package:shop_app/models/Login_shop/loginModel.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';

import '../../../Shared/network/endPoints.dart';

class login_Cubit extends Cubit<login_states> {
  login_Cubit() : super(loginIntialStates());

  static login_Cubit get(context) => BlocProvider.of(context);
  void UserLogin(
  {
  required String Email,
  required String password,
}
      ) {

  LoginModel login;
    emit(loginLooadingStates());

    diohelper.postData(
        path: Login,
        data: {
      'email':Email,
      'password':password
      }).then((value) {
      // print(value.data);
      login= LoginModel.fromJson(value.data);
      emit(loginsuccessStates(login));
    }
    ).catchError((error) {
      print(error);
      emit(loginerrorStates(error.toString()));
    });
  }


  IconData ChangePassVisibility(){
    emit(ChangePassVisibilityState());
   return ispass ?Icons.visibility_outlined:Icons.visibility_off_outlined;
  }
}
