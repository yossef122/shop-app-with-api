import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/network/remotly/diohelper.dart';
import 'package:shop_app/models/Login_shop/loginModel.dart';
import 'package:shop_app/modules/register/cubit/Register_states.dart';

import '../../../Shared/network/endPoints.dart';

class Register_Cubit extends Cubit<Register_states> {
  Register_Cubit() : super(RegisterIntialStates());

  static Register_Cubit get(context) => BlocProvider.of(context);
 late LoginModel Register;

  void UserRegister({
    required String name,
    required String Email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLooadingStates());

        diohelper.postData(
            path: register,
            data: {
                  'name': name,
                  'email': Email,
                  'password': password,
                  'phone': phone
        }).then((value) {
          // print(value.data);
          // print(Register!.data!.name);
          Register = LoginModel.fromJson(value.data);
          emit(RegistersuccessStates(Register));
        }).catchError((error) {
          // print(Register!.data!.name);
          print(error);
          emit(RegistererrorStates(error.toString()));
        });
  }

  IconData ChangePassVisibility() {
    emit(ChangePassVisibilityState());
    return ispass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  }
}
