
import 'package:shop_app/models/Login_shop/loginModel.dart';

abstract class Register_states {}

class RegisterIntialStates extends Register_states{}

class RegisterLooadingStates extends Register_states{}

class RegistersuccessStates extends Register_states{
  LoginModel Register;
  RegistersuccessStates( this.Register);

}
class RegistererrorStates extends Register_states{
  final String error;
  RegistererrorStates(this.error);
}

class ChangePassVisibilityState extends Register_states{}
