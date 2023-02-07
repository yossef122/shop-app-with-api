import 'package:shop_app/models/Login_shop/loginModel.dart';

abstract class login_states {}

class loginIntialStates extends login_states{}

class loginLooadingStates extends login_states{}

class loginsuccessStates extends login_states{
  LoginModel login;
  loginsuccessStates( this.login);

}
class loginerrorStates extends login_states{
  final String error;
  loginerrorStates(this.error);
}

class ChangePassVisibilityState extends login_states{}
